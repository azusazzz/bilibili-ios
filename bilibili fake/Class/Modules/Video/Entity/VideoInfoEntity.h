//
//  VideoInfoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoOwnerInfoEntity.h"
#import "VideoStatInfoEntity.h"
#import "VideoPageInfoEntity.h"


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
@property (strong, nonatomic) NSArray<VideoInfoEntity *> *relates;

@end



