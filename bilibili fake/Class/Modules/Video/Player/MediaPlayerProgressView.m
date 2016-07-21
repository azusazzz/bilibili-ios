//
//  MediaPlayerProgressView.m
//  IJKMediaPlayer
//
//  Created by cezr on 16/7/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MediaPlayerProgressView.h"
#import "Masonry.h"

@implementation MediaPlayerProgressView

- (instancetype)init; {
    if (self = [super init]) {
        
        CGFloat size = 10;
        
        UIGraphicsBeginImageContext(CGSizeMake(size, size));
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor whiteColor].CGColor);
        CGContextAddArc(UIGraphicsGetCurrentContext(), size/2, size/2, size/2, 0, 2*M_PI, 0);
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFill);
        UIImage *thumb = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
//        UIImage *image = [UIImage imageNamed:@"hd_icmpv_thumb_light"];
//        NSLog(@"%lf", image.scale);
//        
//        UIGraphicsBeginImageContext(CGSizeMake(10, 10));
//        [image drawInRect:CGRectMake(0, 0, 10, 10)];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        NSLog(@"%lf", image.scale);
        
        [self setThumbImage:thumb forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds; {
    return CGRectMake(0, (bounds.size.height-4)/2, bounds.size.width, 4);
}

@end



#define MediaChangeProgressViewTag 9958781

@interface MediaChangeProgressMessageView ()

@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation MediaChangeProgressMessageView

+ (MediaChangeProgressMessageView *)showChangeProgressViewWith:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration inView:(UIView *)view; {
    
    MediaChangeProgressMessageView *changeProgressView = [view viewWithTag:MediaChangeProgressViewTag];
    if (!changeProgressView) {
        changeProgressView = [[MediaChangeProgressMessageView alloc] init];
        changeProgressView.tag = MediaChangeProgressViewTag;
        [view addSubview:changeProgressView];
        [changeProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 100;
            make.height.offset = 50;
            make.center.equalTo(view);
        }];
    }
    changeProgressView.alpha = 1;
    
    changeProgressView.progressView.progress = currentTime / duration;
    changeProgressView.messageLabel.text = [NSString stringWithFormat:@"%02d:%02d / %02d:%02d", (int)currentTime / 60, (int)currentTime % 60, (int)duration / 60, (int)duration % 60];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:changeProgressView selector:@selector(hidden) object:NULL];
    [changeProgressView performSelector:@selector(hidden) withObject:NULL afterDelay:2];
    
    return changeProgressView;
}

- (instancetype)init; {
    if (self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]]) {
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)hidden; {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - get / set

- (UILabel *)messageLabel; {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.height.offset = 16;
            make.centerY.equalTo(self);
        }];
    }
    return _messageLabel;
}

- (UIProgressView *)progressView; {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [UIColor colorWithRed:219/255.0 green:92/255.0 blue:92/255.0 alpha:1];
        _progressView.trackTintColor = [UIColor colorWithWhite:86/255.0 alpha:1.0];
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.height.offset = 2;
            make.top.equalTo(self.messageLabel.mas_bottom).offset = 5;
        }];
    }
    return _progressView;
}

@end
