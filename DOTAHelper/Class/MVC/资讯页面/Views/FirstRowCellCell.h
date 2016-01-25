//
//  FirstRowCellCell.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZAutoScrollView.h"

@interface FirstRowCellCell : UITableViewCell

@property (nonatomic, strong) NSArray * firstCellDataArray;

@property (nonatomic, strong) LZAutoScrollView * FirstScrollView;

@end
