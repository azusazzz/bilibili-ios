//
//  UPUserSummaryCell.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPUserSummaryEntity.h"
@interface UPUserSummaryCell : UICollectionViewCell

@property(nonatomic,strong)UPUserSummaryEntity* entity;

+(CGFloat)height;

@end
