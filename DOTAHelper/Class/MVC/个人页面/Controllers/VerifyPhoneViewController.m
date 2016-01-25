//
//  VerifyPhoneViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VerifyPhoneViewController.h"

@interface VerifyPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyBtn;

@property (nonatomic, copy) NSString * verifyPhoneNumber;

@end

@implementation VerifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCodeClicked:(UIButton *)sender {
    if (self.phoneNumTF.text.length == 0) {
        return;
    }
    
    __block int timeout = 120;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.enabled = YES;
            });
        }
        else
        {
            NSString * strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%@秒再次获取", strTime] forState:UIControlStateNormal];
                sender.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    _verifyPhoneNumber = self.phoneNumTF.text;
    sender.enabled = NO;
    
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneNumTF.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error == nil) {
            [SVProgressHUD showSuccessWithStatus:@"短信已发送，请注意查收"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        sender.enabled = YES;
    }];
    
}

- (IBAction)verifyClicked:(UIButton *)sender {
    
    if (self.phoneNumTF.text.length == 0) {
        return;
    }
    [SVProgressHUD showWithStatus:@"验证手机号..."];
    
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:_verifyPhoneNumber andSMSCode:self.phoneNumTF.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            BmobUser * user = [BmobUser getCurrentUser];
            user.mobilePhoneNumber = _verifyPhoneNumber;
            [user setObject:@(YES) forKey:@"mobilePhoneNumberVerified"];
            
            [user updateInBackgroundWithResultBlock:^(BOOL isSuc, NSError *err) {
                if (isSuc) {
                    [SVProgressHUD showSuccessWithStatus:@"手机号绑定成功"];
                    if (_pbBlock) {
                        _pbBlock();
                    }
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[err localizedDescription]];
                }
            }];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
}

@end
