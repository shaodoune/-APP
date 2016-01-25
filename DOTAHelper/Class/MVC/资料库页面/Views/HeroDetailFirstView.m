//
//  HeroDetailFirstView.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/21.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "HeroDetailFirstView.h"
#import <AVFoundation/AVFoundation.h>

@interface HeroDetailFirstView ()

@property (nonatomic, strong) UIView * playerView;

@property (nonatomic, strong) AVPlayer * avPlayer;

@property (nonatomic, strong) UILabel * HeroName;

@property (nonatomic, strong) UIView * line;

@property (nonatomic, strong) UILabel * zhenyingLabel;

@property (nonatomic, strong) UILabel * gongjileixingLabel;

@property (nonatomic, strong) UILabel * dingweiLabel;

@end

@implementation HeroDetailFirstView

-(void)setModel:(HeroDetailModel *)model
{
    if (!_playerView) {
        _playerView = [[UIView alloc]init];
        [self addSubview:_playerView];
    }
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(SPACING_NORMAL);
        make.top.equalTo(self.mas_top).offset(SPACING_NORMAL);
        make.width.equalTo(@235);
        make.height.equalTo(@272);
    }];
    
    if (!_avPlayer) {
        NSString * path = [[NSBundle mainBundle]pathForResource:self.model.zwm ofType:@"m4v"];
        _avPlayer = [[AVPlayer alloc]init];
    }
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    CALayer * playerViewLayer = self.playerView.layer;
    [playerViewLayer addSublayer:playerLayer];
    playerLayer.frame = self.playerView.bounds;
    
    
    if (!_HeroName) {
        _HeroName = [[UILabel alloc]init];
        [self addSubview:_HeroName];
    }
    [_HeroName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_HeroName.mas_trailing).offset(SPACING_SMALL);
        make.top.equalTo(_HeroName.mas_top);
        make.trailing.equalTo(self.mas_trailing).offset(SPACING_NORMAL);
    }];
    NSString * heroName = [NSString stringWithFormat:@"英雄名称:%@(%@)%@", self.model.zwm, self.model.jc, self.model.ywm];
    _HeroName.text = heroName;
    
    if (!_line) {
        _line = [[UIView alloc]init];
        [self addSubview:_line];
    }
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_HeroName.mas_bottom).offset(SPACING_SMALL);
        make.leading.equalTo(_HeroName.mas_leading);
        make.trailing.equalTo(_HeroName.mas_trailing);
        make.width.equalTo(@1);
    }];
    
    if (!_zhenyingLabel) {
        _zhenyingLabel = [[UILabel alloc]init];
    }
    [_zhenyingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_line.mas_leading);
        make.trailing.equalTo(_line.mas_trailing);
        make.top.equalTo(_line.mas_bottom).offset(SPACING_SMALL);
    }];
    NSString * zhenying = [NSString stringWithFormat:@"  阵营:%@", self.model.zymc];
    _zhenyingLabel.text = zhenying;
    
    if (!_gongjileixingLabel) {
        _gongjileixingLabel = [[UILabel alloc]init];
        [self addSubview:_gongjileixingLabel];
    }
    [_gongjileixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_zhenyingLabel.mas_leading);
        make.trailing.equalTo(_zhenyingLabel.mas_leading);
        make.top.equalTo(_zhenyingLabel.mas_bottom).offset(SPACING_SMALL);
    }];
    NSString * gongjileixing = [NSString stringWithFormat:@"攻击类型:%@", self.model.gjlx];
    _gongjileixingLabel.text = gongjileixing;
    
    if (!_dingweiLabel) {
        _dingweiLabel = [[UILabel alloc]init];
        [self addSubview:_dingweiLabel];
    }
    [_dingweiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_gongjileixingLabel.mas_leading);
        make.trailing.equalTo(_gongjileixingLabel.mas_trailing);
        make.bottom.equalTo(_playerView.mas_bottom);
    }];
    NSString * dingwei = [NSString stringWithFormat:@"  定位:%@", self.model.yxdw];
    _dingweiLabel.text = dingwei;
}



@end
