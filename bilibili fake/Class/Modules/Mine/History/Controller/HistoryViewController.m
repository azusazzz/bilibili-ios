//
//  HistoryViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryModel.h"
#import "HistoryCollectionViewCell.h"

#import "UIViewController+HeaderView.h"
#import "UIAlertView+Block.h"

#import "VideoViewController.h" // 视频播放



@interface HistoryViewController ()
<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) HistoryModel *model;

@property (strong, nonatomic) UICollectionView *collectionView;

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
        [_collectionView reloadData];
    } failure:^(NSString *errorMsg) {
        //
        HUDFailure(errorMsg);
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
                [_collectionView reloadData];
            } failure:^(NSString *errorMsg) {
                HUDFailure(errorMsg);
            }];
        }
    }] show];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_model.list count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"History" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(HistoryCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setHistory:_model.list[indexPath.row]];
    cell.bottomLine.hidden = indexPath.row == _model.list.count-1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger aid = _model.list[indexPath.row].aid;
    [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:aid] animated:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_collectionView];
    if (fabs(translation.x) <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}

#pragma mark - Subviews

- (void)loadSubviews {
    
    self.navigationItem.title = @"历史记录";
    UIBarButtonItem *deleteBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"misc_delete"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteAllHistory)];
    self.navigationItem.rightBarButtonItem = deleteBarButton;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(SSize.width, 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[HistoryCollectionViewCell class] forCellWithReuseIdentifier:@"History"];
    _collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.top.equalTo(self.navigationBar.mas_bottom);
    }];
    
    NSArray *internalTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:internalTarget action:internalAction];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [_collectionView addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}




@end
