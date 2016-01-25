
//
//  BZViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BZViewController.h"
#import "NetworkingManager.h"
#import "WallPaperCollectionViewCell.h"
#import "WallPaperModel.h"
#import <MJPhotoBrowser.h>
#import <MJPhoto.h>


@interface BZViewController ()

@property(nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NetworkingManager * manager;

@property (nonatomic, assign) NSInteger tempage;

@property (nonatomic, assign) NSInteger page;

@end

@implementation BZViewController

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
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"DOTA2壁纸";
    self.collectionView.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize  = CGSizeMake(SCREEN_SIZE.width / 2, SCREEN_SIZE.height / 2 - 35);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WallPaperCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WallPaperCollectionViewCell"];
    
    [self setupRefresh];
    [self.collectionView.mj_header beginRefreshing];
}


-(void)setupRefresh
{
    __weak typeof (self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _tempage = _page;
        _page = 0;
        weakSelf.collectionView.mj_footer.hidden = YES;
        [weakSelf generateData];
    }];
    self.collectionView.mj_header = header;
    
}

#pragma mark - 请求数据

-(void)generateData
{
    [self.manager GET:DOTA_BZ Success:^(NSURLResponse *response, NSData *data) {
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = responseDic[@"wallpapers"];
        self.dataArray = [WallPaperModel mj_objectArrayWithKeyValuesArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
            
        });

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        });
        
    } Failure:^(NSURLResponse *response, NSError *error) {
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallPaperCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WallPaperCollectionViewCell" forIndexPath:indexPath];
    
    WallPaperModel * model = self.dataArray[indexPath.row];
    cell.WPmodel = model;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MJPhotoBrowser * browser = [[MJPhotoBrowser alloc]init];
    NSMutableArray * photoArray = [NSMutableArray array];
    browser.currentPhotoIndex = indexPath.row;
    for (WallPaperModel * model in self.dataArray) {
        MJPhoto * photo = [[MJPhoto alloc]init];
        photo.url = [NSURL URLWithString:model.iPhone1080];
        [photoArray addObject:photo];
    }
    browser.photos = photoArray;
    [browser show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}





@end
