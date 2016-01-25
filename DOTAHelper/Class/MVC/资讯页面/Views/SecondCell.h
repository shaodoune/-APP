//
//  SecondCell.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface SecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *newsImg;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDetail;
@property (weak, nonatomic) IBOutlet UILabel *newsTime;


@property (nonatomic, strong) NewsModel * model;

@end
