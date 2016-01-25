//
//  BackgroundCollectionViewCell.h
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundModel.h"

@interface BackgroundCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, strong) BackgroundModel * BGmodel;

@end
