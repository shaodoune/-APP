//
//  VideoSecondDetailViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "VideoSecondDetailViewController.h"

@interface VideoSecondDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UIActivityIndicatorView * indicatorView;

@end

@implementation VideoSecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
//    [self customNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createUI
{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.center = CGPointMake(SCREEN_SIZE.width / 2, 50);
    [self.view addSubview:self.indicatorView];
    self.webView.delegate = self;
    [self.indicatorView startAnimating];
    
    NSString * url = [NSString stringWithFormat:VIDEO_PLAY_URL, self.model.video_id];
//    NSLog(@"%@", url);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:request];
    
//    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"qheader_box\").style.display=\"none\";"];
}


//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    NSLog(@"url = %@",request.URL.absoluteString);
//    return YES;
//}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicatorView startAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.indicatorView stopAnimating];
//    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}

#pragma mark - 视图控制器消失，移走SVProgressHUD
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 分享

//-(void)customNavigationBar
//{
//    UINavigationItem * item = self.navigationItem;
//    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    _button.frame = CGRectMake(0, 0, 40, 40);
//    [_button setImage:[UIImage imageNamed:@"mine_icon_share"] forState:UIControlStateNormal];
//    [_button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    _button.layer.cornerRadius = 20;
//    _button.layer.borderColor = [UIColor blackColor].CGColor;
//    _button.layer.borderWidth = 1;
//    _button.clipsToBounds = YES;
//    
//    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:_button];
//    item.rightBarButtonItem = right;
//}

//-(void)share
//{
//    
//    NSArray *imgs = @[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.thumbnail]]]];
//    if (imgs) {
//        NSMutableDictionary *pramas = @{}.mutableCopy;
//        [pramas SSDKSetupShareParamsByText:self.model.title
//                                    images:imgs
//                                       url:[NSURL URLWithString:self.model.link]
//                                     title:@"DOTA视频" type:SSDKContentTypeAuto];
//        
//        [ShareSDK showShareActionSheet:self.view
//                                 items:nil
//                           shareParams:pramas
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                               NSLog(@"分享成功");
//                               break;
//                           case SSDKResponseStateFail:
//                               NSLog(@"分享失败 error =%@",error);
//                               break;
//                           case SSDKResponseStateCancel:
//                               NSLog(@"用户取消分享");
//                               break;
//                               
//                           default:
//                               break;
//                       }
//                   }];
//        
//    }
//}



@end
