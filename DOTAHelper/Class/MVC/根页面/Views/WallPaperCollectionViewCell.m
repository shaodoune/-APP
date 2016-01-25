//
//  WallPaperCollectionViewCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "WallPaperCollectionViewCell.h"

@implementation WallPaperCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setWPmodel:(WallPaperModel *)WPmodel
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:WPmodel.iPhone1080] placeholderImage:[UIImage imageNamed:@"common_instruct_img"]];
    self.name.text = WPmodel.filename;
    self.name.font = [UIFont systemFontOfSize:14];
    self.name.textAlignment = NSTextAlignmentCenter;
}

@end
