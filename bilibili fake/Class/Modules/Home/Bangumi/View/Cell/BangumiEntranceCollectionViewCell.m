//
//  BangumiEntranceCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEntranceCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface BangumiEntranceCollectionViewCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
@end

@implementation BangumiEntranceCollectionViewCell

+ (CGFloat)height {
    return 15+40+4+12+15;
}

- (void)setEntrance:(BangumiEntranceEntity *)entrance {
    _imageView.image = [UIImage imageNamed:entrance.iconName];
    _titleLabel.text = entrance.title;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = ColorWhite(34);
        [self.contentView addSubview:_titleLabel];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@40);
            make.height.equalTo(@40);
            make.centerX.offset = 0;
            make.centerY.offset = -8;
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_imageView.mas_bottom).offset = 4;
            make.height.offset = 12;
        }];
        
    }
    return self;
}


@end
