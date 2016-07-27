//
//  RegionCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionCollectionViewCell.h"

@interface RegionCollectionViewCell ()
{
    UIImageView *_logoImageView;
    UILabel *_titleLabel;
}
@end

@implementation RegionCollectionViewCell

- (void)setRegion:(RegionEntity *)region {
    _titleLabel.text = region.name;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = ColorWhite(146);
        [self.contentView addSubview:_titleLabel];
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.height.offset = 14;
            make.centerY.offset = 0;
        }];
        
    }
    return self;
}

@end
