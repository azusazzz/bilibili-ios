//
//  RegionEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionEntity.h"

@implementation RegionEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"children": NSStringFromClass([RegionChildEntity class])};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"_goto": @"goto"};
}

@end
