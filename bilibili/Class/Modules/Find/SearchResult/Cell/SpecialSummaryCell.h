//
//  SpecialSummaryCell.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialSummaryEntity.h"
@interface SpecialSummaryCell : UICollectionViewCell

@property(nonatomic,strong)SpecialSummaryEntity* entity;

+(CGFloat)height;

@end
