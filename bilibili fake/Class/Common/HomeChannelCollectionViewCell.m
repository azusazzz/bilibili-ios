//
//  HomeChannelCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeChannelCollectionViewCell.h"

@interface HomeChannelCollectionViewCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
@end

@implementation HomeChannelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame; {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset = CGSizeMake(40, 40);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset = -10;
        }];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom).offset = 10;
            make.left.offset = 0;
            make.right.offset = 0;
            make.height.offset = 16;
        }];
    }
    return self;
}

- (void)setChannelEntity:(HomeChannelEntity *)channelEntity; {
    _imageView.image = [UIImage imageNamed:channelEntity.iconName];
    _titleLabel.text = channelEntity.name;
}


@end
