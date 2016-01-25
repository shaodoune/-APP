//
//  VideoSecondTableViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoSecondTableViewController.h"
#import "VideoSecondCell.h"
#import "VideoSecondViewController.h"
#import "CommentatorModel.h"
#import "VideoSecondDetailViewController.h"

@interface VideoSecondTableViewController ()

@end

@implementation VideoSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoSecondCell" bundle:nil]  forCellReuseIdentifier:@"VideoSecondCellID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData
{
    [self.manager GET:self.XBParam Success:^(NSURLResponse *response, NSData *data) {
        if (self.page == 0 && self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        NSArray * responseArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.dataArray = [CommentatorModel mj_objectArrayWithKeyValuesArray:responseArr];
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
    
    VideoSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VideoSecondCellID" forIndexPath:indexPath];
    cell.firstModel = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.XBParam isEqualToString:NEW_LIST_URL]) {
        
        VideoSecondDetailViewController * liveVC = [[VideoSecondDetailViewController alloc]init];
        liveVC.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:liveVC animated:YES];
    }
    else
    {
        
        VideoSecondViewController * liveVC = [[VideoSecondViewController alloc]init];
        liveVC.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:liveVC animated:YES];
    }

}

@end
