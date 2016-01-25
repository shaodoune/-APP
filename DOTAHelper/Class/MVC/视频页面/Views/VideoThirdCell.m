//
//  VideoThirdCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoThirdCell.h"

@implementation VideoThirdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LiveModel *)model
{
    _model = model;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"common_instruct_img"]];
    self.titleLabel.text = model.title   ;
    self.nicknameLabel.text = model.nickname;
    self.onlineLabel.text = [NSString stringWithFormat:@"在线人数:%lld", model.online];
    
    
}

@end
