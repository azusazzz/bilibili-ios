//
//  UIViewController+PopGesture.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopGesture)

/**
 *  替换导航控制器Pop手势
 *
 *  @param panGestureRecognizer 手势识别
 */
- (void)replacingPopGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
