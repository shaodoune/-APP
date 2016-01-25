//
//  LiveViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "LiveViewController.h"

@interface LiveViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) UIActivityIndicatorView * indicatorView;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
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
    self.indicatorView.center = CGPointMake(SCREEN_SIZE.width / 2, 50);
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    NSString * url = [NSString stringWithFormat:LIVE_URL, self.model.roomid];
    
    NSLog(@"%@", url);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}



@end
