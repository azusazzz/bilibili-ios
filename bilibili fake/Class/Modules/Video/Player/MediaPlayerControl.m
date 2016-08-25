//
//  MediaPlayerControl.m
//  IJKMediaPlayer
//
//  Created by cezr on 16/7/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MediaPlayerControl.h"
#import "MediaPlayerProgressView.h"
//#import "IJKMediaPlayback.h"
#import <IJKMediaPlayer/IJKMediaPlayer.h>
#import <MediaPlayer/MediaPlayer.h> // 修改音量

#import "Masonry.h"

/**
 *  手势处理方式
 */
typedef NS_ENUM(NSInteger, PanGestureHandleMode) {
    PanGestureHandleModeNone,
    /**
     *  音量
     */
    PanGestureHandleModeVolume,
    /**
     *  亮度
     */
    PanGestureHandleModeBrightness,
    /**
     *  播放进度
     */
    PanGestureHandleModePlayProgress
};


@interface MediaPlayerControl ()
{
    PanGestureHandleMode _panGestureHandleMode;
    
    __weak UIViewController *_viewController;
    
    
    UIVisualEffectView *_topView;
    UIButton *_backButton;
    UILabel *_titleLabel;
    
    
    UIVisualEffectView *_bottomView;
    MediaPlayerProgressView *_progressView;
    UILabel *_currentTimeLabel;
    UILabel *_durationLabel;
    
    UIButton *_playButton;
    
    NSTimeInterval _tempTime;
}

@property(weak, nonatomic) id<IJKMediaPlayback> delegatePlayer;

@property (strong, nonatomic) NSNumber *hiddenControlView;

@end

@implementation MediaPlayerControl

- (instancetype)initWithPlayer:(__weak id<IJKMediaPlayback>)player viewController:(UIViewController *__weak)viewController; {
    if (self = [super init]) {
        self.delegatePlayer = player;
        _viewController = viewController;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initSubviews];
        
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:panGesture];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        
        [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_delegatePlayer];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshMediaControl; {
    CGFloat currentTime = self.delegatePlayer.currentPlaybackTime;
    CGFloat duration = self.delegatePlayer.duration;
    
    _progressView.value = currentTime;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)currentTime / 60, (int)currentTime % 60];
    
    _durationLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)duration / 60, (int)duration % 60];
    _progressView.maximumValue = self.delegatePlayer.duration;
    
    if (!_bottomView.hidden) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshMediaControl) object:NULL];
        [self performSelector:@selector(refreshMediaControl) withObject:NULL afterDelay:0.5];
    }
}


#pragma mark - Event

- (void)onClickPlay; {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setHiddenControlView:) object:@(YES)];
    [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    if (self.delegatePlayer.isPlaying) {
        [self.delegatePlayer pause];
    }
    else if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePaused) {
        [self.delegatePlayer play];
    }
    else if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStateStopped) {
        self.delegatePlayer.currentPlaybackTime = 0;
        [self.delegatePlayer play];
    }
}

