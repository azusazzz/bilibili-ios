//
//  UserInfoElecEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoElecEntity.h"

@implementation UserInfoElecEntity

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":NSStringFromClass([UserInfoElecPayuserEntity class])};
}

@end
@implementation UserInfoElecPayuserEntity

@end
