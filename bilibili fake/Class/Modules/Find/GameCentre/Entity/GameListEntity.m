//
//  GameListEntity.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameListEntity.h"

@implementation GameListEntity
+(NSDictionary *)mj_objectClassInArray{
    return @{@"gameList":NSStringFromClass([GameEntity class])};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"gameList" : @"items"};
}
@end
