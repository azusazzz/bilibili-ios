//
//  BangumiEndHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEndHeaderView.h"


@interface BangumiEndHeaderView ()
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    
    UIImageView *_moreImageView;
    UILabel *_countLabel;
}
@end

@implementation BangumiEndHeaderView

+ (CGFloat)height {
    return 35;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"home_region_icon_32"];
        [self addSubview:_iconImageView];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font(14);
        _nameLabel.textColor = ColorWhite(34);
        _nameLabel.text = @"完结动画";
        [self addSubview:_nameLabel];
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"common_rightArrowShadow"];
        [self addSubview:_moreImageView];
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = Font(14);
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.textColor = ColorWhite(146);
        _countLabel.text = @"进去看看";
        [self addSubview:_countLabel];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 20;
            make.height.offset = 20;
            make.left.offset = 15;
            make.bottom.offset = 0;
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImageView.mas_right).offset = 5;
            make.width.offset = 80;
            make.height.offset = 20;
            make.bottom.offset = 0;
        }];
        [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.width.offset = 20;
            make.height.offset = 20;
            make.bottom.offset = 00;
        }];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_moreImageView.mas_left).offset = -5;
            make.bottom.offset = 0;
            make.height.offset = 20;
            make.left.equalTo(_nameLabel.mas_right).offset = 10;
        }];
        
    }
    return self;
}

@end
