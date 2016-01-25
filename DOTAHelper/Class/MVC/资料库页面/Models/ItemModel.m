//
//  ItemModel.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/15.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel


-(void)setAttrib:(NSString *)attrib
{
    _attrib = attrib;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value ;
    }
}



@end
