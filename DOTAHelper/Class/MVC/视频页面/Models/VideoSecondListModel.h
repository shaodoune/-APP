//
//  VideoSecondListModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BaseModel.h"

@interface VideoSecondListModel : BaseModel

@property (nonatomic, copy) NSString * _id;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * video_id;

@property (nonatomic, copy) NSString * link;

@property (nonatomic, copy) NSString * thumbnail;

@property (nonatomic, copy) NSString * sort;

@property (nonatomic, copy) NSString * duration;

@property (nonatomic, copy) NSString * created;

@end
