//
//  DOTATabBar.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef  void(^PassIndex)(NSInteger index);

typedef void(^BoxBtnPressedBlock)();


@interface DOTATabBar : UIView

@property (nonatomic, strong) UITabBarItem * tabBarItem;


@property (nonatomic, copy) PassIndex passIndex;

@property (nonatomic, copy) BoxBtnPressedBlock bBlock;


@end
