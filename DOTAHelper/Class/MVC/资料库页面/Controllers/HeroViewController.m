//
//  HeroViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "HeroViewController.h"
#import "ItemHeaderReusableView.h"
#import "HeroCollectionViewCell.h"
#import "HeroModel.h"
#import "HeroDetailViewController.h"

@interface HeroViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation HeroViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    [self.view addSubview:_collectionView];
    flowLayout.minimumLineSpacing = SPACING_BIG;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(SCREEN_SIZE.width / 3 - SPACING_SMALL, SCREEN_SIZE.height / 6 - SPACING_SMALL);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[HeroCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    
     [_collectionView registerNib:[UINib nibWithNibName:@"ItemHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_SIZE.width, 50);
   
}

-(void)requestData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"heroes" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSArray * heroNameArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * heroArray =  [HeroModel mj_objectArrayWithKeyValuesArray:heroNameArray];
    
    for (char i = 'A'; i < 'Z'; i++) {
        NSMutableArray * arr = [NSMutableArray array];
        
        for (HeroModel * model in heroArray) {
            if ([model.py isEqualToString: [NSString stringWithFormat:@"%c", i]]) {
                [arr addObject:model];
            }
        }
        if (arr.count > 0) {
            [self.dataArray addObject:arr];
        }
    }
    
    [_collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * arr = self.dataArray[section];
    return arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSArray * nameArray = self.dataArray[indexPath.section];
    HeroModel * model = nameArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ItemHeaderReusableView * headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        NSArray * arr = self.dataArray[indexPath.section];
        HeroModel * model = arr[indexPath.row];
        headerView.typeLabel.text = model.py;
        return headerView;
    }
    return nil;
}


//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    HeroDetailViewController * VC = [[HeroDetailViewController alloc]init];
//    NSArray * arr = self.dataArray[indexPath.section];
//    HeroModel * model = arr[indexPath.row];
//    VC.model = model;
//    [self presentViewController:VC animated:YES completion:nil];
//}




@end
