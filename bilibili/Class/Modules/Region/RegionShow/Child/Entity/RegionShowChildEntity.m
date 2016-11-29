//
//  RegionShowChildEntity.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowChildEntity.h"

@implementation RegionShowChildEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"recommends": NSStringFromClass([RegionShowVideoEntity class]),
             @"news": NSStringFromClass([RegionShowVideoEntity class])};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"recommends": @"recommend",
             @"news": @"new",};
}

@end
