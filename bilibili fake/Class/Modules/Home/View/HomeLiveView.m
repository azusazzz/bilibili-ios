//
//  HomeLiveView.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeLiveView.h"
#import "VideoViewController.h"
#import "UIViewController+GetViewController.h"


@interface HomeLiveView ()
{
    UITextField *_textField;
}
@end

@implementation HomeLiveView

- (instancetype)init; {
    if (self = [super init]) {
        self.backgroundColor = ColorWhite(200);
        
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.text = @"5384127";
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_textField];
        
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [pushButton setTitle:@"Push" forState:UIControlStateNormal];
        [pushButton addTarget:self action:@selector(onClickPush) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pushButton];
        
        
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 200;
            make.height.offset = 40;
            make.centerX.equalTo(self);
            make.top.offset = 150;
        }];
        
        [pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 80;
            make.height.offset = 30;
            make.centerX.equalTo(self);
            make.top.equalTo(_textField.mas_bottom).offset = 15;
        }];
        
    }
    return self;
}

- (void)onClickPush {
    NSInteger aid = [_textField.text integerValue];
    if (aid == 0) {
        return;
    }
    [UIViewController.currentNavigationViewController pushViewController:[[VideoViewController alloc] initWithAid:aid] animated:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
