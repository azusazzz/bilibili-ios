//
//  UserInfoSubmitVideosEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoSubmitVideosEntity.h"


@implementation UserInfoSubmitVideosEntity
+(NSDictionary *)mj_objectClassInArray{
    return @{@"vlist":NSStringFromClass([SubmitVideoEntity class])};
}
@end

@implementation SubmitVideoEntity

@end