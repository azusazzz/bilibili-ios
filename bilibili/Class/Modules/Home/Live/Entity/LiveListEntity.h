//
//  LiveListEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveListBannerEntity.h"
#import "LiveListEntranceEntity.h"
#import "LiveListPartitionEntity.h"

@interface LiveListEntity : NSObject

@property (strong, nonatomic) NSArray<LiveListBannerEntity *> *banner;

@property (strong, nonatomic) NSArray<LiveListEntranceEntity *> *entranceIcons;

@property (strong, nonatomic) NSArray<LiveListPartitionEntity *> *partitions;

@end
