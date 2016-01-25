//
//  GoodDetailViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/15.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "ItemDetailFirstCell.h"
#import "RCLabel.h"
#import "ItemModel.h"
#import "ItemCostView.h"
#import "CdMcView.h"
#import "ItemDetailFirstFrameModel.h"

@interface GoodDetailViewController ()

@property (nonatomic, strong) UIImageView * itemIconImageView;

@property (nonatomic, strong) UILabel * itemNameLabel;

@property (nonatomic, strong) ItemCostView * itemCostView;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UILabel * itemLoreLabel;

@property (nonatomic, strong) RCLabel * itemAttribLabel;

@property (nonatomic, strong) RCLabel * itemDescLabel;

@property (nonatomic, strong) CdMcView * itemCdView;

@property (nonatomic, strong) CdMcView * itemMcView;

@property (nonatomic, strong) ItemDetailFirstFrameModel * frameModel;

@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateData];
    [self.tableView registerClass:[ItemDetailFirstCell class] forCellReuseIdentifier:@"CELL"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateData
{
    _frameModel = [[ItemDetailFirstFrameModel alloc]init];
    _frameModel.model = self.model;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemDetailFirstCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.frameModel = self.frameModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frameModel.cellHeight;
}









@end
