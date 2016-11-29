//
//  ScrollTabBarController.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ScrollTabBarController.h"

// ViewController
#import "NavigationController.h"

#import "HomeViewController.h"
#import "RegionListViewController.h"
#import "FollowViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"

#import "TabBarControllerAnimatedTransitioning.h"

@interface ScrollTabBarController ()
<UITabBarControllerDelegate>
{
    BOOL _interactive;
    NSInteger _lastIndex;
}

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation ScrollTabBarController

- (instancetype)init; {
    self = [super init];
    if (!self) {
        return NULL;
    }
    
    self.viewControllers = @[
                             [[NavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]],
                             [[NavigationController alloc] initWithRootViewController:[[RegionListViewController alloc] init]],
                             [[NavigationController alloc] initWithRootViewController:[[FollowViewController alloc] init]],
                             [[NavigationController alloc] initWithRootViewController:[[FindViewController alloc] init]],
                             [[NavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]],
                             ];
    
    self.delegate = self;
    self.tabBar.tintColor = CRed;
    self.tabBar.translucent = NO;
    
    _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture; {
    
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat translationAbs = translationX > 0 ? translationX : - translationX;
    CGFloat progress = translationAbs / self.view.frame.size.width;
    
    static NSTimeInterval beganTime;
    
    
    
    
    
//    NSLog(@"%ld", self.selectedIndex);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            beganTime = CACurrentMediaTime();
            _interactive = YES;
            _lastIndex = self.selectedIndex;
            if (translationX < 0) {
                self.selectedIndex += 1;
            }
            else {
                self.selectedIndex -= 1;
            }
            break;
        case UIGestureRecognizerStateChanged:
            if (_lastIndex > self.selectedIndex && translationX < 0) {
                progress = 0;
            }
            else if (_lastIndex < self.selectedIndex && translationX > 0) {
                progress = 0;
            }
            [self.interactionController updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGFloat speed = translationAbs / (CACurrentMediaTime() - beganTime);
//            NSLog(@"speed %lf", speed);
            self.interactionController.completionSpeed = 0.99;
            if (progress > 0.5 || speed > 600) {
                [self.interactionController finishInteractiveTransition];
            }
            else {
                [self.interactionController cancelInteractiveTransition];
            }
            _interactive = NO;
            _lastIndex = -1;
            break;
        }
        default:
            break;
    }
    
}

#pragma mark UITabBarControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (!_interactive) {
        return NULL;
    }
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    TabOperationDirection direction = toIndex < fromIndex ? TabOperationDirectionLeft : TabOperationDirectionRight;
    return [[TabBarControllerAnimatedTransitioning alloc] initWithTabOperationDirection:direction];
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController; {
    return _interactive ? self.interactionController : NULL;
}

- (UIPercentDrivenInteractiveTransition *)interactionController; {
    if (!_interactionController) {
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _interactionController;
}

@end
