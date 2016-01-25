//
//  GoodsViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "GoodsViewController.h"
#import "ItemModel.h"
#import "ItemCollectionViewCell.h"
#import "GoodDetailViewController.h"
#import "ItemHeaderReusableView.h"

@interface GoodsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSDictionary * itemDic;

@property (nonatomic, strong) NSArray * nameArray;

@end

@implementation GoodsViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSDictionary *)itemDic
{
    if (!_itemDic) {
        _itemDic = [NSDictionary dictionary];
    }
    return _itemDic;
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
    flowLayout.minimumLineSpacing = SPACING_SMALL;
    flowLayout.minimumInteritemSpacing = SPACING_SMALL;
    flowLayout.itemSize = CGSizeMake(SCREEN_SIZE.width / 4 - SPACING_SMALL, SCREEN_SIZE.height / 7 - SPACING_SMALL);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ItemHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    
//    [_collectionView registerClass:[ItemCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_SIZE.width, 50);
}


-(void)requestData
{
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"items" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSDictionary * goodDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * itemArr = [ItemModel mj_objectArrayWithKeyValuesArray:goodDic.allValues];
    
    NSArray * typeArr = @[@"support", @"weapons", @"attributes", @"armor", @"armaments", @"arcane", @"consumables", @"caster", @"secret_shop", @"artifacts", @"common"];
    self.nameArray = @[@"辅助", @"武器", @"属性", @"防具", @"军备", @"奥术", @"消耗品", @"法器", @"神秘商店", @"圣物", @"普通"];
    self.itemDic = [NSDictionary dictionaryWithObjects:self.nameArray forKeys:typeArr];
    
    for (int i = 0; i < typeArr.count; i++) {
        NSMutableArray * arr = [NSMutableArray array];
        for (ItemModel * model in itemArr) {
            if ([model.type isEqualToString:typeArr[i]]) {
                [arr addObject:model];
            }
        }
        [self.dataArray addObject:arr];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataDource/Delegate

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
    ItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSArray * nameArray = self.dataArray[indexPath.section];
    ItemModel * model = nameArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ItemHeaderReusableView * headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        NSString * name = self.nameArray[indexPath.section];
        headerView.typeLabel.text = name;
        return headerView;
    }
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailViewController * VC = [[GoodDetailViewController alloc]init];
    NSArray * arr = self.dataArray[indexPath.section];
    ItemModel * model = arr[indexPath.row];
    VC.model = model;
    
    [self.navigationController pushViewController:VC animated:YES];
}


@end
