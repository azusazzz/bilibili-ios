//
//  HomeAnimationCategoryEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeAnimationCategoryItemEntity;
@class HomeAnimationCategoryItemNewEpEntity;


/**
 *  番剧 - 分类
 */
@interface HomeAnimationCategoryEntity : NSObject

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) NSInteger orderType;

@property (assign, nonatomic) NSInteger tag_id;

@property (strong, nonatomic) NSString *tag_name;

@property (assign, nonatomic) NSInteger type;

@property (assign, nonatomic) NSInteger count;

@property (strong, nonatomic) NSArray<HomeAnimationCategoryItemEntity *> *list;

@end



@interface HomeAnimationCategoryItemEntity : NSObject

@property (assign, nonatomic) NSInteger bangumi_id;

@property (strong, nonatomic) NSString *bangumi_title;

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) BOOL is_finish;

@property (strong, nonatomic) HomeAnimationCategoryItemNewEpEntity *pNew_ep;

@property (assign, nonatomic) NSInteger newest_ep_index;

@property (assign, nonatomic) NSInteger season_id;

@property (strong, nonatomic) NSString *season_title;

@property (assign, nonatomic) NSInteger spid;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger total_count;

@end


@interface HomeAnimationCategoryItemNewEpEntity : NSObject

@property (assign, nonatomic) NSInteger av_id;

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) NSInteger danmaku;

@property (assign, nonatomic) NSInteger episode_id;

@property (assign, nonatomic) NSInteger index;

@property (assign, nonatomic) NSInteger index_title;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSArray *up;

@property (strong, nonatomic) NSString *update_time;

@end
