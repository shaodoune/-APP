//
//  SecondCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsModel *)model
{
    _model = model;
    [self.newsImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"common_instruct_img"]];
    self.newsTitle.text = model.title;
    self.newsDetail.text = model.desc;
    self.newsTime.text = model.date;
}

@end
