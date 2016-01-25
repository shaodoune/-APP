//
//  ItemDetailSecondCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ItemDetailSecondCell.h"
#import "ItemCollectionViewCell.h"

@interface ItemDetailSecondCell ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * itemCollectionView;

@end

@implementation ItemDetailSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self generateSubViews];
    }
    return self;
}

-(void)generateSubViews
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _itemCollectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
    flowLayout.minimumInteritemSpacing = SPACING_SMALL;
    flowLayout.minimumLineSpacing = SPACING_SMALL;
    flowLayout.itemSize = CGSizeMake(SCREEN_SIZE.width / 6 - SPACING_SMALL, SCREEN_SIZE.height / 8 - SPACING_SMALL);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _itemCollectionView.dataSource = self;
    _itemCollectionView.delegate = self;
    _itemCollectionView.backgroundColor = [UIColor redColor];
    
    [_itemCollectionView registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
}

-(void)setModel:(ItemModel *)model
{
    _model = model;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
