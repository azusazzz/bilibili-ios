//
//  BangumiEndItemCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEndItemCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface BangumiEndItemCollectionViewCell ()
{
    UIImageView *_coverView;
    UILabel *_titleLabel;
    UILabel *_countLabel;
}
@end

@implementation BangumiEndItemCollectionViewCell

+ (CGFloat)heightForWitdh:(CGFloat)width {
    return width / 240 * 320 + 40;
}

- (void)setBangumi:(BangumiEntity *)bangumi {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:bangumi.cover]];
    _titleLabel.text = bangumi.title;
    _countLabel.text = [NSString stringWithFormat:@"%ld话全", bangumi.total_count];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _coverView = [[UIImageView alloc] init];
        _coverView.layer.cornerRadius = 6;
        _coverView.layer.masksToBounds = YES;
        [self.contentView addSubview:_coverView];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textColor = ColorWhite(34);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = Font(11);
        _countLabel.textColor = ColorWhite(146);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_countLabel];
        
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(_coverView.mas_width).multipliedBy(320.0/240);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_coverView.mas_bottom).offset = 5;
            make.height.offset = 15;
        }];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_titleLabel.mas_bottom).offset = 5;
            make.height.offset = 15;
        }];
    }
    return self;
}

@end
