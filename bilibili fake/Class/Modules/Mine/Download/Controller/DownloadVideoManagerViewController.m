//
//  DownloadVideoManagerViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoManagerViewController.h"
#import "UIViewController+HeaderView.h"
#import "DownloadVideoCollectionView.h"
#import "DownloadVideoModel.h"

#import "DownloadVideoInfoViewController.h"

@interface DownloadVideoManagerViewController ()
<UIGestureRecognizerDelegate>
{
    DownloadVideoCollectionView *_collectionView;
    DownloadVideoModel *_model;
}
@end

@implementation DownloadVideoManagerViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"离线管理";
    self.view.backgroundColor = CRed;
    
    [self loadSubviews];
    
    [self loadData];
    
    __weak typeof(self) weakself = self;
    [_collectionView setSelectedVideo:^(DownloadVideoEntity *video) {
        [weakself.navigationController pushViewController:[[DownloadVideoInfoViewController alloc] initWithDownloadVideo:video] animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_collectionView reloadData];
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
    if (fabs(translation.x) <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}

- (void)loadData {
    if (!_model) {
        _model = [DownloadVideoModel sharedInstance];
    }
    
    [_model getDownlaodVideosWithSuccess:^{
        //
        _collectionView.list = _model.list;
    } failure:^(NSString *errorMsg) {
        //
    }];
    
}

- (void)loadSubviews {
    NSArray *internalTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:internalTarget action:internalAction];
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self navigationBar];
    
    _collectionView = [[DownloadVideoCollectionView alloc] init];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(self.navigationBar.mas_bottom);
        make.bottom.offset = 0;
    }];
}


@end
