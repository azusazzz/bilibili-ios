//
//  UserInfoGameEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoGameEntity.h"

@implementation UGameEntity

@end

@implementation UserInfoGameEntity
+(NSDictionary *)mj_objectClassInArray{
    return @{@"games":NSStringFromClass([UGameEntity class])};
}
@end
