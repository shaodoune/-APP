//
//  NewsDetailViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NetworkingManager.h"

@interface NewsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NetworkingManager * manager;

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation NewsDetailViewController

-(NetworkingManager *)manager
{
    if (!_manager) {
        _manager = [NetworkingManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self customNavigationBar];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    NSArray * dateArray = [self.model.date componentsSeparatedByString:@"-"];
    NSString * date = [dateArray componentsJoinedByString:@""];
    NSURL * URL = [[NSURL alloc]init];
    if (self.model.ID) {
        URL = [NSURL URLWithString:[NSString stringWithFormat:NEWS_DETAIL_URL, date, self.model.ID]];
    }
    else
    {
        URL = [NSURL URLWithString:self.model.url];
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
    
    [SVProgressHUD showWithStatus:@"努力加载中..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

//-(void)customNavigationBar
//{
//    UINavigationItem * item = self.navigationItem;
//    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    _button.frame = CGRectMake(0, 0, 30, 30);
//    [_button setImage:[UIImage imageNamed:@"mine_icon_share"] forState:UIControlStateNormal];
//    [_button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    _button.layer.cornerRadius = 15;
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
//    NSArray *imgs = @[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]]];
//    if (imgs) {
//        NSMutableDictionary *pramas = @{}.mutableCopy;
//        [pramas SSDKSetupShareParamsByText:self.model.title
//                                    images:imgs
//                                       url:[NSURL URLWithString:self.model.url]
//                                     title:@"最新DOTA新闻" type:SSDKContentTypeAuto];
//        
//        [ShareSDK showShareActionSheet:self.view
//                                 items:nil
//                           shareParams:pramas
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                               NSLog(@"分享成功");
//                               break;
//                           case SSDKResponseStateFail:
//                               NSLog(@"分享失败 error =%@",[error localizedDescription]);
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
