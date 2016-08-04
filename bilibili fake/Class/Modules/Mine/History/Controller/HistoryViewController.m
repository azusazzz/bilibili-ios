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

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
    CGPoint location = [gestureRecognizer locationInView:_collectionView];
    CGPoint translation = [gestureRecognizer translationInView:_collectionView];
    if (location.x > _collectionView.bounds.size.width * 0.5) {
        return NO;
    }
    if (translation.x <= translation.y) {
        return NO;
    }
    return YES;
}

#pragma mark - Subviews

- (void)loadSubviews {
    
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
        make.top.offset = 20+44;
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
