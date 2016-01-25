//
//  LiveTableViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "LiveTableViewController.h"
#import "LiveModel.h"
#import "VideoThirdCell.h"
#import "LiveViewController.h"


@interface LiveTableViewController ()

@end

@implementation LiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoThirdCell" bundle:nil] forCellReuseIdentifier:@"VideoThirdCellID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 请求数据

-(void)requestData
{
    [self.manager GET:self.XBParam Success:^(NSURLResponse *response, NSData *data) {
        if (self.page == 0 && self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * livesArray = responseDic[@"lives"];
        self.dataArray = [LiveModel mj_objectArrayWithKeyValuesArray:livesArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView reloadData];
        });
        
    } Failure:^(NSURLResponse *response, NSError *error) {
        
            [self.tableView.mj_header endRefreshing];
        
         NSLog(@"%@", [error localizedDescription]);
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VideoThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VideoThirdCellID" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LiveViewController * liveVC = [[LiveViewController alloc]init];
    liveVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:liveVC animated:YES];
}




@end
