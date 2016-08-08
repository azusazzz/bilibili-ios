//
//  BangumiListEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiListEntity.h"

@implementation BangumiListEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"banners": NSStringFromClass([BangumiBannerEntity class]),
             @"ends": NSStringFromClass([BangumiEntity class]),
             @"latestUpdate": NSStringFromClass([BangumiEntity class])};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"latestUpdate": @"latestUpdate.list"};
}


+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"recommends", @"entrances"];
}

@end