- (void)onClickBack; {
    [_viewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didSliderTouchDown; {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setHiddenControlView:) object:@(YES)];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshMediaControl) object:NULL];
}
- (void)didSliderTouchCancel; {
    [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    [self refreshMediaControl];
}
- (void)didSliderTouchUpOutside; {
    [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    [self refreshMediaControl];
}
- (void)didSliderTouchUpInside; {
    self.delegatePlayer.currentPlaybackTime = (int)_progressView.value;
    if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePaused ||
        self.delegatePlayer.playbackState == IJKMPMoviePlaybackStateStopped) {
        [self.delegatePlayer play];
    }
    [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    [self refreshMediaControl];
}
- (void)didSliderValueChanged; {
    [MediaChangeProgressMessageView showChangeProgressViewWith:_progressView.value duration:self.delegatePlayer.duration inView:self];
}


#pragma mark - 手势

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture; {
    self.hiddenControlView = @(![_hiddenControlView boolValue]);
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture; {
    CGPoint translation = [panGesture translationInView:self];
    CGPoint location = [panGesture locationInView:self];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            /**
             *  判断手势处理方式
             */
            CGFloat absTranslationX = translation.x > 0 ? translation.x : -translation.x;
            CGFloat absTranslationY = translation.y > 0 ? translation.y : -translation.y;
            
            if (absTranslationX > absTranslationY || (location.x > 150 && location.x < self.bounds.size.width-150)) {
                _panGestureHandleMode = PanGestureHandleModePlayProgress;
                _tempTime = self.delegatePlayer.currentPlaybackTime;
            }
            else {
                if (location.x > self.bounds.size.width / 2) {
                    _panGestureHandleMode = PanGestureHandleModeVolume;
                }
                else {
                    _panGestureHandleMode = PanGestureHandleModeBrightness;
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
            if (_panGestureHandleMode != PanGestureHandleModePlayProgress) {
                CGFloat offset = -translation.y / self.bounds.size.height;
                if (_panGestureHandleMode == PanGestureHandleModeVolume) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
                    musicPlayer.volume += offset;
#pragma clang diagnostic pop
                }
                else if (_panGestureHandleMode == PanGestureHandleModeBrightness) {
                    [UIScreen mainScreen].brightness += offset;
                }
                [panGesture setTranslation:CGPointZero inView:self];
            }
            else {
                CGFloat offset = translation.x / self.bounds.size.width;
                CGFloat newTime = _tempTime + offset * self.delegatePlayer.duration;
                newTime = newTime < 0 ? 0 : newTime > self.delegatePlayer.duration ? self.delegatePlayer.duration : newTime;
                [MediaChangeProgressMessageView showChangeProgressViewWith:newTime duration:self.delegatePlayer.duration inView:self];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (_panGestureHandleMode == PanGestureHandleModePlayProgress) {
                CGFloat offset = translation.x / self.bounds.size.width;
                CGFloat newTime = _tempTime + offset * self.delegatePlayer.duration;
                newTime = newTime < 0 ? 0 : newTime > self.delegatePlayer.duration ? self.delegatePlayer.duration : newTime;
                
                [MediaChangeProgressMessageView showChangeProgressViewWith:newTime duration:self.delegatePlayer.duration inView:self];
                
                self.delegatePlayer.currentPlaybackTime = (int)newTime;
                
                if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePaused ||
                    self.delegatePlayer.playbackState == IJKMPMoviePlaybackStateStopped) {
                    [self.delegatePlayer play];
                }
            }
            
            _panGestureHandleMode = PanGestureHandleModeNone;
            break;
        default:
            break;
    }
}


#pragma mark - Notification

- (void)moviePlayBackStateDidChange:(NSNotification*)notification; {
    if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePlaying) {
        [self refreshMediaControl];
        [_playButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    }
    else if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStatePaused) {
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }
    else if (self.delegatePlayer.playbackState == IJKMPMoviePlaybackStateStopped) {
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }
}


#pragma mark - Subviews

- (void)initSubviews; {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    _topView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self addSubview:_topView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"videoinfo_back"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_backButton];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [_topView addSubview:_titleLabel];
    
    
    
    
    _bottomView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self addSubview:_bottomView];
    
    _progressView = [[MediaPlayerProgressView alloc] init];
    _progressView.minimumTrackTintColor = [UIColor colorWithRed:219/255.0 green:92/255.0 blue:92/255.0 alpha:1];
    _progressView.maximumTrackTintColor = [UIColor colorWithWhite:86/255.0 alpha:1.0];
    _progressView.minimumValue = 0;
    _progressView.maximumValue = 1;
    _progressView.value = 0;
    [_progressView addTarget:self action:@selector(didSliderTouchDown) forControlEvents:UIControlEventTouchDown];
    [_progressView addTarget:self action:@selector(didSliderTouchCancel) forControlEvents:UIControlEventTouchCancel];
    [_progressView addTarget:self action:@selector(didSliderTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [_progressView addTarget:self action:@selector(didSliderTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_progressView addTarget:self action:@selector(didSliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [_bottomView addSubview:_progressView];
    
    _currentTimeLabel = [[UILabel alloc] init];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font = [UIFont systemFontOfSize:12];
    _currentTimeLabel.text = @"00:00";
    _currentTimeLabel.textAlignment = NSTextAlignmentRight;
    [_bottomView addSubview:_currentTimeLabel];
    
    _durationLabel = [[UILabel alloc] init];
    _durationLabel.textColor = [UIColor whiteColor];
    _durationLabel.font = [UIFont systemFontOfSize:12];
    _durationLabel.text = @"00:00";
    _durationLabel.textAlignment = NSTextAlignmentLeft;
    [_bottomView addSubview:_durationLabel];
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton addTarget:self action:@selector(onClickPlay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playButton];
    
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 0;
        make.height.offset = 44;
    }];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 5;
        make.width.equalTo(_topView.mas_height);
        make.height.equalTo(_topView);
        make.centerY.equalTo(_topView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backButton.mas_right).offset = 15;
        make.right.offset = -15;
        make.height.offset = 16;
        make.centerY.equalTo(_topView);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.height.offset = 44;
    }];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.width.offset = 55;
        make.height.offset = 14;
        make.centerY.equalTo(_bottomView);
    }];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_currentTimeLabel.mas_right).offset = 15;
        make.right.equalTo(_durationLabel.mas_left).offset = -15;
        make.height.offset = 6;
        make.centerY.equalTo(_bottomView);
    }];
    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.centerY.equalTo(_bottomView);
        make.height.offset = 14;
        make.width.offset = 55;
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.bottom.equalTo(_bottomView.mas_top);
        make.width.offset = 55;
        make.height.offset = 50;
    }];
}


#pragma mark - get / set 

- (void)setHiddenControlView:(NSNumber *)hiddenControlView; {
    _hiddenControlView = hiddenControlView;
    _topView.hidden = [hiddenControlView boolValue];
    _bottomView.hidden = [hiddenControlView boolValue];
    _playButton.hidden = [hiddenControlView boolValue];
    if (![hiddenControlView boolValue]) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setHiddenControlView:) object:@(YES)];
        [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
        [self refreshMediaControl];
    }
}

- (NSString *)title; {
    return _titleLabel.text;
}

- (void)setTitle:(NSString *)title; {
    _titleLabel.text = title;
}


@end
