//
//  RankingVideoCell.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankingVideoEntity.h"
@interface RankingVideoCell : UICollectionViewCell
@property(nonatomic,strong)RankingVideoEntity* entity;

+(CGFloat)height;
@end
