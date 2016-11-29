//
//  MovieSummaryCell.h
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieSummaryEntity.h"

@interface MovieSummaryCell : UICollectionViewCell

@property(nonatomic,strong)MovieSummaryEntity* entity;

+(CGFloat)height;

@end
