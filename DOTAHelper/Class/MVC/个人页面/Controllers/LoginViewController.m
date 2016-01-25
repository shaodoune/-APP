//
//  LoginViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Tool.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkTextFields];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBG.jpg"]];
    self.navigationController.navigationBar.translucent = YES;
}
- (IBAction)userName:(UITextField *)sender {
    [self checkTextFields];
}
- (IBAction)password:(UITextField *)sender {
    [self checkTextFields];
}



-(void)checkTextFields
{
    if (self.userNameTF.text.length > 0 && self.passwordTF.text.length > 0) {
        self.loginButton.enabled = YES;
    }
    else
    {
        self.loginButton.enabled = NO;
    }
}

#pragma mark - 按钮响应事件
- (IBAction)login:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    [SVProgressHUD showWithStatus:@"登录中..." maskType:SVProgressHUDMaskTypeClear];
    NSString * pwdMDTStr = [Tool MD5StringFromString:self.passwordTF.text];
    
    [BmobUser loginWithUsernameInBackground:self.userNameTF.text password:pwdMDTStr block:^(BmobUser *user, NSError *error) {
        sender.userInteractionEnabled = YES;
        if (user) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_REFRESH_NOTICE object:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            NSString * msg = nil;
            if (error.code == 101) {
                msg = @"账号或密码错误";
            }
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    }];
    
}


@end
