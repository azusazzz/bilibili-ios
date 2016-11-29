//
//  UserInfoFavoritesEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoFavoritesEntity.h"

@implementation UserInfoFavoritesEntity

+(NSDictionary *)mj_objectClassInArray{
    return @{@"videos":NSStringFromClass([FavoritesVideoEntity class])};
}

@end
@implementation FavoritesVideoEntity

@end