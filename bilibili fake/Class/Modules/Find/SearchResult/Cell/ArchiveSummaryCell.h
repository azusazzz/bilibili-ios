//
//  ArchiveSummaryCell.h
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArchiveSummaryEntity.h"

@interface ArchiveSummaryCell : UICollectionViewCell

@property(nonatomic,strong)ArchiveSummaryEntity* entity;

@property(nonatomic)NSInteger orderType;//筛选条件

+(CGFloat)height;
@end
