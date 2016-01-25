//
//  DOTATabBarButton.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "DOTATabBarButton.h"

@implementation DOTATabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


-(void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    
    [self setImage:tabBarItem.image forState:UIControlStateNormal];
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(contentRect);
    CGFloat imgH = CGRectGetHeight(contentRect);
    return CGRectMake(imgX, imgY, imgW, imgH);
}


/** 拦截高亮状态响应，让它什么也不干*/
- (void)setHighlighted:(BOOL)highlighted
{
    
}




@end
