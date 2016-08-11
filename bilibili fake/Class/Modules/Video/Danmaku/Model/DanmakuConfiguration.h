//
//  DanmakuConfiguration.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DanmakuLineHeight   DanmakuConfiguration.sharedConfiguration.lineHeight

#define DanmakuDisplayDuration  DanmakuConfiguration.sharedConfiguration.displayDuration

@interface DanmakuConfiguration : NSObject

/**
 *  最大显示数量
 */
@property (assign, nonatomic) NSInteger maxDisplayNumber;

/**
 *  显示时间
 */
@property (assign, nonatomic) NSTimeInterval displayDuration;

/**
 *  弹幕标签透明度
 */
@property (assign, nonatomic) CGFloat danmakuLabelAlpha;

@property (assign, nonatomic) CGFloat lineHeight;


+ (DanmakuConfiguration *)sharedConfiguration;

@end
