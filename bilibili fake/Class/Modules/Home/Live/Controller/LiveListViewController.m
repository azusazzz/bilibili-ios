//
//  LiveListViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListViewController.h"
#import "MediaPlayer.h"
#import "LiveListModel.h"
#import "LiveCollectionView.h"
#import "LivePlayer.h"

#import "URLRouter.h"

@interface LiveListViewController ()
<RefreshCollectionViewDelegate>

@property (strong, nonatomic) LiveListModel *model;

@property (strong, nonatomic) LiveCollectionView *collectionView;

@end

@implementation LiveListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"直播";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWhite(247);
    
    [self loadSubviews];
    
    [self loadData];
    
    
    __weak typeof(self) weakself = self;
    
    [_collectionView setHandleDidSelectedLive:^(LiveListPartitionLiveEntity *live) {
        [LivePlayer playLiveWithURL:[NSURL URLWithString:live.playurl] title:live.title inController:weakself];
    }];
    [_collectionView setOnClickBannerItem:^(LiveListBannerEntity *banner) {
        [URLRouter openURL:banner.link];
    }];
    
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)collectionViewRefreshing:(__kindof RefreshCollectionView *)collectionView {
    [self loadData];
}

- (void)loadData {
    if (!_model) {
        _model = [[LiveListModel alloc] init];
    }
    
    [_model getLiveListWithSuccess:^{
        _collectionView.refreshing = NO;
        _collectionView.liveList = _model.liveList;
    } failure:^(NSString *errorMsg) {
        //
    }];
}

- (void)loadSubviews {
    _collectionView = [[LiveCollectionView alloc] init];
    _collectionView.refreshDelegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
