//
//  FirstRowCellCell.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "FirstRowCellCell.h"
#import "NewsModel.h"

@interface FirstRowCellCell ()

@property (nonatomic, strong) NSMutableArray * titleArray;

@property (nonatomic, strong) NSMutableArray * imageArray;

@end

@implementation FirstRowCellCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFirstCellDataArray:(NSArray *)firstCellDataArray
{
    _titleArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    
    for (NewsModel * model in firstCellDataArray) {
        NSString * pic = model.pic;
        NSString * title = model.title;
        
        [_imageArray addObject:pic];
        [_titleArray addObject:title];
    }
    
    if (_titleArray.count == 0) {
        return;
    }
    
    _FirstScrollView = [[LZAutoScrollView alloc]initWithFrame:self.contentView.bounds];
    _FirstScrollView.titles = _titleArray;
    _FirstScrollView.placeHolder = [UIImage imageNamed:@"common_instruct_img"];
    _FirstScrollView.images = _imageArray;
    
    [self.contentView addSubview:_FirstScrollView];
}

@end
