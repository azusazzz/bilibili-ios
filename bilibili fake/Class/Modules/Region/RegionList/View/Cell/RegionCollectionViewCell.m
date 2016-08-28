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

+ (CGFloat)heightForWidth:(CGFloat)width {
    return width * 152.0/144.0 + 14;
}

- (void)setRegion:(RegionEntity *)region {
    _titleLabel.text = region.name;
    if ([region.name isEqualToString:@"直播"]) {
        _logoImageView.image = [UIImage imageNamed:@"home_region_icon_live"];
    }
    else {
        _logoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_region_icon_%ld", region.tid]];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        UIImageView *borderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_region_border"]];
        [self.contentView addSubview:borderView];
        
        _logoImageView = [[UIImageView alloc] init];
        [borderView addSubview:_logoImageView];
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = Font(12);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = ColorWhite(146);
            [self.contentView addSubview:label];
            label;
        });
        
        [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset = 0;
            make.left.offset = 0;
            make.right.offset = 0;
            make.height.equalTo(borderView.mas_width).multipliedBy(152.0/144.0);
        }];
        
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(borderView.mas_width).multipliedBy(0.4);
            make.height.equalTo(_logoImageView.mas_width);
            make.centerY.equalTo(borderView).offset = -5;
            make.centerX.equalTo(borderView);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.height.offset = 14;
            make.bottom.offset = 0;
        }];
        
    }
    return self;
}

@end
