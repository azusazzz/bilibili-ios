//
//  DanmakuEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DanmakuType) {
    DanmakuTypeTop,     // 顶部弹幕
    DanmakuTypeBottom,  // 底部弹幕
    DanmakuTypeNormal,  // 普通弹幕
};

@interface DanmakuEntity : NSObject

/**
 *  内容
 */
@property (strong, nonatomic) NSString *text;

/**
 *  时间-对应视频播放时间
 */
@property (assign, nonatomic) double time;

/**
 *  弹幕类型
 */
@property (assign, nonatomic) DanmakuType type;

/**
 *  弹幕颜色
 */
@property (strong, nonatomic) UIColor *color;

/**
 *  字体
 */
@property (strong, nonatomic) UIFont *font;

/**
 *  发送日期
 */
@property (assign, nonatomic) NSTimeInterval date;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
