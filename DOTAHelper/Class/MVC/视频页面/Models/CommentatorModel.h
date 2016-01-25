//
//  CommentatorModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BaseModel.h"

@interface CommentatorModel : BaseModel

//解说Model
@property (nonatomic, copy) NSString * _id;

@property (nonatomic, copy) NSString * video_id;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * discirption;

@property (nonatomic, copy) NSString * thumbnail;

@property (nonatomic, copy) NSString * total;

//等级
@property (nonatomic, assign) long long seat;

//更新时间
@property (nonatomic, copy) NSString * last_uped;

//最早发布时间
@property (nonatomic, assign) long long created;

@end
