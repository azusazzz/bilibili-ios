//
//  LiveListPartitionLiveEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListPartitionLiveEntity.h"

@implementation LiveListPartitionLiveEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"owner_face": @"owner.face",
             @"owner_mid": @"owner.mid",
             @"owner_name": @"owner.name",
             
             @"cover_src": @"cover.src",
             @"cover_height": @"cover.height",
             @"cover_width": @"cover.width",};
}


@end
