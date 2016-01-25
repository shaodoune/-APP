//
//  ScoreViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation ScoreViewController

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self customNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatUI
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:PERSON_SOCRE_URL]];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    return;
}

-(void)customNavigationBar
{
    UINavigationItem * item = self.navigationItem;
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(back)];
    item.leftBarButtonItem = left;
}

-(void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
