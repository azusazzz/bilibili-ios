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


#import "LiveListViewController.h"
#import "RecommendListViewController.h"
#import "BangumiListViewController.h"



#import "ScrollTabBarController.h"


#import "VideoViewController.h"  // 视频信息

#import "UIViewController+GetViewController.h"


@interface HomeViewController ()
<UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    HomeHeaderView *_headerView;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@end



@implementation HomeViewController

+ (void)showLiveList {
    [[UIViewController currentNavigationViewController] popToRootViewControllerAnimated:NO];
    [UIViewController currentViewController].tabBarController.selectedIndex = 0;
    
    HomeViewController *controller = [UIViewController currentViewController];
    if (![controller isMemberOfClass:[HomeViewController class]]) {
        return;
    }
    [controller.scrollView setContentOffset:CGPointZero animated:NO];
}

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


- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    _headerView.contentOffset = scrollView.contentOffset.x / self.view.width;
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
    
    
    // 直播
    LiveListViewController *liveListController = [[LiveListViewController alloc] init];
    [self addChildViewController:liveListController];
    // 推荐
    RecommendListViewController *recommendListController = [[RecommendListViewController alloc] init];
    [self addChildViewController:recommendListController];
    // 番剧
    BangumiListViewController *bangumiListController = [[BangumiListViewController alloc] init];
    [self addChildViewController:bangumiListController];
    
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.childViewControllers.count];
    
    MASViewAttribute *constraint = _scrollView.mas_left;
    for (UIViewController *controller in self.childViewControllers) {
        [titles addObject:controller.title];
        
        [_scrollView addSubview:controller.view];
        [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(constraint);
            make.top.equalTo(_scrollView);
            make.width.equalTo(_scrollView);
            make.height.equalTo(_scrollView);
        }];
        
        constraint = controller.view.mas_right;
    }
    
    
    // Header
    _headerView = [[HomeHeaderView alloc] initWithTitles:titles];
    [self.view addSubview:_headerView];
    
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
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(constraint);
    }];
    
    
    _scrollView.contentSize = CGSizeMake(self.view.width * 3, 0);
    [_scrollView setContentOffset:CGPointMake(self.view.width, 0)];
}


@end
