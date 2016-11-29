//
//  HistoryEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoInfoEntity.h"

@interface HistoryEntity : NSObject

/**
 *  标题
 */
@property (strong, nonatomic) NSString *title;

/**
 *  AV号
 */
@property (assign, nonatomic) NSInteger aid;

/**
 *  封面
 */
@property (strong, nonatomic) NSString *pic;

/**
 *  UP主
 */
@property (strong, nonatomic) NSString *ownerName;

/**
 *  播放数量
 */
@property (assign, nonatomic) NSInteger viewCount;

/**
 *  弹幕数量
 */
@property (assign, nonatomic) NSInteger danmakuCount;


- (instancetype)initWithVideoInfo:(VideoInfoEntity *)videoInfo;

@end
