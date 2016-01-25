//
//  FirstTableViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "FirstTableViewController.h"
#import "NewsDetailViewController.h"
#import "VideoRootViewController.h"
#import "NetworkingManager.h"
#import "FirstRowCellCell.h"
#import "SecondCell.h"
#import "NewsModel.h"

@interface FirstTableViewController ()

@property (nonatomic, strong) NSMutableArray * firstDataArray;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger temPage;

@property (nonatomic, strong) NetworkingManager * manager;

@property (nonatomic, assign) NSInteger totalPages;

@end

@implementation FirstTableViewController

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

-(NSMutableArray *)firstDataArray
{
    if (!_firstDataArray) {
        _firstDataArray = [NSMutableArray array];
    }
    return _firstDataArray;
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
    
    [self.tableView registerClass:[FirstRowCellCell class] forCellReuseIdentifier:@"FirstCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:@"SecondCellID"];
    
    self.tableView.tableFooterView = [UIView new];
    
    _page = 0;
    _totalPages = 0;
    
    [self setupRefresh];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupRefresh
{
    __weak typeof (self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _temPage = _page;
        _page = 0;
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf requestData];
    }];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakSelf requestData];
    }];
    
    self.tableView.mj_footer = footer;
}

#pragma mark - 请求数据

-(void)requestData
{
    __weak typeof (self)weakSelf = self;
    if (_page == 0) {
        if (self.firstDataArray.count == 0) {
            [self.manager GET:FIRST_NEWS_SCROLL_URL Success:^(NSURLResponse *response, NSData *data) {
                NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray * dataArray = responseDic[@"data"];
                weakSelf.totalPages = [responseDic[@"total_pages"] integerValue];
                for (NSDictionary * dataDict in dataArray) {
                    NewsModel * model = [[NewsModel alloc]init];
                    model.pic = dataDict[@"pic"];
                    model.title = dataDict[@"title"];
                    model.url = dataDict[@"url"];
                    [weakSelf.firstDataArray addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView.mj_header endRefreshing];
                    [weakSelf.tableView reloadData];
                });
                
                
            } Failure:^(NSURLResponse *response, NSError *error) {
                [weakSelf.tableView.mj_header endRefreshing];
                NSLog(@"%@", [error localizedDescription]);
            }];
        }
      }
    
    else if (_page == self.totalPages)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        return;
    }
    
    NSString * url = [NSString stringWithFormat:NEWS_URL, self.XBParam, self.page];
    [self.manager GET:url Success:^(NSURLResponse *response, NSData *data) {
        if (_page == 0) {
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
        }
        //解析数据
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * dataArray = responseDic[@"data"];
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
                [weakSelf.tableView.mj_header endRefreshing];
                
            }
            else
            {
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView reloadData];
        });
        
    } Failure:^(NSURLResponse *response, NSError *error) {
        if (_page == 0) {
            [weakSelf.tableView.mj_header endRefreshing];
            _page = _temPage;
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            _page--;
        }
        
#warning 添加加载失败后续操作
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        FirstRowCellCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCellID" forIndexPath:indexPath];
        cell.firstCellDataArray = self.firstDataArray;
        
        __weak typeof(self) weakSelf = self;
        cell.FirstScrollView.itemClicked = ^(NSInteger index){
            NewsDetailViewController * VC = [[NewsDetailViewController alloc]init];
            VC.model = weakSelf.firstDataArray[index];
            
            
            [weakSelf.navigationController pushViewController:VC animated:YES];
        };
        
        
        return cell;
    }
    else
    {
        SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCellID" forIndexPath:indexPath];
        
        NewsModel * model = self.dataArray[indexPath.row - 1];
        cell.model = model;
        return cell;
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel * model = self.dataArray[indexPath.row - 1];
    
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
    if (indexPath.row == 0) {
        return 180;
    }
    else
    {
        return CELL_HEIGHT;
    }
}

@end
