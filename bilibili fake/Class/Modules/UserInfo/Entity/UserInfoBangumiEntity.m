//
//  UserInfoBangumiEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoBangumiEntity.h"

@implementation UBangumiEntity

@end

@implementation UserInfoBangumiEntity
+(NSDictionary *)mj_objectClassInArray{
    return @{@"result":NSStringFromClass([UBangumiEntity class])};
}
@end
