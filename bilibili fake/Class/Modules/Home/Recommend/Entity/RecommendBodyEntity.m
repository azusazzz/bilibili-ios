//
//  RecommendBodyEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendBodyEntity.h"

@implementation RecommendBodyEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"_goto": @"goto"};
}

@end
