//
//  MineHeaderCollectionReusableView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MineHeaderCollectionReusableView.h"

@interface MineHeaderCollectionReusableView ()
{
    UILabel *_titleLabel;
}
@end

@implementation MineHeaderCollectionReusableView

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (NSString *)title {
    return _titleLabel.text;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(16);
        _titleLabel.textColor = ColorWhite(34);
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 20;
            make.right.offset = -20;
            make.top.offset = 0;
            make.bottom.offset = 0;
        }];
    }
    return self;
}


@end
