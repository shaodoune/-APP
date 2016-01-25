//
//  LiveModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BaseModel.h"

@interface LiveModel : BaseModel

@property (nonatomic, copy) NSString * nickname;

//在线人数
@property (nonatomic, assign) long long online;

@property (nonatomic, copy) NSString * roomid;

//缩略图（比例：3:2）
@property (nonatomic, copy) NSString * thumbnail;

@property (nonatomic, copy) NSString * title;

@end
