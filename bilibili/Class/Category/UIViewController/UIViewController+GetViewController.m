//
//  UIViewController+GetViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIViewController+GetViewController.h"

@implementation UIViewController (GetViewController)

+ (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (UIViewController *)rootViewController {
    return self.applicationDelegate.window.rootViewController;
}

+ (UINavigationController*)currentNavigationViewController {
    return self.currentViewController.navigationController;
}

+ (UIViewController *)currentViewController {
    return [self currentViewControllerFrom:self.rootViewController];
}

+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end
