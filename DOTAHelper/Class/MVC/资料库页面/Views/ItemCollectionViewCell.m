//
//  ItemCollectionViewCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/15.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@implementation ItemCollectionViewCell
{
    UIImageView * _img;
    UILabel * _name;
}


-(void)setModel:(ItemModel *)model
{
    _model = model;
    if (!_img) {
        _img = [[UIImageView alloc]init];
        [self.contentView addSubview:_img];
    }
    _img.frame = CGRectMake(3, 0, self.bounds.size.width - 6, self.bounds.size.height * 3/4);
    if (!_name) {
        _name = [[UILabel alloc]init];
        [self.contentView addSubview:_name];
    }
    _name.frame = CGRectMake(3, CGRectGetMaxY(_img.frame), self.bounds.size.width - 6, self.bounds.size.height / 4);
    _img.image = [UIImage imageNamed:model.img];
    _name.text = model.dname;
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor whiteColor];
    _name.backgroundColor = [UIColor blackColor];
}

@end
