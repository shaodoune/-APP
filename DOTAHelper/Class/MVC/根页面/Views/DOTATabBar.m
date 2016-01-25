//
//  DOTATabBar.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "DOTATabBar.h"
#import "DOTATabBarButton.h"

@interface DOTATabBar ()

@property (nonatomic, strong) NSMutableArray * buttonArray;

@property (nonatomic, strong) DOTATabBarButton * selectedBtn;

@property (nonatomic, strong) UIButton * boxBtn;

@end


@implementation DOTATabBar

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

-(void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    DOTATabBarButton * button = [DOTATabBarButton buttonWithType:UIButtonTypeCustom];
    button.tabBarItem = tabBarItem;
    [self addSubview:button];
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    
    [self.buttonArray addObject:button];
    
    if (self.buttonArray.count == 1) {
        [self buttonPressed:button];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for(int i =0; i < self.buttonArray.count; i++)
    {
        CGFloat btnW = CGRectGetWidth(self.frame)/(CGFloat)(self.buttonArray.count + 1);
        DOTATabBarButton * button = self.buttonArray[i];
        CGFloat bX = btnW * i;
        CGFloat bY = 0;
        CGFloat bW = btnW;
        CGFloat bH = CGRectGetHeight(self.frame);
        button.frame = CGRectMake(bX, bY, bW, bH);
        
    }
    
}

#pragma  mark - 点击响应事件

-(void)buttonPressed:(DOTATabBarButton *)btn
{
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    NSInteger index = [self.buttonArray indexOfObject:btn];
    
    if (_passIndex) {
        _passIndex(index);
    }
}




@end
