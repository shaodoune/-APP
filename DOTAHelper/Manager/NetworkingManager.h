//
//  NetworkingManager.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccess)(NSURLResponse * response, NSData * data);
typedef void(^RequestFailure)(NSURLResponse * response, NSError * error);

@interface NetworkingManager : NSObject

+(instancetype)manager;

-(void)GET:(NSString *)url Success:(RequestSuccess)success Failure:(RequestFailure)failure;


@end
