//
//  TTViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) UIActivityIndicatorView * indicatorView;

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.webView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.indicatorView];
    self.indicatorView.center = CGPointMake(SCREEN_SIZE.width / 2, 50);
    [self.indicatorView startAnimating];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:TIANTI_URL]];
    
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.indicatorView stopAnimating];
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


@end
