//
//  VideoInfoEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoInfoEntity.h"

@implementation VideoInfoEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"pages": NSStringFromClass([VideoPageInfoEntity class]), @"relates": NSStringFromClass([VideoInfoEntity class])};
}

@end

