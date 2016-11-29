//
//  BangumiListEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiBannerEntity.h"

#import "BangumiEntity.h"

#import "BangumiRecommendEntity.h"
#import "BangumiEntranceEntity.h"

@interface BangumiListEntity : NSObject

@property (strong, nonatomic) NSArray<BangumiBannerEntity *> *banners;

@property (strong, nonatomic) NSArray<BangumiEntity *> *ends;

@property (strong, nonatomic) NSArray<BangumiEntity *> *latestUpdate;


@property (strong, nonatomic) NSArray<BangumiEntranceEntity *> *entrances;

@property (strong, nonatomic) NSArray<BangumiRecommendEntity *> *recommends;

@end
