//
//  VideoIntroRelateCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroRelateCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface VideoIntroRelateCollectionViewCell ()
{
    UIImageView *_picImageView;
    UILabel *_titleLabel;
    UILabel *_ownerLabel;
    UILabel *_viewCountLabel;
    UILabel *_danmakuCountLabel;
}
@end

@implementation VideoIntroRelateCollectionViewCell

- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo {
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:videoInfo.pic]];
    _titleLabel.text = videoInfo.title;
    _ownerLabel.text = [NSString stringWithFormat:@"UP主: %@", videoInfo.owner.name];
    _viewCountLabel.text = [NSString stringWithFormat:@"播放 :%@", IntegerToTenThousand(videoInfo.stat.view)];
    _danmakuCountLabel.text = [NSString stringWithFormat:@"弹幕 :%@", IntegerToTenThousand(videoInfo.stat.danmaku)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(_titleLabel.frame, CGRectZero)) {
        CGFloat titleHeight = [_titleLabel textRectForBounds:CGRectMake(0, 0, _titleLabel.width, 666) limitedToNumberOfLines:2].size.height;
        if (titleHeight == _titleLabel.height) {
            return;
        }
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset = titleHeight;
        }];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _picImageView = [[UIImageView alloc] init];
        _picImageView.layer.cornerRadius = 6;
        _picImageView.layer.masksToBounds = YES;
        [self addSubview:_picImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(13);
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
        
        _ownerLabel = [[UILabel alloc] init];
        _ownerLabel.font = Font(10);
        _ownerLabel.textColor = ColorWhite(146);
        [self addSubview:_ownerLabel];
        
        _viewCountLabel = [[UILabel alloc] init];
        _viewCountLabel.font = Font(10);
        _viewCountLabel.textColor = ColorWhite(146);
        [self addSubview:_viewCountLabel];
        
        _danmakuCountLabel = [[UILabel alloc] init];
        _danmakuCountLabel.font = Font(10);
        _danmakuCountLabel.textColor = ColorWhite(146);
        _danmakuCountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_danmakuCountLabel];
        
        
        [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 0;
            make.bottom.offset = -10;
            make.width.equalTo(_picImageView.mas_height).multipliedBy(120.0/90.0);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_picImageView.mas_right).offset = 10;
            make.top.equalTo(_picImageView);
            make.right.offset = -10;
            make.height.offset = 30;
        }];
        [_ownerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.bottom.equalTo(_viewCountLabel.mas_top).offset = -10;
            make.right.offset = -10;
            make.height.offset = 11;
        }];
        [_viewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_danmakuCountLabel.mas_left).offset = -10;
            make.height.offset = 11;
            make.bottom.offset = -10;
        }];
        [_danmakuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewCountLabel);
            make.right.offset = -10;
            make.width.offset = 80;
            make.height.offset = 11;
        }];
        
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = ColorWhite(200);
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.bottom.offset = 0;
            make.height.offset = 0.5;
        }];
        
    }
    return self;
}

@end
