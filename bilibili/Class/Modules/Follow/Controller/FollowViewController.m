//
//  FollowViewController.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FollowViewController.h"
#import "ScrollTabBarController.h"

#import "TabBar.h"

#import "DanmakuControl.h"


#import "TestRefreshCollectionView.h"



@interface FollowViewController ()
<UIScrollViewDelegate, DanmakuControlDelegate>
{
    TabBar *_tabbar;
    
    
    NSTimeInterval _time;
    
    DanmakuControl *_danmaku;
}
@end

@implementation FollowViewController

- (instancetype)init; {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_attention_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_attention_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWhite(247);
    [self.view addSubview:UIView.new];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    
    /*
    _danmaku = [[DanmakuControl alloc] initWithCid:6001707];
    [self.view addSubview:_danmaku];
    _danmaku.delegate = self;
    [_danmaku mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.bottom.offset = 0;
        make.left.offset = 0;
        make.right.offset = 0;
    }];
    [_danmaku start];
    
    UIButton *resumeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resumeButton setTitle:@"Resume" forState:UIControlStateNormal];
    [resumeButton addTarget:self action:@selector(onClickResume) forControlEvents:UIControlEventTouchUpInside];
    resumeButton.frame = CGRectMake(150, 60, 60, 30);
    [self.view addSubview:resumeButton];
    
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(onClickPause) forControlEvents:UIControlEventTouchUpInside];
    pauseButton.frame = CGRectMake(240, 60, 60, 30);
    [self.view addSubview:pauseButton];
    */
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [danmaku pause];
//        [danmaku removeFromSuperview];
//    });
    
    
    /*
    _tabbar = [[TabBar alloc] initWithTitles:@[@"测试",@"测试测试",@"测试测试测试",@"测试",@"测试测试"] style:TabBarStyleScroll];
    _tabbar.frame = CGRectMake(0, 100, SSize.width, 40);
    _tabbar.spacing = 40;
    _tabbar.edgeInsets = UIEdgeInsetsMake(0, 60, 0, 60);
    [self.view addSubview:_tabbar];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.frame = CGRectMake(0, 160, SSize.width, 400);
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(scrollView.width * 5, 0);
    for (NSInteger i=0; i<5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.width * i, 0, scrollView.width, scrollView.height)];
        view.backgroundColor = ColorRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
        [scrollView addSubview:view];
    }
    
    [_tabbar setOnClickItem:^(NSInteger idx) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * idx, 0) animated:YES];
    }];*/
    
    
    self.view.backgroundColor = CRed;
    
    TestRefreshCollectionView *refreshView = [[TestRefreshCollectionView alloc] init];
    [self.view addSubview:refreshView];
    [refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 64;
        make.bottom.offset = 0;
        make.left.offset = 0;
        make.right.offset = 0;
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _tabbar.contentOffset = scrollView.contentOffset.x / scrollView.width;
}


- (void)onClickPause {
    [_danmaku pause];
}

- (void)onClickResume {
    [_danmaku resume];
}


- (NSTimeInterval)danmakuControlCurrentTime:(DanmakuControl *)danmakuControl {
    return _time += 0.5;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
    return UIInterfaceOrientationMaskLandscapeRight;
}


- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}



@end
