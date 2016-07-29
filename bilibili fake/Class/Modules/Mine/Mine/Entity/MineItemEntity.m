//
//  MineItemEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MineItemEntity.h"

@implementation MineItemEntity

+ (instancetype)entityWithTitle:(NSString *)title logoName:(NSString *)logoName {
    MineItemEntity *entity = [[self alloc] init];
    entity.title = title;
    entity.logoName = logoName;
    return entity;
}

@end
