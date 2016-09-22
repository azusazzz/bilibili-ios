//
//  BangumiInfoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoViewController.h"
#import "BangumiInfoModel.h"
#import "BangumiInfoCollectionView.h"

#import "UIViewController+HeaderView.h"
#import "UINavigationBar+BackgroundColor.h"
#import "UIViewController+PopGesture.h"
#import <ReactiveCocoa.h>


#import "VideoViewController.h" // 视频信息

@interface BangumiInfoViewController ()
<UIGestureRecognizerDelegate>

@property (assign, nonatomic) NSInteger ID;

@property (strong, nonatomic) BangumiInfoModel *model;

@property (strong, nonatomic) BangumiInfoCollectionView *collectionView;

@end

@implementation BangumiInfoViewController

- (instancetype)initWithID:(NSInteger)ID {
    if (self = [super init]) {
        _ID = ID;
        _model = [[BangumiInfoModel alloc] initWithID:ID];
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"番剧详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationBar.backgroundColor = ColorWhiteAlpha(255, 0);
    self.navigationBar.hiddenBottomLine = YES;
    
    _collectionView = [[BangumiInfoCollectionView alloc] init];
    [self.view insertSubview:_collectionView belowSubview:self.navigationBar];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [_collectionView addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    
    RAC(self.collectionView, bangumiInfo) = RACObserve(self.model, bangumiInfo);
    
    [_model getBangumiInfoWithSuccess:^{
        //
    } failure:^(NSString *errorMsg) {
        //
    }];
    
    __weak typeof(self) weakself = self;
    [_collectionView setSelBangumiEpisode:^(BangumiEpisodeEntity *bangumiEpisode) {
        [weakself.navigationController pushViewController:[[VideoViewController alloc] initWithAid:bangumiEpisode.av_id] animated:YES];
    }];
    
    [_collectionView setSelBangumiProfile:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_collectionView];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}

@end
