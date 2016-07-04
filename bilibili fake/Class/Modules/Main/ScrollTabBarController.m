//
//  ScrollTabBarController.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ScrollTabBarController.h"

// ViewController
#import "HomeViewController.h"
#import "FollowViewController.h"
#import "FindViewController.h"
#import "TabBarControllerAnimatedTransitioning.h"

@interface ScrollTabBarController ()
<UITabBarControllerDelegate>
{
    BOOL _interactive;
    
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
                             [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]],
                             [[UINavigationController alloc] initWithRootViewController:[[FollowViewController alloc] init]],
                             [[UINavigationController alloc] initWithRootViewController:[[FindViewController alloc] init]],
                             ];
    
    self.delegate = self;
    
    _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture; {
    
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat translationAbs = translationX > 0 ? translationX : - translationX;
    CGFloat progress = translationAbs / self.view.frame.size.width;
    
//    NSLog(@"%lf", progress);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            _interactive = YES;
            if (translationX < 0) {
                self.selectedIndex += 1;
            }
            else {
                self.selectedIndex -= 1;
            }
            break;
        case UIGestureRecognizerStateChanged:
            [self.interactionController updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        {
            self.interactionController.completionSpeed = 0.99;
            if (progress > 0.5) {
                [self.interactionController finishInteractiveTransition];
            }
            else {
                [self.interactionController cancelInteractiveTransition];
            }
            _interactive = NO;
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            self.interactionController.completionSpeed = 0.99;
            if (progress > 0.5) {
                [self.interactionController finishInteractiveTransition];
            }
            else {
                [self.interactionController cancelInteractiveTransition];
            }
            _interactive = NO;
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
