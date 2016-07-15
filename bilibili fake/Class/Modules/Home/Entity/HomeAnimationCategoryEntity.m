//
//  HomeAnimationCategoryEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationCategoryEntity.h"

@implementation HomeAnimationCategoryEntity

+ (NSArray *)mj_ignoredPropertyNames; {
    return @[@"list", @"count"];
}

@end

@implementation HomeAnimationCategoryItemEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"pNew_ep": @"new_ep"};
}

@end

@implementation HomeAnimationCategoryItemNewEpEntity

@end