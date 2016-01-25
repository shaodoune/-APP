//
//  ItemDetailFirstFrameModel.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BaseModel.h"
#import "ItemModel.h"

@interface ItemDetailFirstFrameModel : BaseModel

@property (nonatomic, strong) ItemModel * model;


@property (nonatomic, assign) CGRect itemIconFrame;

@property (nonatomic, assign) CGRect itemNameFrame;

@property (nonatomic, assign) CGRect itemCostFrame;

@property (nonatomic, assign) CGRect lineFrame;

@property (nonatomic, assign) CGRect itemLoreFrame;

@property (nonatomic, assign) CGRect itemDescFrame;

@property (nonatomic, assign) CGRect itemAttribFrame;

@property (nonatomic, assign) CGRect itemCdFrame;

@property (nonatomic, assign) CGRect itemMcFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
