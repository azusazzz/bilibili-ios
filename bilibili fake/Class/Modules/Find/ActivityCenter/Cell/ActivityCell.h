//
//  ActivityCell.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityEntity.h"

@interface ActivityCell : UICollectionViewCell

+(CGFloat)height;

@property(nonatomic,strong)ActivityEntity* entity;

@end
