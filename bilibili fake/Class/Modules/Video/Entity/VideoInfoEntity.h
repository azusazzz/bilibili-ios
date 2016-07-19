//
//  VideoInfoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoOwnerInfoEntity;
@class VideoStatInfoEntity;
@class VideoPageInfoEntity;

/**
 *  视频信息
 */
@interface VideoInfoEntity : NSObject

@property (assign, nonatomic) NSInteger aid;

@property (assign, nonatomic) NSInteger tid;

@property (strong, nonatomic) NSString *tname;

@property (strong, nonatomic) NSString *pic;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger pubdate;

@property (strong, nonatomic) NSString *desc;

/**
 *  Up主信息
 */
@property (strong, nonatomic) VideoOwnerInfoEntity *owner;

/**
 *  统计信息
 */
@property (strong, nonatomic) VideoStatInfoEntity *stat;


@property (strong, nonatomic) NSArray<NSString *> *tags;

/**
 *  分集
 */
@property (strong, nonatomic) NSArray<VideoPageInfoEntity *> *pages;

/**
 *  视频相关
 */
@property (strong, nonatomic) NSArray *relates;

@end

/**
 *  Up主信息
 */
@interface VideoOwnerInfoEntity : NSObject

@property (assign, nonatomic) NSInteger mid;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *face;

@end


/**
 *  视频统计信息
 */
@interface VideoStatInfoEntity : NSObject

/**
 *  播放
 */
@property (assign, nonatomic) NSInteger view;

/**
 *  弹幕
 */
@property (assign, nonatomic) NSInteger danmaku;

/**
 *  评论
 */
@property (assign, nonatomic) NSInteger reply;

/**
 *  喜欢
 */
@property (assign, nonatomic) NSInteger favorite;

/**
 *  硬币
 */
@property (assign, nonatomic) NSInteger coin;

/**
 *  分享
 */
@property (assign, nonatomic) NSInteger share;

@end


/**
 *  视频分集信息
 */
@interface VideoPageInfoEntity : NSObject

@property (assign, nonatomic) NSInteger cid;

@property (assign, nonatomic) NSInteger page;



@end

