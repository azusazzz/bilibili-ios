//
//  BangumiRecommendCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiRecommendCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface BangumiRecommendCollectionViewCell ()
{
    UIImageView *_coverView;
    UILabel *_titleLabel;
    UILabel *_descLabel;
}
@end

@implementation BangumiRecommendCollectionViewCell


+ (CGFloat)heightForWidth:(CGFloat)width bangumiRecommend:(BangumiRecommendEntity *)bangumiRecommend {
    CGFloat descHeight = [bangumiRecommend.desc boundingRectWithSize:CGSizeMake(width-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.height + 15;
    return width *300/960.0 + 5+16 +5+descHeight;
}

- (void)setBangumiRecommend:(BangumiRecommendEntity *)bangumiRecommend {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:bangumiRecommend.cover]];
    _titleLabel.text = bangumiRecommend.title;
    _descLabel.text = bangumiRecommend.desc;
    [_descLabel layoutIfNeeded];
    CGFloat descHeight = [_descLabel textRectForBounds:CGRectMake(0, 0, _descLabel.width, 400) limitedToNumberOfLines:0].size.height;
    [_descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = descHeight;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        _coverView = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverView];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(14);
        _titleLabel.textColor = ColorWhite(34);
        [self.contentView addSubview:_titleLabel];
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = Font(12);
        _descLabel.textColor = ColorWhite(146);
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
        
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(_coverView.mas_width).multipliedBy(300/960.0);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.right.offset = -15;
            make.top.equalTo(_coverView.mas_bottom).offset = 5;
            make.height.offset = 16;
        }];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.right.offset = -15;
            make.top.equalTo(_titleLabel.mas_bottom).offset = 5;
            make.height.offset = 14;
        }];
    }
    return self;
}

@end
