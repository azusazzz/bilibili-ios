//
//  MineViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MineViewController.h"
#import "ScrollTabBarController.h"
#import "UIStyleMacro.h"

// Subviews
#import "MineHeaderView.h"
#import "MineCollectionView.h"

// ViewController
#import "DownloadVideoManagerViewController.h"  // 离线缓存
#import "HistoryViewController.h"   // 历史记录
#import "GameCenterViewController.h"            // 游戏中心
#import "UIStyleSelectionVC.h"      // 主题选择

@interface MineViewController ()

@property (strong, nonatomic) MineHeaderView *headerView;

@property (strong, nonatomic) MineCollectionView *collectionView;

@end

@implementation MineViewController

- (instancetype)init; {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_mine_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_mine_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIStyleBackgroundColor;
    
    [self loadSubviews];
    
    
    __weak typeof(self) weakself = self;
    [_collectionView setHandleDidSelectedItem:^(NSIndexPath *indexPath) {
        [weakself handleDidSelectedItem:indexPath];
    }];
    
    
    
    
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

- (void)handleDidSelectedItem:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[DownloadVideoManagerViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[HistoryViewController alloc] init] animated:YES];
        }
        else if (indexPath.row == 5) {
            [self.navigationController pushViewController:[[GameCenterViewController alloc] init] animated:YES];
        }else if(indexPath.row == 6){
            [self.navigationController pushViewController:[[UIStyleSelectionVC alloc] init] animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        
    }
   
}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationController.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: UIStyleForegroundColor,
      NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};  //标题颜色和字体
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    
    _headerView = [[MineHeaderView alloc] init];
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
        make.bottom.offset = 3;
    }];
}


@end
