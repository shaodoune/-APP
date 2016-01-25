//
//  NetworkingManager.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "NetworkingManager.h"

@implementation NetworkingManager
{
    NSURLSession * _urlSession;
}

+(instancetype)manager
{
    NetworkingManager * manager = [[NetworkingManager alloc]init];
    return  manager;
}

-(instancetype)init
{
    if (self = [super init]) {
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

-(void)GET:(NSString *)url Success:(RequestSuccess)success Failure:(RequestFailure)failure
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDataTask * task = [_urlSession dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (!error) {
            if (success) {
                success(response, data);
            }
        }
        else
        {
            if (failure) {
                failure(response, error);
            }
        }
    }];
    
    [task resume];
}


@end
