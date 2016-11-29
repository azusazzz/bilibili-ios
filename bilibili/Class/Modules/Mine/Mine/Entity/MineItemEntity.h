//
//  MineItemEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineItemEntity : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *logoName;

+ (instancetype)entityWithTitle:(NSString *)title logoName:(NSString *)logoName;

@end
