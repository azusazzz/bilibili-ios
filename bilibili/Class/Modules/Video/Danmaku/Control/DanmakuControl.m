//
//  DanmakuControl.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuControl.h"
#import "DanmakuLabel.h"
#import "DanmakuModel.h"

@interface DanmakuControl ()
<DanmakuLabelDelegate>
{
    NSMutableArray *_danmakuLabels;
    
    NSMutableArray *_normalDanmakuLabels;
    NSMutableArray *_topAndBottomDanmakuLabels;
    
    NSTimer *_timer;
    
    DanmakuModel *_model;
    
    NSTimeInterval _currentTime;
}
@end

@implementation DanmakuControl

- (instancetype)initWithCid:(NSInteger)cid {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    
    _model = [[DanmakuModel alloc] initWithCid:cid];
    
    
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)start {
    if (_timer) {
        return;
    }
    if (!_danmakuLabels) {
        [self layoutIfNeeded];
        NSInteger count = self.frame.size.height / DanmakuLineHeight;
        _normalDanmakuLabels =[NSMutableArray arrayWithCapacity:count];
        _topAndBottomDanmakuLabels = [NSMutableArray arrayWithCapacity:count];
        _danmakuLabels = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger i=0; i<count; i++) {
            [_normalDanmakuLabels addObject:[NSNull null]];
            [_topAndBottomDanmakuLabels addObject:[NSNull null]];
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleTimeInterval) userInfo:NULL repeats:YES];
    }
    else {
        [self resume];
    }
    
    
    
}

- (void)resume {
    if (_timer) {
        return;
    }
    NSLog(@"resume");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimeInterval) userInfo:NULL repeats:YES];
    [_danmakuLabels makeObjectsPerformSelector:@selector(resume)];
}

- (void)pause {
    
    if (!_timer) {
        return;
    }
    NSLog(@"pause");
    [_timer invalidate];
    _timer = NULL;
    [_danmakuLabels makeObjectsPerformSelector:@selector(pause)];
}

- (void)handleTimeInterval {
    _currentTime += 0.5;
    
    NSTimeInterval time = [self.delegate danmakuControlCurrentTime:self];
    
    NSArray *danmakus = [_model getDisplayDanmakuWithTime:time];
    
    NSInteger index = 0;
    if ([danmakus count] + _danmakuLabels.count > DanmakuConfiguration.sharedConfiguration.maxDisplayNumber) {
        index = [danmakus count] - (DanmakuConfiguration.sharedConfiguration.maxDisplayNumber - _danmakuLabels.count);
    }
    
    for (NSInteger i=index; i<danmakus.count; i++) {
        [self displayDanmaku:danmakus[i]];
    }
    
}

- (void)displayDanmaku:(DanmakuEntity *)danmaku {
    DanmakuLabel *label = [[DanmakuLabel alloc] init];
    label.delegate = self;
    [self addSubview:label];
    [_danmakuLabels addObject:label];
    
    NSInteger index;
    if (danmaku.type == DanmakuTypeNormal) {
        index = [self getNormalDanmakuDisplayIndex];
        [_normalDanmakuLabels replaceObjectAtIndex:index withObject:label];
    }
    else if (danmaku.type == DanmakuTypeTop) {
        index = [self getTopDanmakuDisplayIndex];
        [_topAndBottomDanmakuLabels replaceObjectAtIndex:index withObject:label];
    }
    else if (danmaku.type == DanmakuTypeBottom) {
        index = [self getBottomDanmakuDisplayIndex];
        [_topAndBottomDanmakuLabels replaceObjectAtIndex:index withObject:label];
    }
    
    [label startWithDanmaku:danmaku pointY:index * DanmakuLineHeight];
}

#pragma mark - DanmakuLabelDelegate

- (void)labelAnimateCompletion:(DanmakuLabel *)label {
    [label removeFromSuperview];
    [_danmakuLabels removeObject:label];
}


#pragma mark - 获取弹幕显示位置

- (NSInteger)getNormalDanmakuDisplayIndex {
    for (NSInteger i=0; i<_normalDanmakuLabels.count; i++) {
        NSObject *value = _normalDanmakuLabels[i];
        if ([value isKindOfClass:[DanmakuLabel class]]) {
            if ([self isDisplayIndexValidForLabel:(DanmakuLabel *)value]) {
                return i;
            }
            else {
                continue;
            }
        }
        else if ([value isKindOfClass:[NSNull class]]) {
            return i;
        }
    }
    
    NSInteger index = 0;
    NSTimeInterval minTime = ((DanmakuLabel *)_normalDanmakuLabels[0]).animateDuration;
    for (NSInteger idx=1; idx<_normalDanmakuLabels.count; idx++) {
        NSTimeInterval animateDuration = ((DanmakuLabel *)_normalDanmakuLabels[0]).animateDuration;
        if (animateDuration < minTime) {
            index = idx;
            minTime = animateDuration;
        }
    }
    return index;
}

- (NSInteger)getTopDanmakuDisplayIndex {
    
    for (NSInteger i=0; i<_topAndBottomDanmakuLabels.count; i++) {
        NSObject *value = _topAndBottomDanmakuLabels[i];
        if ([value isKindOfClass:[DanmakuLabel class]]) {
            if (((DanmakuLabel *)value).status == DanmakuLabelStatusEnded) {
                return i;
            }
            else {
                continue;
            }
        }
        else if ([value isKindOfClass:[NSNull class]]) {
            return i;
        }
    }
    
    NSInteger index = 0;
    NSTimeInterval minTime = ((DanmakuLabel *)_topAndBottomDanmakuLabels[0]).animateDuration;
    for (NSInteger idx=1; idx<_topAndBottomDanmakuLabels.count; idx++) {
        NSTimeInterval animateDuration = ((DanmakuLabel *)_topAndBottomDanmakuLabels[0]).animateDuration;
        if (animateDuration < minTime) {
            index = idx;
            minTime = animateDuration;
        }
    }
    return index;
}

- (NSInteger)getBottomDanmakuDisplayIndex {
    for (NSInteger i=_topAndBottomDanmakuLabels.count-1; i>=0; i--) {
        NSObject *value = _topAndBottomDanmakuLabels[i];
        if ([value isKindOfClass:[DanmakuLabel class]]) {
            if (((DanmakuLabel *)value).status == DanmakuLabelStatusEnded) {
                return i;
            }
            else {
                continue;
            }
        }
        else if ([value isKindOfClass:[NSNull class]]) {
            return i;
        }
    }
    
    NSInteger index = 0;
    NSTimeInterval minTime = ((DanmakuLabel *)_topAndBottomDanmakuLabels[0]).animateDuration;
    for (NSInteger idx=1; idx<_topAndBottomDanmakuLabels.count; idx++) {
        NSTimeInterval animateDuration = ((DanmakuLabel *)_topAndBottomDanmakuLabels[0]).animateDuration;
        if (animateDuration < minTime) {
            index = idx;
            minTime = animateDuration;
        }
    }
    return index;
}



- (BOOL)isDisplayIndexValidForLabel:(DanmakuLabel *)label {
    if (label.status == DanmakuLabelStatusEnded) {
        return YES;
    }
//    if (label.animateDuration < DanmakuDisplayDuration * 0.7) {
//        
//    }
    CALayer * layer = label.layer.presentationLayer;
    if (layer) {
        if (label.status == DanmakuLabelStatusRuning && layer.frame.origin.x == -layer.frame.size.width) {
            return NO;
        }
        else if (layer.frame.origin.x + layer.frame.size.width < self.bounds.size.width - 200) {
            return YES;
        }
    }
    return NO;
}





@end
