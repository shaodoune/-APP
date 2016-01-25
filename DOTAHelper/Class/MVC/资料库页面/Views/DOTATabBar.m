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
        // 创建一个按钮 设置一次性的属性
        UIButton *boxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:boxBtn];
        [boxBtn setImage:[UIImage imageNamed:@"tab_bh"] forState:UIControlStateNormal];
        [boxBtn setImage:[UIImage imageNamed:@"tab_bhon"] forState:UIControlStateSelected];
        
        self.boxBtn = boxBtn;
        [boxBtn addTarget:self action:@selector(boxBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 布局子视图
    // 循环按钮数组，做相应的布局
    
    CGFloat btnW = CGRectGetWidth(self.frame)/(CGFloat)(self.buttonArray.count + 1);
    CGFloat boxH = CGRectGetHeight(self.frame);
    
    self.boxBtn.frame = CGRectMake(0, 0, btnW, boxH);
    
    self.boxBtn.center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
    NSLog(@"%f", self.boxBtn.frame.size.height);
    
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        DOTATabBarButton *btn = self.buttonArray[i];
        CGFloat bX = btnW * i;
        if (i > 0) {
            bX += btnW;
        }
        CGFloat bY = 0;
        CGFloat bW = btnW;
        CGFloat bH = CGRectGetHeight(self.frame);
        
        
        btn.frame = CGRectMake(bX, bY, bW, bH);
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

- (void)boxBtnPressed
{
    if (_bBlock) {
        _bBlock();
    }
}




@end
