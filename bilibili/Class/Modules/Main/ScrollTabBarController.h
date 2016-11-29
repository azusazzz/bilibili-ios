//
//  ScrollTabBarController.h
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTabBarController : UITabBarController

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture;

@end
