//
//  HistoryViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryModel.h"
#import "HistoryTableView.h"

// 页面切换
#import "VideoViewController.h" // 视频信息

// Tool
#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "UIAlertView+Block.h"


#import <ReactiveCocoa.h>


@interface HistoryViewController ()
<UIGestureRecognizerDelegate/*, UICollectionViewDelegate, UICollectionViewDataSource*/>

@property (strong, nonatomic) HistoryModel *model;

@property (strong, nonatomic) HistoryTableView *tableView;

@end

@implementation HistoryViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:UIView.new];
    self.view.backgroundColor = CRed;
    
    [self loadSubviews];
    
    _model = [[HistoryModel alloc] init];
    [_model getHistoryListWithSuccess:^{
        //
//        _tableView.list = _model.list;
    } failure:^(NSString *errorMsg) {
        //
        HUDFailure(errorMsg);
    }];
    
    
    
    RAC(self.tableView, list) = RACObserve(self.model, list);
    
    
    __weak typeof(self) weakself = self;
    [_tableView setSelHistory:^(HistoryEntity *history) {
        [weakself.navigationController pushViewController:[[VideoViewController alloc] initWithAid:history.aid] animated:YES];
    }];
    [_tableView setDelHistory:^(HistoryEntity *history) {
        [weakself.model deleteHistoryWithAid:history.aid success:^{
            //
//            weakself.tableView.list = weakself.model.list;
        } failure:^(NSString *errorMsg) {
            //
            HUDFailure(errorMsg);
        }];
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

/**
 *  清空历史记录
 */
- (void)deleteAllHistory {
    
    [[UIAlertView alertViewWithTitle:@"清空播放历史" message:@"喵，想掩盖些什么呢？" buttonTitles:@[@"取消", @"清空"] clickedButtonAtIndex:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [_model deleteAllHistoryWithSuccess:^{
                _tableView.list = @[];
            } failure:^(NSString *errorMsg) {
                HUDFailure(errorMsg);
            }];
        }
    }] show];
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_tableView];
    CGPoint location = [gestureRecognizer locationInView:_tableView];
    if (location.x > 200) {
        return NO;
    }
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}

#pragma mark - Subviews

- (void)loadSubviews {
    
    self.navigationItem.title = @"历史记录";
    UIBarButtonItem *deleteBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"misc_delete"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteAllHistory)];
    self.navigationItem.rightBarButtonItem = deleteBarButton;
    
    
    _tableView = [[HistoryTableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.top.equalTo(self.navigationBar.mas_bottom);
    }];
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [_tableView addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
}




@end
