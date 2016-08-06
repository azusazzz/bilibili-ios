//
//  LiveCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListPartitionLiveEntity.h"

@interface LiveCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) LiveListPartitionLiveEntity *live;

+ (CGFloat)heightForWitdh:(CGFloat)width;

@end
