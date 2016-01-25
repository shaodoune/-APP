//
//  UIScrollView+ScaleView.h
//  SideMenuDemo
//
//  Created by 千锋 on 15/12/28.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleView : UIImageView

@property (nonatomic, weak) UIScrollView * scrollView;


@end


@interface UIScrollView (ScaleView)

@property (nonatomic, weak) ScaleView * scaleView;

//添加可拉伸图片
-(void)addScaleImageViewWithImage:(UIImage *)img;

//移除图片
-(void)removeScaleImageView;

@end
