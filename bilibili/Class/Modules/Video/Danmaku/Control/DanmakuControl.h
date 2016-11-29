//
//  DanmakuControl.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DanmakuControl;

@protocol DanmakuControlDelegate <NSObject>

- (NSTimeInterval)danmakuControlCurrentTime:(DanmakuControl *)danmakuControl;

@end

@interface DanmakuControl : UIView

@property (weak, nonatomic) id<DanmakuControlDelegate> delegate;

- (instancetype)initWithCid:(NSInteger)cid;

- (void)start;

- (void)resume;

- (void)pause;


@end
