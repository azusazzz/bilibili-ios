//
//  RecommendAvCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendAvCollectionViewCell.h"

@interface RecommendAvCollectionViewCell ()
//{
//    UILabel     *_titleLabel;
//    UIImageView *_playCountImageView;
//    UILabel     *_playCountLabel;
//    UIImageView *_danmakuCountImageView;
//    UILabel     *_danmakuCountLabel;
//}
@end


@implementation RecommendAvCollectionViewCell

+ (CGSize)sizeForContentWidth:(CGFloat)width {
    CGFloat itemWidth = (width - 15*3) / 2;
    return CGSizeMake(itemWidth, itemWidth * 0.625 + 5 + 30 + 5);
}

- (void)setBody:(RecommendBodyEntity *)body {
    [super setBody:body];
    _titleLabel.text = body.title;
    
    
    _playCountLabel.text = IntegerToTenThousand(body.play);
    _danmakuCountLabel.text = IntegerToTenThousand(body.danmaku);
    
    [_titleLabel layoutIfNeeded];
    CGFloat height = [_titleLabel textRectForBounds:CGRectMake(0, 0, _titleLabel.width, 999) limitedToNumberOfLines:2].size.height;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = height;
    }];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self showImageViewBottomGradient];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textColor = ColorWhite(86);
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        _playCountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_playCount_new"]];
        [self.contentView addSubview:_playCountImageView];
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.font = Font(10);
        _playCountLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_playCountLabel];
        
        _danmakuCountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_danmakuCount_new"]];
        [self.contentView addSubview:_danmakuCountImageView];
        _danmakuCountLabel = [[UILabel alloc] init];
        _danmakuCountLabel.font = Font(10);
        _danmakuCountLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_danmakuCountLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(self.imageView.mas_bottom).offset = 5;
            [make.height.lessThanOrEqualTo(@30) priorityHigh];
        }];
        
        [_playCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView).offset = 5;
            make.bottom.equalTo(self.imageView).offset = -5;
            make.width.offset = 14;
            make.height.offset = 10;
        }];
        [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_playCountImageView.mas_right).offset = 5;
            make.centerY.equalTo(_playCountImageView);
            make.height.offset = 12;
            make.right.equalTo(self.imageView.mas_centerX);
        }];
        [_danmakuCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_centerX).offset = 5;
            make.bottom.equalTo(self.imageView).offset = -5;
            make.width.offset = 14;
            make.height.offset = 10;
        }];
        [_danmakuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_danmakuCountImageView.mas_right).offset = 5;
            make.centerY.equalTo(_playCountImageView);
            make.height.offset = 12;
            make.right.equalTo(self.imageView).offset = -10;
        }];
    }
    return self;
}



@end
