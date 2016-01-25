//
//  VideoSecondViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoSecondViewController.h"
#import "VideoSecondListModel.h"
#import "VideoSecondDetailViewController.h"
#import "NetworkingManager.h"
#import "VideoSecondCell.h"

@interface VideoSecondViewController ()

@end

@implementation VideoSecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.page = 0;
//    
//    [self setupRefresh];
//    
//    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoSecondCell" bundle:nil] forCellReuseIdentifier:@"VideoSecondCellID"];
}

-(void)requestData
{
    if (self.XBParam == nil) {
        if (self.dataArray.count > 0 && self.page == 0) {
            [self.dataArray removeAllObjects];
        }
        NSString * url = [NSString stringWithFormat:VIEDEOSECOND_LIST__URL, self.model._id, self.page];
        [self.manager GET:url Success:^(NSURLResponse *response, NSData *data) {
            NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * listArray = responseDic[@"list"];
            self.dataArray = [VideoSecondListModel mj_objectArrayWithKeyValuesArray:listArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
                
                [self.tableView reloadData];
            });
            
        } Failure:^(NSURLResponse *response, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            
            NSLog(@"%@", [error localizedDescription]);
        }];
    }
    else
    {
        [self.manager GET:self.XBParam Success:^(NSURLResponse *response, NSData *data) {
            NSArray * responseArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.dataArray = [VideoSecondListModel mj_objectArrayWithKeyValuesArray:responseArr];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView.mj_header endRefreshing];
                
                [self.tableView reloadData];
            });
            
        } Failure:^(NSURLResponse *response, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            
            NSLog(@"%@", [error localizedDescription]);
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.secondmodel = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VideoSecondDetailViewController * liveVC = [[VideoSecondDetailViewController alloc]init];
    liveVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:liveVC animated:YES];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
