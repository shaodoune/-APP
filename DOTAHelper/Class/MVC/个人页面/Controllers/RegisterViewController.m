//
//  RegisterViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "RegisterViewController.h"
#import "Tool.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIButton *rgBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkTextFields];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"registerBG.jpg"]];
    self.navigationController.navigationBar.translucent = YES;
}
- (IBAction)userNameEditingChanged:(UITextField *)sender {
    [self checkTextFields];
}
- (IBAction)passwordEditingChanged:(UITextField *)sender {
    [self checkTextFields];
}

- (void) checkTextFields
{
    // 当两个textfiled里面都有值的时候才让 注册按钮可点，否则不可点
    if (self.userName.text.length > 0 && self.password.text.length > 0) {
        self.rgBtn.enabled = YES;
    }else {
        self.rgBtn.enabled = NO;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rgClicked:(UIButton *)sender {
    
    BmobUser * user = [[BmobUser alloc]init];
    
    user.username = self.userName.text;
    
    NSString * pwdMD5Str = [Tool MD5StringFromString:self.password.text];
    
    user.password = pwdMD5Str;
    
    if (self.email.text.length > 0) {
        user.email = self.email.text;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
}


@end
