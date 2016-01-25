//
//  VideoSecondCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoSecondCell.h"

@implementation VideoSecondCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFirstModel:(CommentatorModel *)firstModel
{
    _firstModel = firstModel;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:firstModel.thumbnail] placeholderImage:[UIImage imageNamed:@"common_instruct_img"]];
    self.titleLabel.text = firstModel.title   ;
    self.nicknameLabel.text = firstModel.discirption;
    self.number.text = firstModel.total;
    self.date.text = firstModel.last_uped;
    
}

-(void)setSecondmodel:(VideoSecondListModel *)secondmodel
{
    _secondmodel = secondmodel;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:secondmodel.thumbnail] placeholderImage:[UIImage imageNamed:@"common_instruct_img"]];
    self.titleLabel.text = secondmodel.title;
    self.number.text = secondmodel.duration;
    self.date.text = secondmodel.created;
}




@end
