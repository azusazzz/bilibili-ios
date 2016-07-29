//
//  MineHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MineHeaderView.h"


@interface MineHeaderView ()
{
    UIButton *_signupButton;
    UIButton *_signinButton;
}
@end

@implementation MineHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = CRed;
        
        _signinButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_signinButton setTitle:@"登录" forState:UIControlStateNormal];
        [_signinButton setTitleColor:CRed forState:UIControlStateNormal];
        _signinButton.backgroundColor = [UIColor whiteColor];
        _signinButton.layer.cornerRadius = 6;
        [self addSubview:_signinButton];
        
        _signupButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_signupButton setTitle:@"注册" forState:UIControlStateNormal];
        [_signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _signupButton.backgroundColor = ColorRGB(255, 141, 172);
        _signupButton.layer.cornerRadius = 6;
        [self addSubview:_signupButton];
        
        
        [_signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset = -10;
            make.height.offset = 40;
            make.width.offset = 100;
            make.centerY.equalTo(self);
        }];
        [_signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset = 10;
            make.height.offset = 40;
            make.width.offset = 100;
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

@end
