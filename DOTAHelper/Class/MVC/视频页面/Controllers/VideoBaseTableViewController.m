//
//  VideoBaseTableViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoBaseTableViewController.h"


@interface VideoBaseTableViewController ()

@end

@implementation VideoBaseTableViewController


-(void)setXBParam:(NSString *)XBParam
{
    _XBParam = XBParam;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NetworkingManager *)manager
{
    if (!_manager) {
        _manager = [NetworkingManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    [self setupRefresh];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)setupRefresh
{
    __weak typeof (self) weakSelf = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _tempage = _page;
        _page = 0;
        
        [weakSelf requestData];
    }];
    self.tableView.mj_header = header;
}

-(void)requestData
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}




@end
