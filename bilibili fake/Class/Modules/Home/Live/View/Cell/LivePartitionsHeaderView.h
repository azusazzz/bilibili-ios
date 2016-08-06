//
//  LivePartitionsHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListPartitionEntity.h"

@interface LivePartitionsHeaderView : UICollectionReusableView

@property (strong, nonatomic) LiveListPartitionEntity *partition;

+ (CGFloat)height;

@end
