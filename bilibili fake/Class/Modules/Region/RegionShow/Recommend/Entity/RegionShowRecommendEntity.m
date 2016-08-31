//
//  RegionShowRecommendEntity.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowRecommendEntity.h"

@implementation RegionShowRecommendEntity


+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"banners": NSStringFromClass([RegionShowBannerEntity class]),
             @"recommends": NSStringFromClass([RegionShowVideoEntity class]),
             @"news": NSStringFromClass([RegionShowVideoEntity class]),
             @"dynamics": NSStringFromClass([RegionShowVideoEntity class]),};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"banners": @"banner.top",
             @"recommends": @"recommend",
             @"news": @"new",
             @"dynamics": @"dynamic",};
}



@end
