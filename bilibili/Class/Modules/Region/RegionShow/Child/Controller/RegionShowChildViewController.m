//
//  RegionShowChildViewController.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowChildViewController.h"
#import "RegionShowChildModel.h"
#import "RegionShowChildCollectionView.h"
#import <ReactiveCocoa.h>

#import "VideoViewController.h" // 视频信息

@interface RegionShowChildViewController ()

@property (strong, nonatomic) RegionShowChildModel *model;

@property (strong, nonatomic) RegionShowChildCollectionView *collectionView;

@end

@implementation RegionShowChildViewController

- (instancetype)initWithRid:(NSInteger)rid {
    if (self = [super init]) {
        _model = [[RegionShowChildModel alloc] initWithRid:rid];
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
    
    _collectionView = [[RegionShowChildCollectionView alloc] init];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    RAC(self.collectionView, regionShowChild) = RACObserve(self.model, regionShowChild);
    
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
