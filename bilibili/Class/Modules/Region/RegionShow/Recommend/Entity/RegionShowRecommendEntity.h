//
//  RegionShowRecommendEntity.h
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionShowBannerEntity.h"
#import "RegionShowVideoEntity.h"

@interface RegionShowRecommendEntity : NSObject

@property (strong, nonatomic) NSArray<RegionShowBannerEntity *> *banners;

@property (strong, nonatomic) NSArray<RegionShowVideoEntity *> *recommends;

@property (strong, nonatomic) NSArray<RegionShowVideoEntity *> *news;

@property (strong, nonatomic) NSArray<RegionShowVideoEntity *> *dynamics;

@end
