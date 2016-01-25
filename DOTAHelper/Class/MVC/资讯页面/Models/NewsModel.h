//
//  NewsModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : BaseModel

//发布日期
@property (nonatomic, copy) NSString * date;

//详细介绍
@property (nonatomic, copy) NSString * desc;

//ID
@property (nonatomic, copy) NSString * ID;

//图片连接
@property (nonatomic, copy) NSString * pic;

//标题
@property (nonatomic, copy) NSString * title;

//详情连接
@property (nonatomic, copy) NSString * url;

@end
