//
//  HeroModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

//攻击类型
@property (nonatomic, copy) NSString * atk;

@property (nonatomic, copy) NSString * img;

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * name_l;

//英雄属性
@property (nonatomic, copy) NSString * prop;

//拼音首字母
@property (nonatomic, copy) NSString * py;

//英雄定位
@property (nonatomic, copy) NSArray * roles;

//阵营
@property (nonatomic, copy) NSString * zy;

@end
