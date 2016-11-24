//
//  ProjectUpdate.h
//  bilibili fake
//
//  Created by cxh on 16/11/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateAddressEntity.h"
@interface ProjectUpdate : NSObject

+(instancetype)share;

-(NSString*)update;

@property(nonatomic,strong,readonly)UpdateAddressEntity* entity;

@end
