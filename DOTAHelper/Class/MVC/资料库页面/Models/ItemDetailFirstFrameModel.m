//
//  ItemDetailFirstFrameModel.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/16.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ItemDetailFirstFrameModel.h"
#import "RCLabel.h"

@implementation ItemDetailFirstFrameModel

-(void)setModel:(ItemModel *)model
{
    _model = model;
    //物品图像
    CGFloat itemIconX = SPACING_BIG;
    CGFloat itemIconY = SPACING_BIG;
    CGFloat itemIconW = 85;
    CGFloat itemIconH = (CGFloat)itemIconW * 64 / 85;
    self.itemIconFrame = CGRectMake(itemIconX, itemIconY, itemIconW, itemIconH);
    
    //物品名
    CGFloat itemNameX = CGRectGetMaxX(self.itemIconFrame) + SPACING_SMALL;
    CGFloat itemNameY = itemIconY;
    
    CGSize itemNameSize = [model.dname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.itemNameFrame = (CGRect){{itemNameX,itemNameY}, itemNameSize};
    
    //物品价格
    CGFloat itemCostX = CGRectGetMaxX(self.itemNameFrame) + SPACING_SMALL;
    CGFloat itemCostY = CGRectGetMinY(self.itemNameFrame) + SPACING_SMALL;
    CGSize itemCostSize = [[NSString stringWithFormat:@"%@", model.cost] sizeWithAttributes:@{NSFontAttributeName:FONT_ITEMCOST}];
    self.itemCostFrame = CGRectMake(itemCostX, itemCostY, itemCostSize.width + itemCostSize.height * 3, itemCostSize.height);
    
    //分割线
    CGFloat lineX = CGRectGetMinX(self.itemNameFrame);
    CGFloat lineY = CGRectGetMaxY(self.itemNameFrame) + SPACING_SMALL;
    CGFloat lineW = SCREEN_SIZE.width - CGRectGetWidth(self.itemIconFrame) - SPACING_SMALL - SPACING_BIG;
    CGFloat lineH = 1;
    self.lineFrame = CGRectMake(lineX, lineY, lineW, lineH);
    
    //lore
    CGFloat itemLoreX = CGRectGetMinX(self.lineFrame);
    CGFloat itemLoreY = CGRectGetMaxY(self.lineFrame) + SPACING_SMALL;
    CGFloat itemLoreW = CGRectGetWidth(self.lineFrame);
    CGFloat itemLoreH = CGRectGetMaxY(self.itemIconFrame) - itemLoreY;
    self.itemLoreFrame = CGRectMake(itemLoreX, itemLoreY, itemLoreW, itemLoreH);
    
    //attrib
    if ([model.attrib isEqualToString:@""]) {
        self.itemAttribFrame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        CGFloat itemAttribX = CGRectGetMinX(self.itemIconFrame);
        CGFloat itemAttribY = CGRectGetMaxY(self.itemIconFrame) + SPACING_SMALL;
        CGFloat itemAttribW = SCREEN_SIZE.width - 2 * SPACING_BIG;
        CGFloat itemAttribH = 200;
        self.itemAttribFrame = CGRectMake(itemAttribX, itemAttribY, itemAttribW, itemAttribH);
        RCLabel * info = [[RCLabel alloc]initWithFrame:self.itemAttribFrame];
        [info setFont:FONT_ITEMATTRIB];
        info.componentsAndPlainText = [RCLabel extractTextStyle:model.attrib];
        CGSize optimalSize = [info optimumSize];
        info.frame = CGRectMake(info.frame.origin.x, info.frame.origin.y, info.frame.size.width, optimalSize.height);
        self.itemAttribFrame = info.frame;
    }
    
    
    //desc
    if ([model.desc isEqualToString:@""]) {
        self.itemDescFrame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        CGFloat itemDescX = CGRectGetMinX(self.itemIconFrame);
        CGFloat itemDescY = CGRectGetMaxY(self.itemAttribFrame) + SPACING_BIG;
        CGFloat itemDescW = SCREEN_SIZE.width - 2 * SPACING_BIG;
        CGFloat itemDescH = 200;
        self.itemDescFrame = CGRectMake(itemDescX, itemDescY, itemDescW, itemDescH);
        
        RCLabel * info = [[RCLabel alloc]initWithFrame:self.itemDescFrame];
        [info setFont:FONT_ITEMATTRIB];
        info.componentsAndPlainText = [RCLabel extractTextStyle:model.attrib];
        CGSize optimalSize = [info optimumSize];
        info.frame = CGRectMake(info.frame.origin.x, info.frame.origin.y, info.frame.size.width, optimalSize.height);
        self.itemDescFrame = info.frame;
    }
    
    //cd
    
    if ([model.cd isEqualToString:@"0"]) {
        self.itemCdFrame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        CGFloat itemCdX = CGRectGetMinX(self.itemIconFrame);
        CGFloat itemCdY = CGRectGetMaxY(self.itemDescFrame) + SPACING_BIG;
        NSString * cd = [NSString stringWithFormat:@"%@", model.cd];
        CGSize itemCdSize = [cd sizeWithAttributes:@{NSFontAttributeName:FONT_CD}];
        self.itemCdFrame = CGRectMake(itemCdX, itemCdY, itemCdSize.width + itemCdSize.height, itemCdSize.height);
    }
    
    //mc
    if ([model.mc isEqualToString:@"0"]) {
        self.itemMcFrame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        CGFloat itemMcX = CGRectGetMinX(self.itemIconFrame) + 120;
        CGFloat itemMcY = CGRectGetMaxY(self.itemDescFrame) + SPACING_BIG;
        NSString * mc = [NSString stringWithFormat:@"%@", model.mc];
        CGSize itemMcSize = [mc sizeWithAttributes:@{NSFontAttributeName:FONT_CD}];
        self.itemMcFrame = CGRectMake(itemMcX, itemMcY, itemMcSize.width + itemMcSize.height, itemMcSize.height);
    }
    
    self.cellHeight = CGRectGetMaxY(self.itemMcFrame);
    
}





@end
