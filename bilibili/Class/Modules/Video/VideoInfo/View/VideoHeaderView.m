//
//  VideoHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoHeaderView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SABlurImageView/SABlurImageView-umbrella.h>

@interface VideoHeaderView ()
{
    
    UIButton *_playButton;
}



@end

@implementation VideoHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -10;
            make.bottom.offset = -5;
            make.width.offset = 55;
            make.height.offset = 50;
        }];
        
    }
    return self;
}

- (void)dealloc {
    
}


- (void)playWithURL:(NSURL *)url {
    
//    [_player playWithURL:url];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _onClickPlay ? _onClickPlay() : NULL;
}

- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo {
    
    [_backgroundView removeFromSuperview];
    
    _backgroundView = [[SABlurImageView alloc] init];
    _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self insertSubview:_backgroundView belowSubview:_playButton];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    __weak typeof(self) weakself = self;
    [_backgroundView sd_setImageWithURL:[NSURL URLWithString:videoInfo.pic] placeholderImage:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakself.backgroundView configrationForBlurAnimation:100];
    }];
}

@end
