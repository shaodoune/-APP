//
//  ItemCostView.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ItemCostView.h"

@interface ItemCostView()

@property (nonatomic, strong)UIImageView * costImg;

@property (nonatomic, strong) UILabel * costLabel;

@end

@implementation ItemCostView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)createUI
{

}

-(void)setCost:(NSString *)cost
{
    
    if(!_costImg)
    {
        _costImg = [[UIImageView alloc]init];
    }
    CGFloat costImgX = self.frame.size.height;
    CGFloat costImgY = 0;
    CGFloat costImgWH = self.frame.size.height;
    _costImg.frame = CGRectMake(costImgX, costImgY, costImgWH, costImgWH);
    _costImg.image = [UIImage imageNamed:@"icon-2"];
    [self addSubview:_costImg];
    
    if (!_costLabel) {
        _costLabel = [[UILabel alloc]init];
    }
    _costLabel = [[UILabel alloc]init];
    CGFloat costLabelX = CGRectGetMaxX(_costImg.frame);
    CGFloat costLabelY = 0;
    CGFloat costLabelW = self.frame.size.width - 3 * self.frame.size.height;
    CGFloat costLabelH = self.frame.size.height;
    _costLabel.frame = CGRectMake(costLabelX, costLabelY, costLabelW, costLabelH);
    _costLabel.textColor = [UIColor orangeColor];
    _costLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_costLabel];
    _costLabel.text = cost;
    _costLabel.font = FONT_ITEMCOST;
   
}

@end
