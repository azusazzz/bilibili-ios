//
//  RegionShowRecommendViewController.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowRecommendViewController.h"
#import "RegionShowRecommendCollectionView.h"
#import "RegionShowRecommendModel.h"
#import <ReactiveCocoa.h>

#import "VideoViewController.h" // 视频信息

@interface RegionShowRecommendViewController ()

@property (strong, nonatomic) RegionShowRecommendCollectionView *collectionView;

@property (strong, nonatomic) RegionShowRecommendModel *model;

@property (assign, nonatomic) NSInteger tid;

@end

@implementation RegionShowRecommendViewController

- (instancetype)initWithTid:(NSInteger)tid {
    if (self = [super init]) {
        _tid = tid;
        _model = [[RegionShowRecommendModel alloc] initWithRid:tid];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ColorWhite(247);
    
    if (!_model) {
        return;
    }
    
    
    
    _collectionView = [[RegionShowRecommendCollectionView alloc] initWithTid:_tid];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    RAC(self.collectionView, regionShow) = RACObserve(self.model, regionShow);
    
    [self.model getRegionShowWithSuccess:^{
        //
    } failure:^(NSString *errorMsg) {
        //
    }];

    
    __weak typeof(self) weakself = self;
    
    [_collectionView setHandleDidSelectedVideo:^(RegionShowVideoEntity *video) {
        NSInteger aid = [video.param integerValue];
        [weakself.navigationController pushViewController:[[VideoViewController alloc] initWithAid:aid] animated:YES];
    }];
    
    [_collectionView setOnClickBannerItem:^(RegionShowBannerEntity *banner) {
        [URLRouter openURL:banner.uri];
    }];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


@end
