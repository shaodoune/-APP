//
//  UIScrollView+ScaleView.m
//  SideMenuDemo
//
//  Created by 千锋 on 15/12/28.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "UIScrollView+ScaleView.h"
#import <objc/runtime.h>

static const NSString * kScaleView = @"kScaleView";

#define Height 200

@implementation ScaleView

-(void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //观察ScrollView的contentOffset的改变
    _scrollView = scrollView;
    //KVO
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

//KVO的调用方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //刷新当前视图的大小
    [self setNeedsLayout];//注册当前视图需要刷新，在下一个循环的时候就会调用
}

//布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_scrollView.contentOffset.y < 0) {
        CGFloat offset = _scrollView.contentOffset.y;
        self.frame = CGRectMake(offset, offset, CGRectGetWidth(_scrollView.frame) - offset*2, Height - offset);
    }
    else
    {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), Height);
    }
}

-(void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)removeFromSuperview
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end


@implementation UIScrollView (ScaleView)

-(void)setScaleView:(ScaleView *)scaleView
{
    //用运行时，给UIScaleView帮顶一个属性
    objc_setAssociatedObject(self, &kScaleView, scaleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ScaleView *)scaleView
{
    return objc_getAssociatedObject(self, &kScaleView);
}


-(void)addScaleImageViewWithImage:(UIImage *)img
{
    //创建一个Scaleview
    ScaleView * scaleView = [[ScaleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), Height)];
    scaleView.image = img;
    scaleView.scrollView = self;
    [self addSubview:scaleView];
    [self sendSubviewToBack:scaleView];
    self.scaleView = scaleView;
}

-(void)removeScaleImageView
{
    [self.scaleView removeFromSuperview];
    self.scaleView = nil;
}


@end
