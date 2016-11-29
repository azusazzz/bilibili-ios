//
//  DownloadVideoInfoHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoInfoHeaderView.h"

@interface DownloadVideoInfoHeaderView ()



@end

@implementation DownloadVideoInfoHeaderView

+ (CGFloat)height {
    return 60.0;
}

- (void)handleTapGesture {
    !_handleTap ?: _handleTap();
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(14);
        [self addSubview:_titleLabel];
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_rightArrow"]];
        [self addSubview:rightImageView];
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = ColorWhite(200);
        [self addSubview:bottomLine];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.height.offset = 20;
            make.centerY.offset = 0;
            make.right.equalTo(rightImageView.mas_left).offset = -15;
        }];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 8;
            make.height.offset = 14;
            make.right.offset = -10;
            make.centerY.offset = 0;
        }];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.right.offset = 0;
            make.bottom.offset = 0;
            make.height.offset = 0.5;
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

@end
