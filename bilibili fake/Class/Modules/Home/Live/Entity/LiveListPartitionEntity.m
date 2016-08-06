//
//  LiveListPartitionEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListPartitionEntity.h"

@implementation LiveListPartitionEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"lives": NSStringFromClass([LiveListPartitionLiveEntity class])};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"id": @"partition.id",
             @"name": @"partition.name",
             @"area": @"partition.area",
             @"count": @"partition.count",
             
             @"icon_src": @"partition.sub_icon.src",
             @"icon_height": @"partition.sub_icon.height",
             @"icon_width": @"partition.sub_icon.width"};
}


@end
