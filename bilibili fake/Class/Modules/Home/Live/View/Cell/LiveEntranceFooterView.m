//
//  LiveEntranceFooterView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveEntranceFooterView.h"

@interface LiveEntranceFooterView ()
{
    UIView *_contentView;
}
@end

@implementation LiveEntranceFooterView

+ (CGFloat)height {
    return 60;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _contentView = [[UIView alloc] init];
        _contentView.layer.cornerRadius = 6;
        _contentView.backgroundColor = CRed;
        [self addSubview:_contentView];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.offset = 0;
            make.bottom.offset = -10;
        }];
        
    }
    return self;
}

@end
