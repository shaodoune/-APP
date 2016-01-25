//
//  VideoBaseTableViewController.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkingManager.h"

@interface VideoBaseTableViewController : UITableViewController

@property (nonatomic, copy) NSString * XBParam;

@property (nonatomic, strong) NetworkingManager * manager;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger tempage;

-(void)requestData;

-(void)setupRefresh;

@end
