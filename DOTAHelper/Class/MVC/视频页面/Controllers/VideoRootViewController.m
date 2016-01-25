//
//  VideoRootViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoRootViewController.h"
#import "VideoSecondTableViewController.h"
#import "VideoSecondViewController.h"

@interface VideoRootViewController ()

@end

@implementation VideoRootViewController

-(instancetype)init
{
    if (self = [super initWithTagViewHeight:40]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    NSArray * titleArray = @[@"最新", @"赛事", @"集锦", @"解说"];
    NSArray * classNameArray = @[[VideoSecondViewController class],
                                 [VideoSecondTableViewController class],
                                 [VideoSecondTableViewController class],
                                 [VideoSecondTableViewController class],
                                 ];
    
    NSArray * params = @[NEW_LIST_URL, EVENT_LIST_URL, FUN_LIST_URL, COMMENTATOR_LIST_URL, LIVE_LIST_URL];
    
    self.tagItemSize = CGSizeMake(SCREEN_SIZE.width / titleArray.count + 1, 40);
    self.normalTitleFont = [UIFont systemFontOfSize:11];
    self.selectedTitleFont = [UIFont systemFontOfSize:13];
    CGSize size = [titleArray[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.selectedIndicatorSize = CGSizeMake(size.width, 3);
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNameArray withParams:params];
}

@end
