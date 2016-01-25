//
//  ItemDetailFirstCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ItemDetailFirstCell.h"
#import "RCLabel.h"
#import "ItemModel.h"
#import "ItemCostView.h"
#import "CdMcView.h"

@interface ItemDetailFirstCell ()

@property (nonatomic, strong) UIImageView * itemIconImageView;

@property (nonatomic, strong) UILabel * itemNameLabel;

@property (nonatomic, strong) ItemCostView * itemCostView;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UILabel * itemLoreLabel;

@property (nonatomic, strong) RCLabel * itemAttribLabel;

@property (nonatomic, strong) RCLabel * itemDescLabel;

@property (nonatomic, strong) CdMcView * itemCdView;

@property (nonatomic, strong) CdMcView * itemMcView;


@end



@implementation ItemDetailFirstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self generateSubViews];
    }
    return self;
}

-(void)generateSubViews
{
    self.itemIconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.itemIconImageView];
    
    self.itemNameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.itemNameLabel];
    
    self.itemCostView = [[ItemCostView alloc]init];
    [self.contentView addSubview:self.itemCostView];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.lineView];
    
    self.itemLoreLabel = [[UILabel alloc]init];
    self.itemLoreLabel.numberOfLines = 2;
    [self.contentView addSubview:self.itemLoreLabel];
    
    self.itemAttribLabel = [[RCLabel alloc]init];
    [self.contentView addSubview:self.itemAttribLabel];
    
    self.itemDescLabel = [[RCLabel alloc]init];
    [self.contentView addSubview:self.itemDescLabel];
    
    self.itemCdView = [[CdMcView alloc]init];
    [self.contentView addSubview:self.itemCdView];
    
    self.itemMcView = [[CdMcView alloc]init];
    [self.contentView addSubview:self.itemMcView];
}

-(void)setFrameModel:(ItemDetailFirstFrameModel *)frameModel
{
    ItemModel * itemModel = frameModel.model;
    
    self.itemIconImageView.frame = frameModel.itemIconFrame;
    self.itemIconImageView.image = [UIImage imageNamed:itemModel.img];
    
    self.itemNameLabel.frame = frameModel.itemNameFrame;
    self.itemNameLabel.text = itemModel.dname;
    self.itemNameLabel.font = FONT_ITEMNAME;
    
    self.itemCostView.frame = frameModel.itemCostFrame;
    self.itemCostView.cost = [NSString stringWithFormat:@"%@", itemModel.cost];

    
    self.lineView.frame = frameModel.lineFrame;
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    
    self.itemLoreLabel.frame = frameModel.itemLoreFrame;
    self.itemLoreLabel.text = itemModel.lore;
    self.itemLoreLabel.font = FONT_ITEMLORE;
    self.itemLoreLabel.contentMode = UIViewContentModeTop;
    
    self.itemAttribLabel.frame = frameModel.itemAttribFrame;
    self.itemAttribLabel.componentsAndPlainText = [RCLabel extractTextStyle:itemModel.attrib];
    
    self.itemDescLabel.frame = frameModel.itemDescFrame;
    self.itemDescLabel.componentsAndPlainText = [RCLabel extractTextStyle:itemModel.desc];
    
    self.itemCdView.frame = frameModel.itemCdFrame;
    NSDictionary * dic = @{@"imageName":@"cooldown", @"number":[NSString stringWithFormat:@"%@", itemModel.cd]};
    self.itemCdView.dic = dic;
    
    self.itemMcView.frame = frameModel.itemMcFrame;
    NSString * number = [NSString stringWithFormat:@"%@", itemModel.mc];
    NSDictionary * dic2 = @{@"imageName":@"mofa", @"number":number};
    self.itemMcView.dic = dic2;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
