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

@interface RecommendListViewController ()
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
    self.view.backgroundColor = ColorWhite(247);
    [self.view addSubview:UIView.new];
    
    _collectionView = [[RecommendCollectionView alloc] init];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    _model = [[RecommendListModel alloc] init];
    [_model getRecommendListWithSuccess:^{
        _collectionView.list = _model.recommendList;
    } failure:^(NSString *errorMsg) {
        HUDFailure(errorMsg);
    }];
    
}



@end
