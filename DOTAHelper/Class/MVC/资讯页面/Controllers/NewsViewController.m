//
//  NewsViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "NewsViewController.h"
#import "FirstTableViewController.h"
#import "NewsZeroViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong) UIButton * button;

@end

@implementation NewsViewController

-(instancetype)init
{
    self = [super initWithTagViewHeight:40];
    if (self) {
        
    }
    return self;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, 40, 40);
        self.button.layer.cornerRadius = 20;
        self.button.clipsToBounds = YES;
    }
    return _button;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationBar];
    [self createUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefresh:) name:USER_REFRESH_NOTICE object:nil];
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
        NSString * urlStr = [user objectForKey:@"userIconUrl"];
        
        if (urlStr == nil) {
            [self.button setImage:[UIImage imageNamed:@"avatar_default_big"] forState:UIControlStateNormal];
            return;
        }
        else
        {
            
            [BmobImage cutImageBySpecifiesTheWidth:100 height:100 quality:50 sourceImageUrl:urlStr outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {
                BmobFile * resfile = object;
                NSString * resUrl = resfile.url;
                
                [self.button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resUrl]]] forState:UIControlStateNormal];
//                [self.userIcon sd_setImageWithURL:[NSURL URLWithString:resUrl]];
            }];
        }
    }
    
    else
    {
        [self.button setImage:[UIImage imageNamed:@"avatar_default_big"] forState:UIControlStateNormal];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:USER_REFRESH_NOTICE];
}


#pragma mark - 实现页面切换的效果

-(void)createUI
{
    self.tagItemSize = CGSizeMake(SCREEN_SIZE.width / 4, 40);
    self.normalTitleFont = [UIFont systemFontOfSize:12];
    self.selectedTitleFont = [UIFont systemFontOfSize:14];
    self.tagItemGap = 0;
    
    NSArray * titleArray = @[@"全部资讯", @"刀塔新闻", @"赛事资讯", @"版本公告"];
    NSArray * classNameArray = @[[FirstTableViewController class],
                                 [NewsZeroViewController class],
                                 [NewsZeroViewController class],
                                 [NewsZeroViewController class],
                                 ];
    
    NSArray * params = @[@"hotnewsList", @"govnews/index", @"matchnews/index", @"vernews/index"];
    
    CGSize size = [titleArray[0] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    self.selectedIndicatorSize = CGSizeMake(size.width, 3);
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNameArray withParams:params];
    
}



-(void)customNavigationBar
{
    UINavigationItem * item = self.navigationItem;
    [self.button setImage:[[UIImage imageNamed:@"avatar_default_big"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(presentLeft) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    
    item.leftBarButtonItem = left;
        [self userRefresh:nil];
}

-(void)presentLeft
{
    [self.tabBarController.sideMenuViewController presentLeftMenuViewController];
}



@end
