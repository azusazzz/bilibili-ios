//
//  LiveListPartitionEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveListPartitionLiveEntity.h"


/**
 *  直播列表-分区
 */
@interface LiveListPartitionEntity : NSObject

@property (assign, nonatomic) NSInteger id;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *area;

@property (assign, nonatomic) NSInteger count;

@property (strong, nonatomic) NSArray<LiveListPartitionLiveEntity *> *lives;

#pragma mark sub_icon

@property (strong, nonatomic) NSString *icon_src;

@property (assign, nonatomic) CGFloat icon_height;

@property (assign, nonatomic) CGFloat icon_width;

@end
