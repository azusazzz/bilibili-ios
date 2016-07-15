//
//  HomeChannelModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeChannelEntity.h"

@interface HomeChannelModel : NSObject

@property (strong, nonatomic) NSArray<HomeChannelEntity *> *entitys;

- (instancetype)initWithJSONObject:(id)JSONObject;

@end
