//
//  LivePartitionsFooterView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LivePartitionsFooterView.h"

@interface LivePartitionsFooterView ()
{
    UIButton *_moreButton;
}
@end

@implementation LivePartitionsFooterView

+ (CGFloat)height {
    return 56;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:ColorWhite(146) forState:UIControlStateNormal];
        _moreButton.titleLabel.font = Font(12);
        _moreButton.layer.cornerRadius = 6;
        _moreButton.layer.borderColor = ColorWhite(200).CGColor;
        _moreButton.layer.borderWidth = 0.5;
        [self addSubview:_moreButton];
        
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.top.offset = 10;
            make.bottom.offset = -10;
            make.width.offset = 150;
        }];
    }
    return self;
}

@end
