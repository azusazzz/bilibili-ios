//
//  MediaPlayer.m
//  IJKMediaPlayer
//
//  Created by cezr on 16/7/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MediaPlayer.h"
//#import "IJKMediaPlayer.h"
#import <IJKMediaPlayer/IJKMediaPlayer.h>
#import "MediaPlayerControl.h"
#import "Masonry.h"

#import "DanmakuControl.h"

@interface MediaPlayer ()
<DanmakuControlDelegate>
{
    NSURL *_url;
    MediaPlayerControl *_mediaControl;
    
    NSString *_title;
}

@property (assign, nonatomic) NSInteger cid;

@property (strong, nonatomic) id<IJKMediaPlayback> player;

@property (strong, nonatomic) DanmakuControl *danmaku;

@end

@implementation MediaPlayer


+ (instancetype)playerWithURL:(NSURL *)url cid:(NSInteger)cid title:(NSString *)title inViewController:(UIViewController *)controller {
    MediaPlayer *player = [[MediaPlayer alloc] initWithURL:url title:title];
    player.cid = cid;
    [controller presentViewController:player animated:YES completion:NULL];
    return player;
}

+ (instancetype)livePlayerWithURL:(NSURL *)url title:(NSString *)title inViewController:(UIViewController *)controller {
    MediaPlayer *player = [[MediaPlayer alloc] initWithURL:url title:title];
    [controller presentViewController:player animated:YES completion:NULL];
    return player;
}

- (instancetype)initWithURL:(NSURL *)url title:(NSString *)title; {
    if (self = [super init]) {
        _url = [url copy];
        _title = title;
    }
    return self;
}

- (void)dealloc; {
    [_danmaku pause];
    NSLog(@"%s", __FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad; {
    [super viewDidLoad];
    
    NSParameterAssert(_url);
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [IJKFFMoviePlayerController setLogReport:YES];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_SILENT];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:_url withOptions:options];
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
    
    
    _danmaku = [[DanmakuControl alloc] initWithCid:_cid];
    _danmaku.delegate = self;
    [self.view addSubview:_danmaku];
    
    [_danmaku mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    _mediaControl = [[MediaPlayerControl alloc] initWithPlayer:self.player viewController:self];
    _mediaControl.title = _title;
    [self.view addSubview:_mediaControl];
    
    
    
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.bottom.offset = 0;
        make.left.offset = 0;
        make.right.offset = 0;
    }];
    
    [_mediaControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.player.view);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:NULL];
    
}

#pragma mark - Notification

- (void)moviePlayBackStateDidChange:(NSNotification*)notification; {
    if (self.player.playbackState == IJKMPMoviePlaybackStatePlaying) {
        [_danmaku start];
    }
    else if (self.player.playbackState == IJKMPMoviePlaybackStatePaused) {
        [_danmaku pause];
    }
    else if (self.player.playbackState == IJKMPMoviePlaybackStateStopped) {
        
    }
}

#pragma mark - DanmakuControlDelegate

- (NSTimeInterval)danmakuControlCurrentTime:(DanmakuControl *)danmakuControl {
    return self.player.currentPlaybackTime;
}


- (void)viewWillAppear:(BOOL)animated; {
    [super viewWillAppear:animated];
    [self.player prepareToPlay];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
}

- (void)viewWillLayoutSubviews; {
    [super viewWillLayoutSubviews];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation; {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
