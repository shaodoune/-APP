//
//  RootTabBarController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "RootTabBarController.h"
#import "BoxViewController.h"
#import "DataViewController.h"
#import "NewsViewController.h"
#import "VideoRootViewController.h"
#import "DOTATabBar.h"
#import <PopMenu.h>
#import "TTViewController.h"
#import "BZViewController.h"



@interface RootTabBarController ()

@property (nonatomic, strong) DOTATabBar * dotaTabBar;

@property (nonatomic, strong) PopMenu * popMenu;


@end

@implementation RootTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCustomTabBar];
    
    [self addViewControllers];
    
    // Do any additional setup after loading the view.
}

- (PopMenu *)popMenu
{
    if (_popMenu == nil) {
        
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titleArr = @[@"视频直播",@"天梯排行",@"DOTA2壁纸"];
        NSArray *imgNameArr = @[@"tabbar_compose_idea",
                                @"tabbar_compose_weibo",
                                @"tabbar_compose_photo",];
        for (int i = 0; i < titleArr.count; i++) {
            MenuItem *item = [[MenuItem alloc] initWithTitle:titleArr[i] iconName:imgNameArr[i] glowColor:[UIColor clearColor]];
            [items addObject:item];
        }
        
        _popMenu = [[PopMenu alloc] initWithFrame:[UIScreen mainScreen].bounds items:items];
        
        __weak typeof(self) weakSelf = self;
        
        _popMenu.didSelectedItemCompletion = ^ (MenuItem * item) {
            
//            NSLog(@"%ld", item.index);
            switch (item.index) {
                case 0:
                {
                    VideoRootViewController * vedioVC = [[VideoRootViewController alloc]init];
                    vedioVC.title = item.title;
                    [weakSelf.selectedViewController pushViewController:vedioVC animated:YES];
                }
                    break;
                case 1:
                {
                    TTViewController *ttVC = [[TTViewController alloc]init];
                    ttVC.title = item.title;
                    [weakSelf.selectedViewController pushViewController:ttVC animated:YES];
                }
                    break;
                case 2:
                {
                    BZViewController * bzVC = [[BZViewController alloc]initWithCollectionViewLayout:[[UICollectionViewLayout alloc]init]];
                    [weakSelf.selectedViewController pushViewController:bzVC animated:YES];
                }
                    
                default:
                    break;
            }
        };
    }
    return _popMenu;
}

-(void)addCustomTabBar
{
    self.dotaTabBar = [[DOTATabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 49)];
    
    __weak typeof(self) weakSelf = self;
    self.dotaTabBar.passIndex = ^(NSInteger index){
        weakSelf.selectedIndex = index;
    };
    self.dotaTabBar.bBlock = ^ {
        // 显示弹出界面
        [weakSelf.popMenu showMenuAtView:weakSelf.view];
    };
    
    [self.tabBar addSubview:self.dotaTabBar];
    self.dotaTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg"]];
}

-(void)addViewControllers
{
    NSArray * VCNameArray = @[@"NewsViewController", @"DataViewController"];
    NSArray * VCTitleArray = @[@"资讯", @"资料库"];
    NSArray * normalImageArray = @[@"tab_zx", @"tab_zlk"];
    NSArray * selectedImageArray = @[@"tab_zxon", @"tab_zlkon"];
    
    for (int i = 0; i < VCNameArray.count; i++) {

        Class VCClass = NSClassFromString(VCNameArray[i]);
        
        UIViewController * VC = [[VCClass alloc]init];
        VC.title = VCTitleArray[i];
        
        [VC.tabBarItem setImage:[[UIImage imageNamed:normalImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [VC.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:VC];
        navi.navigationBar.translucent = NO;
//        UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mine_icon_login"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeft)];
//        navi.navigationItem.leftBarButtonItem = left;
        
        [self addChildViewController:navi];
        
        self.dotaTabBar.tabBarItem = VC.tabBarItem;
        
        if (i == VCNameArray.count - 1) {
            for (UIView * view in self.tabBar.subviews) {
                Class uitabBarButton = NSClassFromString(@"UITabBarButton");
                if ([view isKindOfClass:[uitabBarButton class]]) {
                    [view removeFromSuperview];
                }
            }
        }
        
        
    }
    
}

#pragma mark - DOTATabBarDelegate

-(void)passIndex:(NSInteger)index
{
    if (index == 1) {
        [self.popMenu showMenuAtView:self.view];
    }
    self.selectedIndex = index;
}

#pragma navigationbar
-(void)presentLeft
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
