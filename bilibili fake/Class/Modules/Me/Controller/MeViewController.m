//
//  MeViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MeViewController.h"
#import "ScrollTabBarController.h"

#import "MeHeaderView.h"
#import "MineCollectionView.h"


//typedef struct MeItemEntity {
//    char *title;
//    char *logoName;
//} MeItemEntity;
//
//typedef struct MeGroupEntity {
//    char *title;
//    MeItemEntity *items;
//} MeGroupEntity;


@interface MeViewController ()

@property (strong, nonatomic) MeHeaderView *headerView;

@property (strong, nonatomic) MineCollectionView *collectionView;

@end

@implementation MeViewController

- (instancetype)init; {
    if (self = [super init]) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = CRed;
    
    [self loadSubviews];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_collectionView removeFromSuperview];
//        _collectionView = NULL;
//    });
    
    
    
//    MeItemEntity items[7] = {
//        {"",""},
//        {"",""},
//        {"",""},
//        {"",""},
//        {"",""},
//        {"",""},
//        {"",""}
//    };
    
    MineGroupEntity *group1 = [[MineGroupEntity alloc] init];
    group1.title = @"个人中心";
    group1.items = @[
                    [MineItemEntity entityWithTitle:@"离线缓存" logoName:@"mine_download"],
                    [MineItemEntity entityWithTitle:@"历史记录" logoName:@"mine_history"],
                    [MineItemEntity entityWithTitle:@"我的收藏" logoName:@"mine_favourite"],
                    [MineItemEntity entityWithTitle:@"我的关注" logoName:@"mine_follow"],
                    [MineItemEntity entityWithTitle:@"我的钱包" logoName:@"mine_pocketcenter"],
                    [MineItemEntity entityWithTitle:@"游戏中心" logoName:@"mine_gamecenter"],
                    [MineItemEntity entityWithTitle:@"主题选择" logoName:@"mine_theme"],
                    ];
    
    
    
    MineGroupEntity *group2 = [[MineGroupEntity alloc] init];
    group2.title = @"我的消息";
    group2.items = @[
                     [MineItemEntity entityWithTitle:@"回复我的" logoName:@"mine_answerMessage"],
                     [MineItemEntity entityWithTitle:@"@我" logoName:@"mine_shakeMe"],
                     [MineItemEntity entityWithTitle:@"收到的赞" logoName:@"mine_gotPrise"],
                     [MineItemEntity entityWithTitle:@"私信" logoName:@"mine_privateMessage"],
                     [MineItemEntity entityWithTitle:@"系统通知" logoName:@"mine_systemNotification"],
                     ];
    
    _collectionView.groups = @[group1, group2];
}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)loadSubviews {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    _headerView = [[MeHeaderView alloc] init];
    [self.view addSubview:_headerView];
    
    _collectionView = [[MineCollectionView alloc] init];
    [self.view addSubview:_collectionView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 20;
        make.height.offset = 150;
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(_headerView.mas_bottom);
        make.bottom.offset = 0;
    }];
}


@end
