//
//  RegionShowHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/31.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowHeaderView.h"

@interface RegionShowHeaderView ()

@end

@implementation RegionShowHeaderView

+ (CGFloat)height {
    return 20+15;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.font = Font(14);
        _leftTitleLabel.textColor = ColorWhite(34);
        [self addSubview:_leftTitleLabel];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.bottom.offset = 0;
            make.width.offset = 20;
            make.height.offset = 20;
        }];
        
        [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset = 5;
            make.bottom.offset = 0;
            make.width.offset = 100;
            make.height.offset = 20;
        }];
        
    }
    return self;
}

@end
