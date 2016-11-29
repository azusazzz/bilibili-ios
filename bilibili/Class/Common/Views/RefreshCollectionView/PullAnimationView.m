//
//  PullAnimationView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "PullAnimationView.h"

static inline double radians (double degrees) {
    return degrees * M_PI/180;
}

@interface PullAnimationView ()
{
    UIView *leftView;
    UIView *rightView;
    
    CADisplayLink *displayLink;
    CGFloat offset;
    NSInteger number;
}

@property (assign, nonatomic) CGFloat progress;

@end

@implementation PullAnimationView

- (instancetype)init {
    if (self = [super init]) {
        self.clipsToBounds = YES;
        
        leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor whiteColor];
        leftView.layer.cornerRadius = 3;
        [self addSubview:leftView];
        
        rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor whiteColor];
        rightView.layer.cornerRadius = 3;
        [self addSubview:rightView];
        
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 50;
            make.height.offset = 6;
            make.top.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX).offset = -12;
        }];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 50;
            make.height.offset = 6;
            make.top.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX).offset = 12;
        }];
        
    }
    return self;
}

- (void)setPullProgress:(CGFloat)pullProgress {
    _pullProgress = pullProgress;
    if (pullProgress >= 0.5) {
        [self start];
    }
    else {
        [self stop];
        self.progress = pullProgress;
    }
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        progress = 0;
    }
    else if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    
    leftView.transform = CGAffineTransformMakeRotation(radians(90 * progress));
    rightView.transform = CGAffineTransformMakeRotation(radians(-90 * progress));
}


- (void)start {
    if (displayLink == nil) {
        _progress = 0.5;
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        displayLink.frameInterval = 1;
    }
}

- (void)stop {
    if (displayLink) {
        [displayLink invalidate];
        displayLink = NULL;
        [UIView animateWithDuration:3 animations:^{
            self.progress = 0.5;
        }];
    }
}

- (void)handleDisplayLink {
    if (_progress <= 0.5) {
        offset = 0.03;
        
        UIView *view = [[UIView alloc] init/*WithFrame:CGRectMake((self.frame.size.width-36)/2, 120-3-40, 36, 20)*/];
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        view.layer.borderWidth = 1;
        view.layer.cornerRadius = 8;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 30;
            make.height.offset = 16;
            make.centerX.offset = 0;
            make.bottom.offset = -15;
        }];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            view.alpha = 0;
            view.transform = CGAffineTransformMakeScale(3, 3);
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
    else if (_progress >= 1) {
        offset = -0.03;
        ++number;
        if (number == 2) {
            displayLink.paused = YES;
            number = 0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                displayLink.paused = NO;
            });
        }
        
        
        
    }
    self.progress += offset;
}


@end
