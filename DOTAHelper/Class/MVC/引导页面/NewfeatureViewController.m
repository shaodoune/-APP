//
//  NewfeatureViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/20.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "MainViewController.h"

#define IMG_NUMBER 3

@interface NewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNewFeatureImgs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatNewFeatureImgs
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * IMG_NUMBER, 0);
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    self.scrollView.delegate = self;
    
    for (int i = 0; i < IMG_NUMBER; i++) {
        NSString * imgName = [NSString stringWithFormat:@"yindaoye%d", i+1];
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(w * i, 0, w, h)];
        imgView.image = [UIImage imageNamed:imgName];
        imgView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imgView];
        
        if (i == IMG_NUMBER - 1)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [imgView addSubview:btn];
            [btn setTitle:@"开启应用" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor orangeColor];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(imgView.mas_leading).offset(100);
                make.trailing.equalTo(imgView.mas_trailing).offset(-100);
                make.centerY.equalTo(imgView.mas_bottom).offset(-150);
            }];
            
            btn.layer.cornerRadius = 11;
            
            [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    self.pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(100);
        make.trailing.equalTo(self.view.mas_trailing).offset(-100);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
}

-(void)buttonClicked
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController * root = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    UIView * shotView = [self.view snapshotViewAfterScreenUpdates:YES];
    [root.view addSubview:shotView];
    
    self.view.window.rootViewController = root;
    
    [UIView animateWithDuration:1.f animations:^{
        shotView.transform = CGAffineTransformScale(shotView.transform, 1.2, 1.2);
        shotView.alpha = 0;
    }completion:^(BOOL finished) {
        [shotView removeFromSuperview];
    }];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CATransition * transition = [CATransition animation];
    transition.duration  = 2;
    transition.type = @"cameraIris";
    transition.subtype = @"fromTop";
    [self.view.superview.layer addAnimation:transition forKey:nil];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = self.scrollView.contentOffset.x / SCREEN_SIZE.width;
    self.pageControl.currentPage = index;
}

@end
