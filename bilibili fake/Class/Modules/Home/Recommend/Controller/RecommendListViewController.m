//
//  RecommendListViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendListViewController.h"
#import "RecommendCollectionView.h"
#import "RecommendListModel.h"

#import "VideoViewController.h" // 视频信息

@interface RecommendListViewController ()
<RefreshCollectionViewDelegate>
{
    RecommendCollectionView *_collectionView;
    RecommendListModel *_model;
}
@end

@implementation RecommendListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"推荐";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CRed;
    [self.view addSubview:UIView.new];
    
    _collectionView = [[RecommendCollectionView alloc] init];
    _collectionView.refreshDelegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak typeof(self) weakself = self;
    [_collectionView setHandleDidSelectedItem:^(NSIndexPath *indexPath) {
        [weakself handleDidSelectedItem:indexPath];
    }];
    
    
    [self loadData];
    
}

- (void)handleDidSelectedItem:(NSIndexPath *)indexPath {
    RecommendBodyEntity *body = _model.recommendList[indexPath.section].body[indexPath.row];
    if ([body._goto isEqualToString:@"av"]) {
        NSInteger aid = [body.param integerValue];
        [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:aid] animated:YES];
    }
}

- (void)collectionViewRefreshing:(__kindof RefreshCollectionView *)collectionView {
    [self loadData];
}

- (void)loadData {
    if (!_model) {
        _model = [[RecommendListModel alloc] init];
    }
    [_model getRecommendListWithSuccess:^{
        _collectionView.refreshing = NO;
        _collectionView.list = _model.recommendList;
    } failure:^(NSString *errorMsg) {
        HUDFailure(errorMsg);
    }];
}

@end
