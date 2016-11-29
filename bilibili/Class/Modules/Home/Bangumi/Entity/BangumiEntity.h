//
//  BangumiEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangumiEntity : NSObject

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) NSInteger last_time;

@property (assign, nonatomic) NSInteger newest_ep_id;

@property (assign, nonatomic) NSInteger newest_ep_index;

@property (assign, nonatomic) NSInteger season_id;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger total_count;

@property (assign, nonatomic) NSInteger watchingCount;

@end
