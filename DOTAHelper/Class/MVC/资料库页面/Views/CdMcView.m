//
//  CdMcView.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "CdMcView.h"

@interface CdMcView ()

@property (nonatomic, strong) UIImageView * img;

@property (nonatomic, strong) UILabel * numberLabel;

@end

@implementation CdMcView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}


-(void)setDic:(NSDictionary *)dic
{
    NSString * imageName = dic[@"imageName"];
    NSString * number = dic[@"number"];
    _img = [[UIImageView alloc]init];
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = self.frame.size.height;
    _img.frame = CGRectMake(imgX, imgY, imgW, imgW);
    _img.image = [UIImage imageNamed:imageName];
    [self addSubview:_img];
    _numberLabel = [[UILabel alloc]init];
    CGFloat numberLabelX = CGRectGetMaxX(_img.frame);
    CGFloat numberLabelY = 0;
    CGFloat numberLabelW = self.frame.size.width;
    _numberLabel.frame = CGRectMake(numberLabelX, numberLabelY, numberLabelW, _img.frame.size.width);
    [self addSubview:_numberLabel];
    
    _numberLabel.text = number;
    _numberLabel.font = FONT_CD;
}




@end
