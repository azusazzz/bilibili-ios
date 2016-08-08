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

@interface BangumiListViewController ()

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
    
}


- (void)loadData {
    _model = [[BangumiListModel alloc] init];
    
    [_model getBangumiListWithSuccess:^{
        //
        _collectionView.bangumiList = _model.bangumiList;
    } failure:^(NSString *errorMsg) {
        //
        
    }];
}

- (void)loadSubviews {
    _collectionView = [[BangumiCollectionView alloc] init];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
