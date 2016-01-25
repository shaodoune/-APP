//
//  MainViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "MainViewController.h"
#import "RootTabBarController.h"
#import "MineViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

//-(instancetype)init
//{
//    if (self = [super init]) {
//        MineViewController * leftVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MineViewController"];
//        RootTabBarController * middleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootTabBarController"];
//        self.leftMenuViewController = leftVC;
//        self.contentViewController = middleVC;
//        [self setupSideMenu];
//    }
//    return self;
//}

-(void)awakeFromNib
{
    MineViewController * leftVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MineViewController"];
    RootTabBarController * middleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootTabBarController"];
    self.leftMenuViewController = leftVC;
    self.contentViewController = middleVC;
    [self setupSideMenu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSideMenu
{
    self.scaleContentView = NO;
    self.scaleMenuView = NO;
}

@end
