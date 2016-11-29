//
//  RegionEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionChildEntity.h"

/**
 *  分区
 */
@interface RegionEntity : NSObject

@property (assign, nonatomic) NSInteger tid;

@property (assign, nonatomic) NSInteger reid;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *logo;

@property (strong, nonatomic) NSString *_goto;

@property (strong, nonatomic) NSString *param;

@property (strong, nonatomic) NSArray<RegionChildEntity *> *children;

@end
