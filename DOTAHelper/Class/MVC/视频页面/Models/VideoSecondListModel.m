//
//  VideoSecondListModel.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoSecondListModel.h"

@implementation VideoSecondListModel


-(void)setDuration:(NSNumber *)duration
{
    NSInteger time = [duration integerValue] / 1000;
    
    NSInteger hh = 0, mm = 0, ss = 0;
    
    hh = time / 3600;
    mm = (time - hh * 3600) / 60;
    ss = time - hh * 3600 - mm * 60;
    _duration = [NSString stringWithFormat:@"时长:%.2ld:%.2ld:%.2ld", hh, mm, ss];
}

-(void)setCreated:(NSString *)created
{
    NSDateFormatter * dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"YYYY-MM-dd"];
    dataFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"CN"];
    NSTimeInterval timeInterval = [created integerValue] / 1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString * str = [dataFormatter stringFromDate:date];
    _created = [NSString stringWithFormat:@"发布于:%@", str];
}

@end
