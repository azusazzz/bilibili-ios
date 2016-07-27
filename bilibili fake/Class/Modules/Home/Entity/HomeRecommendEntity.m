//
//  HomeRecommendEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendEntity.h"

@implementation HomeRecommendEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"body": NSStringFromClass([HomeRecommendBodyEntity class]),
             @"banner_top": NSStringFromClass([HomeRecommendBannerEntity class]),
             @"banner_bottom": NSStringFromClass([HomeRecommendBannerEntity class])};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"banner_top": @"banner.top",
             @"banner_bottom": @"banner.bottom"};
}


@end


@implementation HomeRecommendBodyEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"_goto": @"goto"};
}

@end

@implementation HomeRecommendBannerEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"_hash": @"hash"};
}


@end