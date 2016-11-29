//
//  LiveListEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListEntity.h"

@implementation LiveListEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"banner": NSStringFromClass([LiveListBannerEntity class]),
             @"entranceIcons": NSStringFromClass([LiveListEntranceEntity class]),
             @"partitions": NSStringFromClass([LiveListPartitionEntity class])};
}


@end
