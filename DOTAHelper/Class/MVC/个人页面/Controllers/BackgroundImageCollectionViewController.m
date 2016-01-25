//
//  BackgroundImageCollectionViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BackgroundImageCollectionViewController.h"
#import "BackgroudDetailViewController.h"
#import "BackgroundCollectionViewCell.h"
#import "NetworkingManager.h"

@interface BackgroundImageCollectionViewController ()

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NetworkingManager * manager;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger temPage;


@end

@implementation BackgroundImageCollectionViewController

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

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"背景封面";
    
    _page = 0;
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = SPACING_BIG;
    flowLayout.itemSize  = CGSizeMake(SCREEN_SIZE.width / 3, SCREEN_SIZE.width / 3);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BackgroundCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    [self setupRefresh];
    [self.collectionView.mj_header beginRefreshing];
    [self customNavigationBar];
    
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
        weakSelf.collectionView.mj_footer.hidden = YES;
        [weakSelf generateData];
    }];
    self.collectionView.mj_header = header;

}

#pragma mark - 请求数据

-(void)generateData
{
    [self.manager GET:BACKGROUND_URL Success:^(NSURLResponse *response, NSData *data) {
        NSDictionary * responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = responseDic[@"data"];
        self.dataArray = [BackgroundModel mj_objectArrayWithKeyValuesArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        });
        
    } Failure:^(NSURLResponse *response, NSError *error) {
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BackgroundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    BackgroundModel * model = self.dataArray[indexPath.row];
    cell.BGmodel = model;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showWithStatus:@"加载中。。。"];
    BackgroundModel * model = self.dataArray[indexPath.row];
    
    
    [self.manager GET:model.imgurl Success:^(NSURLResponse *response, NSData *data) {
        
        //上传图片
        [self uploadImageWithImageData:data];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
//
//        });
        
    } Failure:^(NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
        });
    }];
}

#pragma  mark - 上传图片
-(void)uploadImageWithImageData:(NSData *)imgData
{
    
//    [SVProgressHUD showWithStatus:@"上传图片..." maskType:SVProgressHUDMaskTypeClear];
    
    [BmobProFile uploadFileWithFilename:@"背景图片" fileData:imgData block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url, BmobFile *file) {
        if (isSuccessful) {
            BmobUser * user = [BmobUser getCurrentUser];
            [user setObject:file.url forKey:@"bgImage"];
            
            [user updateInBackgroundWithResultBlock:^(BOOL isSuc, NSError *err) {
                if (isSuc) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                    });
                    
                    [BmobImage cutImageBySpecifiesTheWidth:SCREEN_SIZE.width height:SCREEN_SIZE.height  quality:50 sourceImageUrl:file.url outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeBackgroundImage" object:imgData];
                        
                    }];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[err localizedDescription]];
                }
            }];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    } progress: ^(CGFloat progress){
    }];
}




#pragma mark - Navigationbar
-(void)customNavigationBar
{
    UINavigationItem * item = self.navigationItem;
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(back)];
    item.leftBarButtonItem = left;
}

-(void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

@end
