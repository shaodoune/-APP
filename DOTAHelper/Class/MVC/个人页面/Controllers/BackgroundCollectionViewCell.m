//
//  BackgroundCollectionViewCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BackgroundCollectionViewCell.h"

@implementation BackgroundCollectionViewCell

- (void)awakeFromNib {
    
}


-(void)setBGmodel:(BackgroundModel *)BGmodel
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:BGmodel.thumbnail] placeholderImage:[UIImage imageNamed:@"common_instruct_img"]];
    self.name.text = BGmodel.name;
    self.name.font = [UIFont systemFontOfSize:14];
    self.name.textAlignment = NSTextAlignmentCenter;
}


@end
