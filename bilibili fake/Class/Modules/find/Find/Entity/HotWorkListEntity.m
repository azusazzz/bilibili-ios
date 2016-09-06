//
//  HotWorksEntity.m
//  bilibili fake
//
//  Created by C on 16/9/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HotWorkListEntity.h"

@implementation HotWorkListEntity
+(NSDictionary *)mj_objectClassInArray{
    return @{@"hotWorkList":NSStringFromClass([HotWorkEntity class])};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"hotWorkList" : @"list"};
}
@end
