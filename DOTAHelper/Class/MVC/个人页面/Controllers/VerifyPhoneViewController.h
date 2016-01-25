//
//  VerifyPhoneViewController.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhoneBind)();

@interface VerifyPhoneViewController : UIViewController

@property (nonatomic, copy) PhoneBind pbBlock;

@end
