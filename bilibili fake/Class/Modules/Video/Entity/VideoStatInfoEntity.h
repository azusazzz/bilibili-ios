//
//  VideoStatInfoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

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
