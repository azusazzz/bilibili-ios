//
//  UIViewController+GetViewController.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GetViewController)

+ (UIViewController *)rootViewController;

+ (UINavigationController*)currentNavigationViewController;

+ (UIViewController *)currentViewController;

@end
