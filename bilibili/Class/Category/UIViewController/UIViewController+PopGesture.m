//
//  UIViewController+PopGesture.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIViewController+PopGesture.h"
#import "NSObject+Runtime.h"


void *const EnabledKey = "PopGesture_enabled";


@implementation UIViewController (PopGesture)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(viewDidDisappear:) swizzledSelector:@selector(PopGesture_viewDidDisappear:)];
    });
}

- (void)replacingPopGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (!self.navigationController) {
        return;
    }
    NSArray *internalTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    [panGestureRecognizer addTarget:internalTarget action:internalAction];
    
    objc_setAssociatedObject(self, EnabledKey, @(self.navigationController.interactivePopGestureRecognizer.enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)PopGesture_viewDidDisappear:(BOOL)animated {
    [self PopGesture_viewDidDisappear:animated];
    if (!self.navigationController) {
        return;
    }
    NSNumber *enabled = objc_getAssociatedObject(self, EnabledKey);
    if (!enabled) {
        return;
    }
    objc_setAssociatedObject(self, EnabledKey, NULL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.interactivePopGestureRecognizer.enabled = [enabled boolValue];
}

@end
