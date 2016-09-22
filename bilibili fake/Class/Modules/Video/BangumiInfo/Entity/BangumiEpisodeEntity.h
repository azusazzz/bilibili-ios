//
//  BangumiEpisodeEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangumiEpisodeEntity : NSObject

@property (assign, nonatomic) NSInteger av_id;

@property (assign, nonatomic) NSInteger coins;

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) NSInteger danmaku;

@property (assign, nonatomic) NSInteger episode_id;

@property (assign, nonatomic) NSInteger episode_status;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSString *index_title;

@property (assign, nonatomic) BOOL is_new;

@property (assign, nonatomic) BOOL is_webplay;

@property (assign, nonatomic) NSInteger mid;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSDictionary *up;

@property (strong, nonatomic) NSString *update_time;

@end
