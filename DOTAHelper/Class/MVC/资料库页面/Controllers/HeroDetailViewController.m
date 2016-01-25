//
//  HeroDetailViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/15.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "HeroDetailFirstView.h"

@interface HeroDetailViewController ()

@property (nonatomic, strong) HeroDetailFirstView * heroDetailFirstView;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIView * buttonView;

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    _heroDetailFirstView = [[HeroDetailFirstView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 275)];
       _heroDetailFirstView.model = self.model;
    [self.scrollView addSubview:_heroDetailFirstView];
    
    _buttonView = [[UIView alloc]init];
    
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_heroDetailFirstView.mas_bottom).offset(SPACING_BIG);
        make.leading.equalTo(_heroDetailFirstView.mas_leading).offset(SPACING_SMALL);
        make.trailing.equalTo(_heroDetailFirstView.mas_trailing).offset(-SPACING_SMALL);
        make.width.equalTo(@20);
    }];
    
    
}







@end
