//
//  MineViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "MineViewController.h"
#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import "ScoreViewController.h"
#import "FavorViewController.h"
#import "BackgroundImageCollectionViewController.h"

#define CELL_IDENTIFY @"CELL"


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray * titleNameArray;
@property (strong, nonatomic) NSArray * titleImageArray;

@end

@implementation MineViewController

-(NSArray *)titleNameArray
{
    if (!_titleNameArray) {
        _titleNameArray = [NSArray array];
    }
    return _titleNameArray;
}

-(NSArray *)titleImageArray
{
    if (!_titleImageArray) {
        _titleImageArray = [NSArray array];
    }
    return _titleImageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dota_dt0"]];
    [self userRefresh:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefresh:) name:USER_REFRESH_NOTICE object:nil];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBGImage:) name:@"changeBackgroundImage" object:nil];
}

-(void)changeBGImage:(NSNotification *)notif
{
    NSData * data = notif.object;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:data]];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:@"changeBackgroundImage"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//刷新用户信息
-(void)userRefresh:(NSNotification *)notif
{
    //获取到本地的用户名
    BmobUser * user = [BmobUser getCurrentUser];
    
    if (user) {
        self.userName.text = user.username;
        NSString * urlStr = [user objectForKey:@"userIconUrl"];
        NSString * imgUrl = [user objectForKey:@"bgImage"];
        
        if (urlStr == nil) {
            self.userIcon.image = [UIImage imageNamed:@"avatar_default_big"];
            return;
        }
        else
        {
            
            [BmobImage cutImageBySpecifiesTheWidth:100 height:100 quality:50 sourceImageUrl:urlStr outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {
                BmobFile * resfile = object;
                NSString * resUrl = resfile.url;
                
                [self.userIcon sd_setImageWithURL:[NSURL URLWithString:resUrl]];
            }];
        }
        
        if (imgUrl == nil) {
            self.view.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dota_dt0"]];
            return;
        }
        else
        {
            [BmobImage cutImageBySpecifiesTheWidth:SCREEN_SIZE.width height:SCREEN_SIZE.height quality:50 sourceImageUrl:imgUrl outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {
                BmobFile * resfile = object;
                NSString * resUrl = resfile.url;
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resUrl]]]];
            }];
        }
    }
    
    else
    {
        self.userName.text = @"点击头像登录";
        self.userIcon.image = [UIImage imageNamed:@"avatar_default_big"];
    }
}


#pragma mark - 手势响应方法
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    UIViewController * VC = nil;
    
    if ([BmobUser getCurrentUser]) {
        //跳转用户详情
        UserInfoViewController * userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
        VC = userInfoVC;
    }
    else
    {
        //跳转登录
        LoginViewController * loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        VC = loginVC;
    }
    UINavigationController * navi = self.sideMenuViewController.contentViewController.childViewControllers.firstObject;
    
    [self.sideMenuViewController hideMenuViewController];
    
    [navi pushViewController:VC animated:YES];
}

#pragma mark - 添加数据

-(void)addData
{
    self.titleNameArray = @[@"我的战绩", @"背景封面", @"清除缓存"];
    self.titleImageArray = @[@"mine_icon_score", @"mine_icon_background", @"mine_icon_setting"];
}

#pragma mark - UITableViewDataSource/Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleNameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFY];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFY];
    }
    
//    cell.frame = CGRectMake(-SCREEN_SIZE.width, 0, SCREEN_SIZE.width, 50);
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = self.titleNameArray[indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];
    cell.imageView.image = [UIImage imageNamed:self.titleImageArray[indexPath.row]];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            ScoreViewController * VC = [[ScoreViewController alloc]init];
            UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:VC];
            VC.title = @"战绩查询";
            [self presentViewController:navi animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            BackgroundImageCollectionViewController * VC = [[BackgroundImageCollectionViewController alloc]initWithCollectionViewLayout:[[UICollectionViewLayout alloc]init]];
            
            UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:VC];
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        case 2:
        {
            [self clearCache];
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma 清除缓存

-(void)clearCache
{
    //缓存文件的个数
    NSInteger disCount = [SDImageCache sharedImageCache].getDiskCount;
    
    NSUInteger cacheSize = [SDImageCache sharedImageCache].getSize;
    
    float cache = (float)cacheSize / (1024 * 1024);
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"清楚缓存" message:[NSString stringWithFormat:@"缓存文件数量：%ld, 缓存文件大小：%.3fMB", disCount, cache] preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加action
    UIAlertAction * canncel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:canncel];
    
    UIAlertAction * clearAction = [UIAlertAction actionWithTitle:@"清除缓存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [[SDImageCache sharedImageCache] clearDisk];
    }];
    [alertController addAction:clearAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}





@end
