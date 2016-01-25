//
//  VideoSecondCell.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/13.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentatorModel.h"
#import "VideoSecondListModel.h"

@interface VideoSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic, strong) CommentatorModel * firstModel;

@property (nonatomic ,strong) VideoSecondListModel * secondmodel;








@end
