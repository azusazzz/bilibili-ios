//
//  LivePlayer.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LivePlayer.h"
#import <IJKMediaPlayer/IJKMediaPlayer.h>

@interface LivePlayer ()
{
    NSURL *_url;
    NSString *_title;
    
    UIVisualEffectView *_topView;
//    UIButton *_backButton;
//    UILabel *_titleLabel;
    
    UIVisualEffectView *_bottomView;
    UIButton *_playButton;
}

@property (strong, nonatomic) NSNumber *hiddenControlView;

@property (strong, nonatomic) id<IJKMediaPlayback> player;

@end

@implementation LivePlayer

+ (instancetype)playLiveWithURL:(NSURL *)url title:(NSString *)title inController:(UIViewController *)controller {
    LivePlayer *player = [[LivePlayer alloc] initWithLiveURL:url title:title];
    [controller presentViewController:player animated:YES completion:NULL];
    return player;
}

- (instancetype)initWithLiveURL:(NSURL *)url title:(NSString *)title {
    if (self = [super init]) {
        _url = url;
        _title = title;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    if (!_url) {
        HUDFailureInView(@"参数异常", self.view);
        return;
    }
    
    [IJKFFMoviePlayerController setLogReport:YES];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_SILENT];
    
    [self initViews];
    
    [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player prepareToPlay];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation; {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - Event

- (void)onClickPlay; {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setHiddenControlView:) object:@(YES)];
    [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    if (self.player.isPlaying) {
        [self.player pause];
    }
    else if (self.player.playbackState == IJKMPMoviePlaybackStatePaused) {
        [self.player play];
    }
    else if (self.player.playbackState == IJKMPMoviePlaybackStateStopped) {
        self.player.currentPlaybackTime = 0;
        [self.player play];
    }
}

- (void)onClickBack {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setHiddenControlView:(NSNumber *)hiddenControlView; {
    _hiddenControlView = hiddenControlView;
    _topView.hidden = [hiddenControlView boolValue];
    _bottomView.hidden = [hiddenControlView boolValue];
    _playButton.hidden = [hiddenControlView boolValue];
    if (![hiddenControlView boolValue]) {
        [self performSelector:@selector(setHiddenControlView:) withObject:@(YES) afterDelay:5];
    }
}

- (void)tapPlayerView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setHiddenControlView:) object:@(YES)];
    self.hiddenControlView = @(![self.hiddenControlView boolValue]);
}

#pragma mark - Notification

- (void)moviePlayBackStateDidChange:(NSNotification*)notification; {
    if (self.player.playbackState == IJKMPMoviePlaybackStatePlaying) {
        [_playButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    }
    else if (self.player.playbackState == IJKMPMoviePlaybackStatePaused) {
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }
    else if (self.player.playbackState == IJKMPMoviePlaybackStateStopped) {
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }
}



- (void)initViews {
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:_url withOptions:options];
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
    
    UITapGestureRecognizer *tapPlayerView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayerView)];
    [self.player.view addGestureRecognizer:tapPlayerView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _topView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.view addSubview:_topView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"videoinfo_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:backButton];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = _title;
    [_topView addSubview:titleLabel];
    
    
    _bottomView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.view addSubview:_bottomView];
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton addTarget:self action:@selector(onClickPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
    
#pragma mark Layout
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.bottom.offset = 0;
        make.left.offset = 0;
        make.right.offset = 0;
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 0;
        make.height.offset = 44;
    }];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 5;
        make.width.equalTo(_topView.mas_height);
        make.height.equalTo(_topView);
        make.centerY.equalTo(_topView);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.mas_right).offset = 15;
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
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.bottom.equalTo(_bottomView.mas_top);
        make.width.offset = 55;
        make.height.offset = 50;
    }];
}




@end
