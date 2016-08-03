//
//  HomeViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeViewController.h"



// SubModules

#import "HomeHeaderView.h"

#import "HomeLiveView.h"
#import "HomeRecommendView.h"
#import "HomeAnimationView.h"

#import "ScrollTabBarController.h"


#import "VideoViewController.h"


@interface HomeViewController ()
<UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    HomeHeaderView *_headerView;
    
    
    
    HomeLiveView *_liveView;
    HomeRecommendView *_recommendView;
    HomeAnimationView *_animationView;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@end



@implementation HomeViewController

- (instancetype)init; {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_home_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_home_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CRed;
    [self loadSubviews];
    
    
    /**
     *  点击头部标签栏按钮
     */
    __weak typeof(self) weakself = self;
    [_headerView setOnClickItem:^(NSInteger idx) {
        [weakself.scrollView setContentOffset:CGPointMake(weakself.scrollView.width * idx, 0) animated:YES];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated; {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
//    _headerView.contentOffset = scrollView.contentOffset.x / scrollView.contentSize.width;
    _headerView.contentOffset = scrollView.contentOffset.x / scrollView.width;
//    NSLog(@"Progress: %lf", scrollView.contentOffset.x / scrollView.width);
    
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
    return YES;
}


#pragma mark Subviews

- (void)loadSubviews {
    [self.view addSubview:UIView.new];
    
    // Header
    _headerView = [[HomeHeaderView alloc] initWithTitles:@[@"直播", @"推荐", @"番剧"]];
    [self.view addSubview:_headerView];
    
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = CRed;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [_scrollView addGestureRecognizer:panGestureRecognizer];
    
    
    // SubModules
    
    // 直播
    _liveView = [[HomeLiveView alloc] init];
    _liveView.layer.cornerRadius = 6;
    _liveView.layer.masksToBounds = YES;
    [_scrollView addSubview:_liveView];
    
    // 推荐
    _recommendView = [[HomeRecommendView alloc] init];
    _recommendView.layer.cornerRadius = 6;
    _recommendView.layer.masksToBounds = YES;
    [_scrollView addSubview:_recommendView];
    
    // 番剧
    _animationView = [[HomeAnimationView alloc] init];
    _animationView.layer.cornerRadius = 6;
    _animationView.layer.masksToBounds = YES;
    [_scrollView addSubview:_animationView];
    
    
    
    
    // Layout
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset = 20;
        make.height.equalTo(@(44));
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    
    [_liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView);
        make.top.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView).offset = 3;
    }];
    [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_liveView.mas_right);
        make.top.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView).offset = 3;
    }];
    [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recommendView.mas_right);
        make.top.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.equalTo(_scrollView).offset = 3;
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_animationView.mas_right);
    }];
    
}


@end
