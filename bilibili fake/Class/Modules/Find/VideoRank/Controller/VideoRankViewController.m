//
//  VideoRankViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRankViewController.h"
#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "Macro.h"

@interface VideoRankViewController()<UIGestureRecognizerDelegate>

@end

@implementation VideoRankViewController{
    NSArray<NSString *>* titleArr;
}
-(instancetype)initWithTitles:(NSArray<NSString *>*) titles{
    if (self = [super init]) {
        titleArr = titles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    [self loadSubviews];
    [self navigationBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = UIStyleBackgroundColor;
    
    self.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIStyleForegroundColor};
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}
#pragma loadSubviews
-(void)loadSubviews{
    
}
@end
