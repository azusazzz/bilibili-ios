//
//  MineCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MineCollectionViewCell.h"


@interface MineCollectionViewCell ()
{
    UIImageView *_logoImageView;
    UILabel *_titleLabel;
}
@end

@implementation MineCollectionViewCell


- (void)setItem:(MineItemEntity *)item {
    if (item) {
        _logoImageView.image = [UIImage imageNamed:item.logoName];
        _titleLabel.text = item.title;
    }
    else {
        _logoImageView.image = NULL;
        _titleLabel.text = NULL;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _logoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_logoImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textColor = ColorWhite(86);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 30;
            make.height.offset = 30;
            make.centerX.offset = 0;
            make.centerY.offset = -10;
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.height.offset = 14;
            make.top.equalTo(_logoImageView.mas_bottom).offset = 5;
        }];
    }
    return self;
}

@end
