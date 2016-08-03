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

@interface FollowViewController ()
<UIScrollViewDelegate>
{
    TabBar *_tabbar;
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
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _tabbar.contentOffset = scrollView.contentOffset.x / scrollView.width;
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
    return UIInterfaceOrientationMaskPortrait;
}


- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}



@end
