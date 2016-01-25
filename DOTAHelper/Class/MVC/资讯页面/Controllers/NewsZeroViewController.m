//
//  NewsZeroViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "NewsZeroViewController.h"
#import "NewsDetailViewController.h"
#import "NetworkingManager.h"
#import "NewsModel.h"
#import "SecondCell.h"

@interface NewsZeroViewController ()

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger temPage;
@property (nonatomic, strong) NetworkingManager * manager;
@property (nonatomic, assign) NSInteger totalPages;

@end

@implementation NewsZeroViewController

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
    _page = 0;
    _totalPages = 0;
    [self setupRefresh];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:@"SecondCellID"];
}

-(void)setupRefresh
{
    __weak typeof(self) weakSelf = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _temPage = _page;
        _page = 0;
        [weakSelf requestData];
    }];
    self.tableView.mj_header = header;
    
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakSelf requestData];
    }];
    footer.automaticallyRefresh = NO;
    self.tableView.mj_footer = footer;
}

#pragma mark - 请求数据

-(void)requestData
{
    if (_page == _totalPages && _page!= 0)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        return;
    }
    
    NSString * url = [NSString stringWithFormat:NEWS_URL, self.XBParam, self.page];
    NSLog(@"%@", url);
    [self.manager GET:url Success:^(NSURLResponse *response, NSData *data) {
        if (_page == 0) {
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
        }
        //解析数据
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * dataArray = responseDic[@"data"];
        
        _totalPages = [responseDic[@"total_pages"] integerValue];
        
        for (NSDictionary * newsDict in dataArray) {
            NewsModel * model = [[NewsModel alloc]init];
            model.date = newsDict[@"date"];
            model.desc = newsDict[@"desc"];
            model.ID = newsDict[@"id"];
            model.pic = newsDict[@"pic"];
            model.title = newsDict[@"title"];
            model.url = newsDict[@"url"];
            
            [self.dataArray addObject:model];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_page == 0) {
                [self.tableView.mj_header endRefreshing];
                
            }
            else
            {
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView reloadData];
        });
        
    } Failure:^(NSURLResponse *response, NSError *error) {
        if (_page == 0) {
            [self.tableView.mj_header endRefreshing];
            _page = _temPage;
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            _page--;
        }
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCellID" forIndexPath:indexPath];
        
        NewsModel * model = self.dataArray[indexPath.row];
        cell.model = model;
        return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel * model = self.dataArray[indexPath.row];
    if (model.ID == nil) {
        return;
    }
    else
    {
        NewsDetailViewController * newsDetailVC = [[NewsDetailViewController alloc]init];
        newsDetailVC.model = model;
        [self.navigationController pushViewController:newsDetailVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return CELL_HEIGHT;
}






@end
