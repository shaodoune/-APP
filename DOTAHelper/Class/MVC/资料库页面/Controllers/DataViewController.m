//
//  DataViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/9.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "DataViewController.h"
#import "HeroViewController.h"
#import "GoodsViewController.h"

@interface DataViewController ()

@property (nonatomic, strong) UIButton * button;

@end

@implementation DataViewController

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
    [self createUI];
    [self customNavigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefresh:) name:USER_REFRESH_NOTICE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    self.tagItemSize = CGSizeMake(SCREEN_SIZE.width / 2, 40);
    self.normalTitleFont = [UIFont systemFontOfSize:12];
    self.selectedTitleFont = [UIFont systemFontOfSize:14];
    self.tagItemGap = 0;
    
    NSArray * titleArray = @[@"英雄", @"物品"];
    NSArray * classNameArray = @[[HeroViewController class],
                                 [GoodsViewController class]
                                 ];
    
    CGSize size = [titleArray[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.selectedIndicatorSize = CGSizeMake(size.width, 3);
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNameArray];
    
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


@end
