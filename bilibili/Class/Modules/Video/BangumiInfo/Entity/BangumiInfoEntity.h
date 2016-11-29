//
//  BangumiInfoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiEpisodeEntity.h"

@interface BangumiInfoEntity : NSObject

@property (strong, nonatomic) NSArray *actor;

/**
 *  别名
 */
@property (strong, nonatomic) NSString *alias;

@property (assign, nonatomic) BOOL allow_bp;

/**
 *  允许下载
 */
@property (assign, nonatomic) BOOL allow_download;

@property (assign, nonatomic) NSInteger bangumi_id;

@property (strong, nonatomic) NSString *bangumi_title;

@property (strong, nonatomic) NSString *brief;

@property (assign, nonatomic) NSInteger coins;

@property (strong, nonatomic) NSString *copyright;

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) NSInteger danmaku_count;

@property (strong, nonatomic) NSArray<BangumiEpisodeEntity *> *episodes;

@property (strong, nonatomic) NSString *evaluate;

@property (assign, nonatomic) NSInteger favorites;

@property (assign, nonatomic) BOOL is_finish;

@property (strong, nonatomic) NSString *jp_title;

@property (assign, nonatomic) NSInteger limitGroupId;

@property (assign, nonatomic) NSInteger newest_ep_id;

@property (assign, nonatomic) NSInteger newest_ep_index;

@property (assign, nonatomic) NSInteger play_count;

@property (strong, nonatomic) NSString *pub_time;

@property (strong, nonatomic) NSArray *related_seasons;

@property (assign, nonatomic) NSInteger season_id;

@property (assign, nonatomic) NSInteger season_status;

@property (strong, nonatomic) NSString *season_title;

@property (strong, nonatomic) NSArray *seasons;

@property (strong, nonatomic) NSString *share_url;

@property (strong, nonatomic) NSString *squareCover;

@property (strong, nonatomic) NSString *staff;

@property (strong, nonatomic) NSArray *tag2s;

@property (strong, nonatomic) NSArray *tags;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger total_count;

@property (strong, nonatomic) NSDictionary *user_season;

@property (strong, nonatomic) NSString *version;

@property (assign, nonatomic) NSInteger viewRank;

@property (assign, nonatomic) NSInteger vip_quality;

@property (assign, nonatomic) NSInteger watchingCount;

@property (assign, nonatomic) NSInteger weekday;



/**
 *  简介高度
 */
@property (assign, nonatomic) CGFloat evaluateHeight;

@end
