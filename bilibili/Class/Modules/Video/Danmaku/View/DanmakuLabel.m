//
//  DanmakuLabel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuLabel.h"

@interface DanmakuLabel ()
{
    NSTimeInterval _startTime;
    
    DanmakuEntity *_danmaku;
    
    NSTimeInterval _animateDuration;
    
}
@end


@implementation DanmakuLabel

@dynamic animateDuration;

- (NSTimeInterval)animateDuration {
    return _animateDuration - (CACurrentMediaTime() - _startTime);;
}


- (void)startWithDanmaku:(DanmakuEntity *)danmaku pointY:(CGFloat)pointY {
    _danmaku = danmaku;
    self.font = _danmaku.font;
    self.text = _danmaku.text;
    self.textColor = _danmaku.color;
    self.alpha = DanmakuConfiguration.sharedConfiguration.danmakuLabelAlpha;
    _animateDuration = DanmakuConfiguration.sharedConfiguration.displayDuration;
    _startTime = CACurrentMediaTime();
    _status = DanmakuLabelStatusRuning;
    
    CGFloat width = [self textRectForBounds:CGRectMake(0, 0, 1000, DanmakuLineHeight) limitedToNumberOfLines:1].size.width;
    if (danmaku.type == DanmakuTypeNormal) {
        
        self.frame = CGRectMake(self.superview.bounds.size.width, pointY, width, DanmakuLineHeight);
        
        [UIView animateWithDuration:_animateDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = CGRectMake(-self.bounds.size.width, self.frame.origin.y, width, self.bounds.size.height);
        } completion:^(BOOL finished) {
            [self animateCompletionHandleWithFinished:finished];
        }];
    }
    else if (danmaku.type == DanmakuTypeTop || danmaku.type == DanmakuTypeBottom) {
        self.frame = CGRectMake((self.superview.bounds.size.width - width) / 2, pointY, width, DanmakuLineHeight);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_animateDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_status == DanmakuLabelStatusRuning) {
                [self animateCompletionHandleWithFinished:YES];
            }
        });
        
    }
    
    
}

- (void)pause {
    if (_status != DanmakuLabelStatusRuning) {
        return;
    }
    _animateDuration -= CACurrentMediaTime() - _startTime;
    _status = DanmakuLabelStatusPaused;
    
//    NSLog(@"%@: %lf", self.text, _animateDuration);
    
    CALayer *layer = self.layer;
    CGRect rect = self.frame;
    if (layer.presentationLayer) {
        rect = ((CALayer *)layer.presentationLayer).frame;
        rect.origin.x-=1;
    }
    self.frame = rect;
    [self.layer removeAllAnimations];
    
    
}

- (void)resume {
    if (_status != DanmakuLabelStatusPaused) {
        return;
    }
    _status = DanmakuLabelStatusRuning;
    _startTime = CACurrentMediaTime();
    
    if (_danmaku.type == DanmakuTypeNormal) {
        [UIView animateWithDuration:_animateDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = CGRectMake(-self.bounds.size.width, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
        } completion:^(BOOL finished) {
            [self animateCompletionHandleWithFinished:finished];
        }];
    }
    else if (_danmaku.type == DanmakuTypeTop || _danmaku.type == DanmakuTypeBottom) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_animateDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_status == DanmakuLabelStatusRuning) {
                [self animateCompletionHandleWithFinished:YES];
            }
        });
    }
}


- (void)animateCompletionHandleWithFinished:(BOOL)finished {
    if (_status == DanmakuLabelStatusPaused && finished) {
        return;
    }
    
    if (finished) {
        self.status = DanmakuLabelStatusEnded;
        [self.delegate labelAnimateCompletion:self];
    }
}



@end
