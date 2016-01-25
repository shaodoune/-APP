//
//  HeroDetailModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BaseModel.h"

@interface HeroDetailModel : BaseModel


//出门装
@property (nonatomic, copy) NSString * cmzb;

//初始护甲
@property (nonatomic, copy) NSString * cshj;

//初始移动速度
@property (nonatomic, copy) NSString * csydsd;

//攻击范围
@property (nonatomic, copy) NSString * gjfw;

//攻击距离
@property (nonatomic, copy) NSString * gjjl;

//攻击力
@property (nonatomic, copy) NSString * gjl;

@property (nonatomic, copy) NSString * gjlx;

//攻击速度
@property (nonatomic, copy) NSString * gjsd;

//护甲
@property (nonatomic, copy) NSString * hj;

//后期神装
@property (nonatomic, copy) NSString * hqsz;

//核心装备
@property (nonatomic, copy) NSString * hxzb;

//过度装备
@property (nonatomic, copy) NSString * qqzb;

//ID
@property (nonatomic, copy) NSString * ID;

//简称
@property (nonatomic, copy) NSString * jc;

//初始力量
@property (nonatomic, copy) NSString * lljc;

//初始智力
@property (nonatomic, copy) NSString * zljc;

//初始敏捷
@property (nonatomic, copy) NSString * mjjc;

//力量成长
@property (nonatomic, copy) NSString * llsj;

//智力成长
@property (nonatomic, copy) NSString * zlsj;

//敏捷成长
@property (nonatomic, copy) NSString * mjsj;

//魔法值
@property (nonatomic, copy) NSString * mfz;

//生命值
@property (nonatomic, copy) NSString * smz;

//视野范围
@property (nonatomic, copy) NSString * syfw;

//英文名称
@property (nonatomic, copy) NSString * ywm;

//英雄背景
@property (nonatomic, copy) NSString * yxbj;

//英雄类型
@property (nonatomic, copy) NSString * yxlx;

//英雄定位
@property (nonatomic, copy) NSString * yxdw;

//中文名
@property (nonatomic, copy) NSString * zwm;

//阵营名称
@property (nonatomic, copy) NSString * zymc;

//建议加点
@property (nonatomic, copy) NSString * djjd;

//被克制英雄列表(存储英雄英文名称)
@property (nonatomic, strong) NSArray * adapt_bkz_list;

//克制英雄列表(存储英雄英文名称)
@property (nonatomic, strong) NSArray * adapt_kz_lsit;

//相同类型的英雄(存储英雄英文名称)
@property (nonatomic, strong) NSArray * adapt_type_list;

//适合组队的英雄(存储英雄英文名称)
@property (nonatomic, strong) NSArray * adapt_zd_list;

@end
