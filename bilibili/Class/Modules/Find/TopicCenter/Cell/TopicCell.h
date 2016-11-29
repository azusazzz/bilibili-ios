//
//  TopicCell.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicEntity.h"

@interface TopicCell : UICollectionViewCell

+(CGFloat)height;

@property(nonatomic,strong)TopicEntity* entity;

@end
