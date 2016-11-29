//
//  BangumiInfoEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoEntity.h"

@implementation BangumiInfoEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"episodes": NSStringFromClass([BangumiEpisodeEntity class]),};
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"evaluateHeight"];
}

@end
