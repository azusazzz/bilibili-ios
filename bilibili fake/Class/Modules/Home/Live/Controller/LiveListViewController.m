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

@interface LiveListViewController ()

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
        [MediaPlayer livePlayerWithURL:[NSURL URLWithString:live.playurl] title:live.title inViewController:weakself];
    }];
    
    
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)loadData {
    _model = [[LiveListModel alloc] init];
    [_model getLiveListWithSuccess:^{
        _collectionView.liveList = _model.liveList;
    } failure:^(NSString *errorMsg) {
        //
    }];
}

- (void)loadSubviews {
    _collectionView = [[LiveCollectionView alloc] init];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
