//
//  CommentatorModel.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "CommentatorModel.h"

@implementation CommentatorModel


-(void)setTotal:(NSNumber *)total
{
    NSString * str = [NSString stringWithFormat:@"视频数:%@", total];
    _total = str;
}

-(void)setLast_uped:(NSNumber *)last_uped
{
    NSDateFormatter * dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"YYYY-MM-dd"];
    dataFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"CN"];
    NSTimeInterval timeInterval = [last_uped integerValue] / 1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString * str = [dataFormatter stringFromDate:date];
    _last_uped = [NSString stringWithFormat:@"更新于:%@", str];
}

@end
