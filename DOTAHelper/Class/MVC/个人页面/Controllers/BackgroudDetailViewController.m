//
//  BackgroudDetailViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "BackgroudDetailViewController.h"
#import "NetworkingManager.h"

@interface BackgroudDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic , strong) UIActivityIndicatorView * indicatorView;

@end

@implementation BackgroudDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateUI
{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_iinstruct_img"]];
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.webView addSubview:self.indicatorView];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = YES;
    self.indicatorView.center = CGPointMake(SCREEN_SIZE.width / 2, 50);
    
    NSURLRequest * reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.imgurl]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.webView loadRequest:reuqest];
    });
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView removeFromSuperview];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"加载失败" maskType: SVProgressHUDMaskTypeClear];
}



@end
