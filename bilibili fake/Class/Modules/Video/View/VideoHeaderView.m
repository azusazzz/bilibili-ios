//
//  VideoHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoHeaderView.h"
#import <UIImageView+WebCache.h>

@interface VideoHeaderView ()
{
    UIImageView *_backgroundView;
    UIButton *_playButton;
}
@end

@implementation VideoHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _backgroundView = [[UIImageView alloc] init];
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
    }
    return self;
}

- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo {
    [_backgroundView sd_setImageWithURL:[NSURL URLWithString:videoInfo.pic]];
}

@end
