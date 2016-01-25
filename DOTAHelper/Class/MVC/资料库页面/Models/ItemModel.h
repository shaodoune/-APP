//
//  ItemModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/15.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BaseModel.h"

@interface ItemModel : BaseModel


//描述
@property (nonatomic, copy) NSString * attrib;

//
@property (nonatomic, copy) NSString * cd;

//
@property (nonatomic, copy) NSArray * components;

@property (nonatomic, copy) NSNumber * cost;

@property (nonatomic, assign) BOOL created;

@property (nonatomic, copy) NSString * desc;

@property (nonatomic, copy) NSString * dname;

@property (nonatomic, copy) NSNumber * ID;

@property (nonatomic, copy) NSString * img;

@property (nonatomic, copy) NSString * lore;

@property (nonatomic, copy) NSString * mc;

@property (nonatomic ,copy) NSString * notes;

@property (nonatomic, copy) NSString * qual;

@property (nonatomic, copy) NSString * type;


@end
