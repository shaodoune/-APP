//
//  WallPaperCollectionViewCell.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallPaperModel.h"

@interface WallPaperCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, strong) WallPaperModel * WPmodel;


@end
