//
//  DownloadVideoManagerViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoManagerViewController.h"

//#import "DownloadVideoCollectionView.h"
#import "DownloadVideoTableView.h"
#import "DownloadVideoModel.h"

#import "DownloadVideoInfoViewController.h"

// Tool
#import "UIViewController+HeaderView.h"
#import "UIViewController+PopGesture.h"

@interface DownloadVideoManagerViewController ()
<UIGestureRecognizerDelegate>

@property (strong, nonatomic) DownloadVideoTableView *tableView;

@property (strong, nonatomic) DownloadVideoModel *model;

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
    [_tableView setSelectedVideo:^(DownloadVideoEntity *video) {
        [weakself.navigationController pushViewController:[[DownloadVideoInfoViewController alloc] initWithDownloadVideo:video] animated:YES];
    }];
    [_tableView setDelHistory:^(DownloadVideoEntity *video) {
        [weakself.model deleteVideoWithAid:video.aid success:^{
            weakself.tableView.list = weakself.model.list;
        } failure:^(NSString *errorMsg) {
            //
        }];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_tableView];
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
        _tableView.list = _model.list;
    } failure:^(NSString *errorMsg) {
        HUDFailureInView(errorMsg, self.view);
    }];
    
}

- (void)loadSubviews {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    
    [self navigationBar];
    
    _tableView = [[DownloadVideoTableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(self.navigationBar.mas_bottom);
        make.bottom.offset = 0;
    }];
}


@end
