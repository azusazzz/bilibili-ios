//
//  BangumiListViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiListViewController.h"
#import "BangumiListModel.h"
#import "BangumiCollectionView.h"

#import "URLRouter.h"

#import "WebViewController.h"


#import "BangumiInfoViewController.h" // 番剧详情

@interface BangumiListViewController ()
<RefreshCollectionViewDelegate>

@property (strong, nonatomic) BangumiListModel *model;

@property (strong, nonatomic) BangumiCollectionView *collectionView;

@end

@implementation BangumiListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"番剧";
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
    [_collectionView setOnClickBannerItem:^(BangumiBannerEntity *banner) {
        [URLRouter openURL:banner.link];
    }];
    [_collectionView setHandleDidSelectedBangumi:^(BangumiEntity *bangumi) {
//        NSString *URL = [NSString stringWithFormat:@"http://bangumi.bilibili.com/mobile/anime/%ld", bangumi.season_id];
//        WebViewController *controller = [[WebViewController alloc] initWithURL:URL];
//        [weakself.navigationController pushViewController:controller animated:YES];
        [weakself.navigationController pushViewController:[[BangumiInfoViewController alloc] initWithID:bangumi.season_id] animated:YES];
    }];
    [_collectionView setHandleDidSelectedRecommend:^(BangumiRecommendEntity *recommend) {
        [URLRouter openURL:recommend.link];
//        WebViewController *controller = [[WebViewController alloc] initWithURL:recommend.link];
//        [weakself.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark - RefreshCollectionViewDelegate
- (void)collectionViewRefreshing:(__kindof RefreshCollectionView *)collectionView {
    [self loadData];
}


- (void)loadData {
    if (!_model) {
        _model = [[BangumiListModel alloc] init];
    }
    
    [_model getBangumiListWithSuccess:^{
        //
        _collectionView.refreshing = NO;
        _collectionView.bangumiList = _model.bangumiList;
    } failure:^(NSString *errorMsg) {
        //
        
    }];
}

- (void)loadSubviews {
    _collectionView = [[BangumiCollectionView alloc] init];
    _collectionView.refreshDelegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



@end
