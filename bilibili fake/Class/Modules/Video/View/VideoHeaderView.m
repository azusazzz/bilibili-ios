//
//  VideoHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoHeaderView.h"
#import <UIImageView+WebCache.h>

#import <ReactiveCocoa.h>

@interface VideoHeaderView ()
{
    
    UIButton *_playButton;
//    FXBlurView *_blurView;
}



@end

@implementation VideoHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _backgroundView = [[SABlurImageView alloc] init];
        _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -10;
            make.bottom.offset = -5;
            make.width.offset = 55;
            make.height.offset = 50;
        }];
        
//        __weak typeof(self) weakself = self;
//        [RACObserve(self, transform) subscribeNext:^(id x) {
////            CGFloat targetX = weakself.width / 2 - 55;
////            CGFloat targetOffsetX = targetX - _playButton.x;
//            
////            _playButton.transform = CGAffineTransformMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>)
//        }];
        
    }
    return self;
}

- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo {
//    [_backgroundView sd_setImageWithURL:[NSURL URLWithString:videoInfo.pic]];
    
    __weak typeof(self) weakself = self;
    [_backgroundView sd_setImageWithURL:[NSURL URLWithString:videoInfo.pic] placeholderImage:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakself.backgroundView configrationForBlurAnimation:100];
        [weakself.backgroundView blur:0.6];
    }];
}

@end
