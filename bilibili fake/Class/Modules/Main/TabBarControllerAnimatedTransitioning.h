//
//  TabBarControllerAnimatedTransitioning.h
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TabOperationDirection) {
    TabOperationDirectionLeft,
    TabOperationDirectionRight
};

@interface TabBarControllerAnimatedTransitioning : NSObject
<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTabOperationDirection:(TabOperationDirection)direction;

@end
