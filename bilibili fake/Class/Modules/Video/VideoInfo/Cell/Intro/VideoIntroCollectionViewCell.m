//
//  VideoIntroCollectionViewCell.m
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroCollectionViewCell.h"

@interface VideoIntroCollectionViewCell ()
{
    UILabel *_titleLabel;
    
    UIImageView *_viewIconImageView;
    UILabel *_viewCountLabel;
    
    UIImageView *_danmakuIconImageView;
    UILabel *_danmakuCountLabel;
    
    UILabel *_descLabel;
}
@end

@implementation VideoIntroCollectionViewCell

+ (CGFloat)heightForWidth:(CGFloat)width videoInfo:(VideoInfoEntity *)videoInfo showAllDesc:(BOOL)showAllDesc {
    CGFloat descHeight = [videoInfo.desc boundingRectWithSize:CGSizeMake(width-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.height + 15;
    if (!showAllDesc && descHeight > Font(12).lineHeight*2) {
        descHeight = Font(12).lineHeight*2;
    }
    return 15+15 + 10+10 + 15+descHeight + 15;
}

- (void)setVideoInfo:(VideoInfoEntity *)videoInfo showAllDesc:(BOOL)showAllDesc {
    _titleLabel.text = videoInfo.title;
    _viewCountLabel.text = IntegerToTenThousand(videoInfo.stat.view);
    _danmakuCountLabel.text = IntegerToTenThousand(videoInfo.stat.danmaku);
    _descLabel.text = videoInfo.desc;
    
    CGFloat viewCountWidth = [_viewCountLabel textRectForBounds:CGRectMake(0, 0, 150, 12) limitedToNumberOfLines:1].size.width;
    [_viewCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset = viewCountWidth;
    }];
    CGFloat danmakuCountWidth = [_danmakuCountLabel textRectForBounds:CGRectMake(0, 0, 150, 12) limitedToNumberOfLines:1].size.width;
    [_danmakuCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset = danmakuCountWidth;
    }];
    
    [_descLabel layoutIfNeeded];
    CGFloat descCountHeight = [_descLabel textRectForBounds:CGRectMake(0, 0, _descLabel.width, 999) limitedToNumberOfLines:(showAllDesc ? 0 : 2)].size.height;
    [_descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = descCountHeight;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(13);
        [self addSubview:_titleLabel];
        
        _viewIconImageView = [[UIImageView alloc] init];
        _viewIconImageView.image = [UIImage imageNamed:@"misc_danmakuCount"];
        [self addSubview:_viewIconImageView];
        _viewCountLabel = [[UILabel alloc] init];
        _viewCountLabel.textColor = ColorWhite(146);
        _viewCountLabel.font = Font(10);
        [self addSubview:_viewCountLabel];
        
        _danmakuIconImageView = [[UIImageView alloc] init];
        _danmakuIconImageView.image = [UIImage imageNamed:@"misc_danmakuCount"];
        [self addSubview:_danmakuIconImageView];
        _danmakuCountLabel = [[UILabel alloc] init];
        _danmakuCountLabel.textColor = ColorWhite(146);
        _danmakuCountLabel.font = Font(10);
        [self addSubview:_danmakuCountLabel];
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = Font(12);
        _descLabel.textColor = ColorWhite(146);
        _descLabel.numberOfLines = 0;
        [self addSubview:_descLabel];
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.offset = 15;
            make.height.offset = 15;
        }];
        
        [_viewIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.equalTo(_titleLabel.mas_bottom).offset = 10;
            make.width.offset = 13;
            make.height.offset = 10;
        }];
        [_viewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_viewIconImageView.mas_right).offset = 5;
            make.centerY.equalTo(_viewIconImageView);
            make.height.offset = 12;
            make.width.offset = 30;
        }];
        
        [_danmakuIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_viewCountLabel.mas_right).offset = 10;
            make.centerY.equalTo(_viewIconImageView);
            make.width.offset = 13;
            make.height.offset = 10;
        }];
        [_danmakuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_danmakuIconImageView.mas_right).offset = 5;
            make.centerY.equalTo(_viewIconImageView);
            make.height.offset = 12;
            make.width.offset = 30;
        }];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.equalTo(_viewCountLabel.mas_bottom).offset = 15;
            make.height.offset = 40;
        }];
        
    }
    return self;
}




@end
