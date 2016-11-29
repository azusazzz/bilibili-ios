//
//  DanmakuLabel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DanmakuEntity.h"
#import "DanmakuConfiguration.h"

typedef NS_ENUM(NSInteger, DanmakuLabelStatus) {
    DanmakuLabelStatusEnded,
    DanmakuLabelStatusRuning,
    DanmakuLabelStatusPaused,
};

@class DanmakuLabel;

@protocol DanmakuLabelDelegate <NSObject>

- (void)labelAnimateCompletion:(DanmakuLabel *)label;

@end


@interface DanmakuLabel : UILabel

@property (assign, nonatomic, readonly) NSTimeInterval animateDuration;

@property (weak, nonatomic) id<DanmakuLabelDelegate> delegate;

@property (assign, nonatomic) DanmakuLabelStatus status;

- (void)startWithDanmaku:(DanmakuEntity *)danmaku pointY:(CGFloat)pointY;

- (void)pause;

- (void)resume;

@end
