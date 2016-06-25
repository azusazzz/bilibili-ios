//
//  HomeViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeViewController.h"
#import <Masonry.h>


// SubModules
#import "HomeHeaderView.h"
#import "HomeLiveView.h"


#import "ScrollTabBarController.h"

@interface HomeViewController ()
<UIGestureRecognizerDelegate>
{
    HomeHeaderView *_headerView;
    
    UIScrollView *_scrollView;
    
    HomeLiveView *_liveView;
    UIView *_classificationView;
    
}

@end

@implementation HomeViewController

- (instancetype)init; {
    if (self = [super init]) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubviews];
}

- (void)viewWillAppear:(BOOL)animated; {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGFloat translationX = [panGestureRecognizer translationInView:_scrollView].x;
    
    NSLog(@"%lf", translationX);
    
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
    
}


#pragma mark - View


#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer; {
    if (_scrollView.contentOffset.x + _scrollView.frame.size.width < _scrollView.contentSize.width) {
        return NO;
    }
    UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
    CGFloat translationX = [panGestureRecognizer translationInView:_scrollView].x;
    if (translationX >= 0) {
        return NO;
    }
    NSLog(@"%lf", translationX);
    return YES;
}


#pragma mark Subviews

- (void)loadSubviews {
    [self.view addSubview:UIView.new];
    
    // Header
    _headerView = [[HomeHeaderView alloc] init];
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset = 20;
        make.height.equalTo(@44);
    }];
    
    
    // SubModules
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [_scrollView addGestureRecognizer:panGestureRecognizer];
    
    
    
    // 直播
    _liveView = [[HomeLiveView alloc] init];
    [_scrollView addSubview:_liveView];
    
    // 分区
    _classificationView = [[UIView alloc] init];
    _classificationView.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:_classificationView];
    
    
    
    
    // Layout
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
        make.bottom.equalTo(@-49);
    }];
    
    [_liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView);
        make.centerY.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
    }];
    [_classificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_liveView.mas_right);
        make.centerY.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_classificationView.mas_right);
    }];
    
}


@end
