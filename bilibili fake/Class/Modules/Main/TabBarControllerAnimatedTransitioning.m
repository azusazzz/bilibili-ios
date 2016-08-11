//
//  TabBarControllerAnimatedTransitioning.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "TabBarControllerAnimatedTransitioning.h"

@interface TabBarControllerAnimatedTransitioning ()
{
    TabOperationDirection _direction;
}

@end

@implementation TabBarControllerAnimatedTransitioning

- (instancetype)initWithTabOperationDirection:(TabOperationDirection)direction {
    self = [super init];
    
    _direction = direction;
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext; {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext; {
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    
    if (_direction == TabOperationDirectionLeft) {
        toViewTransform = CGAffineTransformMakeTranslation(-containerView.frame.size.width, 0);
        fromViewTransform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0);
    }
    else {
        toViewTransform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0);
        fromViewTransform = CGAffineTransformMakeTranslation(-containerView.frame.size.width, 0);
    }
    
    [containerView addSubview:toView];
    
    toView.transform = toViewTransform;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = fromViewTransform;
    } completion:^(BOOL finished) {
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformIdentity;
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
    
}


@end
