//
//  UIViewController+HeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIViewController+HeaderView.h"
#import <objc/runtime.h>


@interface NavigationBar ()

@end

@implementation NavigationBar

- (instancetype)init {
    if (self = [super init]) {
        self.tintColor = [UIColor whiteColor];
        self.barTintColor = CRed;
        self.translucent = NO;
        self.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    return self;
}

@end


@implementation UIViewController (HeaderView)

- (NavigationBar *)navigationBar {
    NavigationBar *navigationBar = objc_getAssociatedObject(self, @selector(navigationBar));
    if (!navigationBar) {
        navigationBar = [[NavigationBar alloc] init];
        
        if (![self.navigationItem.leftBarButtonItems count]) {
            UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fullplayer_icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backViewController)];
            self.navigationItem.leftBarButtonItems = @[backBarButton];
        }
        navigationBar.items = @[self.navigationItem];
        
        [self.view addSubview:UIView.new];
        [self.view addSubview:navigationBar];
        [navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 20;
            make.height.offset = 44;
        }];
        objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationBar;
}

- (void)backViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
