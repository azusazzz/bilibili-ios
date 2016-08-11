//
//  DanmakuModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DanmakuEntity.h"

@interface DanmakuModel : NSObject

@property (strong, nonatomic, readonly) NSArray<DanmakuEntity *> *danmakuEntitys;

- (instancetype)initWithCid:(NSInteger)cid;

/**
 *  获取需要显示的弹幕数据
 *
 *  @param time <#time description#>
 */
- (NSArray<DanmakuEntity *> *)getDisplayDanmakuWithTime:(NSTimeInterval)time;

@end
