//
//  UIViewController+GetViewController.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GetViewController)

/**
 *  获取根控制器
 *
 *  @return <#return value description#>
 */
+ (UIViewController *)rootViewController;

/**
 *  获取当前导航控制器
 *
 *  @return <#return value description#>
 */
+ (UINavigationController*)currentNavigationViewController;

/**
 *  获取当前控制器
 *
 *  @return <#return value description#>
 */
+ (UIViewController *)currentViewController;

@end
