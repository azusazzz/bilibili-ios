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

@interface TestView : UIView

@end

@implementation TestView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:0 green:0.0 blue:0.0 alpha:0.4].CGColor,
                        (__bridge id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0].CGColor];
    const CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, rect.size.height), CGPointMake(0, 0), 0);
    
}

@end



@interface HomeLiveView ()
{
    UITextField *_textField;
}
@end

@implementation HomeLiveView

- (instancetype)init; {
    if (self = [super init]) {
        self.backgroundColor = ColorWhite(200);
        
        TestView *tv = [[TestView alloc] init];
        tv.frame = CGRectMake(40, 40, 100, 100);
        tv.backgroundColor = [UIColor clearColor];
        [self addSubview:tv];
        
        
        
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.text = @"2983852";
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_textField];
        
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [pushButton setTitle:@"Push" forState:UIControlStateNormal];
        [pushButton addTarget:self action:@selector(onClickPush) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pushButton];
        
        
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.width.offset(200) priorityLow];
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
