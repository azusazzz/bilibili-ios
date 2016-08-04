//
//  UIViewController+HeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIViewController+HeaderView.h"
#import <objc/runtime.h>


@interface ViewControllerHeaderView ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *backButton;

@end

@implementation ViewControllerHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = CRed;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(16);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_backButton setTintColor:[UIColor whiteColor]];
        [_backButton setImage:[UIImage imageNamed:@"fullplayer_icon_back"] forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 80;
            make.right.offset = -80;
            make.top.offset = 5;
            make.bottom.offset = -5;
        }];
        
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 5;
            make.width.offset = 44;
            make.height.offset = 44;
            make.centerY.offset = 0;
        }];
        [_backButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 26;
            make.height.offset = 26;
            make.center.equalTo(_backButton);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setBackTarget:(id)target action:(SEL)action {
    [self.backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end


@implementation UIViewController (HeaderView)

- (ViewControllerHeaderView *)headerView {
    ViewControllerHeaderView *headerView = objc_getAssociatedObject(self, @selector(headerView));
    if (!headerView) {
        headerView = [[ViewControllerHeaderView alloc] init];
        [self.view addSubview:UIView.new];
        [self.view addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 20;
            make.height.offset = 44;
        }];
        [headerView setBackTarget:self action:@selector(backViewController)];
        objc_setAssociatedObject(self, @selector(headerView), headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return headerView;
}

- (void)backViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
