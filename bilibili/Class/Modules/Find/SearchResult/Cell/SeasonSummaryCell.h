//
//  SeasonSummaryCell.h
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeasonSummaryEntity.h"

@interface SeasonSummaryCell : UICollectionViewCell

@property(nonatomic,strong)SeasonSummaryEntity* entity;

+(CGFloat)height;

@end
