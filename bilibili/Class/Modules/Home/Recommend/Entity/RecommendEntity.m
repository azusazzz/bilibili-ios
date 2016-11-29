//
//  RecommendEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendEntity.h"

@implementation RecommendEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"body": NSStringFromClass([RecommendBodyEntity class]),
             @"banner_top": NSStringFromClass([RecommendBannerEntity class]),
             @"banner_bottom": NSStringFromClass([RecommendBannerEntity class])};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"banner_top": @"banner.top",
             @"banner_bottom": @"banner.bottom"};
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"logoIconNmae"];
}

@end
