//
//  RegionShowViewController.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowViewController.h"
#import "UIViewController+HeaderView.h"
#import "UIViewController+PopGesture.h"

#import "RegionShowTabBar.h"    // 头部标签栏

#import "RegionShowRecommendViewController.h"   // 推荐
#import "RegionShowChildViewController.h"       // 子模块

@interface RegionShowViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) RegionEntity *region;

@property (strong, nonatomic) RegionShowTabBar *headerView;

@property (strong, nonatomic) RegionShowRecommendViewController *recommendViewController;

@property (strong, nonatomic) NSArray<RegionShowChildViewController *> *childrens;

@end

@implementation RegionShowViewController

- (instancetype)initWithRegion:(RegionEntity *)region
{
    self = [super init];
    if (self) {
        self.title = region.name;
        self.hidesBottomBarWhenPushed = YES;
        _region = region;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSubviews];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.collectionView];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    if (self.collectionView.contentOffset.x > 0) {
        CGPoint location = [gestureRecognizer locationInView:self.collectionView];
        location.x -= (NSInteger)(location.x / self.collectionView.width) * self.collectionView.width;
        if (location.x < 40) {
            return YES;
        }
        else {
            return NO;
        }
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _headerView.contentOffset = scrollView.contentOffset.x / self.view.width;
}

#pragma mark - Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_region.children count] + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - Cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = ColorRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    NSLog(@"%ld", indexPath.row);
    UIView *contentView;
    if (indexPath.row == 0) {
        [self addChildViewController:_recommendViewController];
        contentView = _recommendViewController.view;
    }
    else {
        [self addChildViewController:_childrens[indexPath.row - 1]];
        contentView = _childrens[indexPath.row - 1].view;
    }
    [cell.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset = 0;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    if (indexPath.row == 0) {
        [_recommendViewController.view removeFromSuperview];
        [_recommendViewController removeFromParentViewController];
    }
    else {
        [_childrens[indexPath.row - 1].view removeFromSuperview];
        [_childrens[indexPath.row - 1] removeFromParentViewController];
    }
}

- (void)loadSubviews {
    self.view.backgroundColor = CRed;
    
    self.navigationItem.rightBarButtonItem = ({
        UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [sortButton setTitle:@"排序" forState:UIControlStateNormal];
        [sortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sortButton.frame = CGRectMake(0, 0, 30, 44);
        [[UIBarButtonItem alloc] initWithCustomView:sortButton];
    });
    
    [self navigationBar];
    
    NSMutableArray<NSString *> *titles = [NSMutableArray arrayWithCapacity:_region.children.count+1];
    [titles addObject:@"推荐"];
    for (RegionChildEntity *child in _region.children) {
        [titles addObject:child.name];
    }
    // Header
    _headerView = [[RegionShowTabBar alloc] initWithTitles:titles];
    [self.view addSubview:_headerView];
    
    _collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = ColorWhite(247);
        collectionView.pagingEnabled = YES;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        collectionView;
    });
    [self.view addSubview:_collectionView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.navigationBar.mas_bottom);
        make.height.equalTo(@(44));
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    _recommendViewController = [[RegionShowRecommendViewController alloc] initWithTid:_region.tid];
    NSMutableArray *childrens = [NSMutableArray arrayWithCapacity:_region.children.count];
    for (NSInteger idx=0; idx<_region.children.count; idx++) {
        [childrens addObject:[[RegionShowChildViewController alloc] initWithRid:_region.children[idx].tid]];
    }
    _childrens = [childrens copy];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    panGesture.delegate = self;
    [self.collectionView addGestureRecognizer:panGesture];
    [self replacingPopGestureRecognizer:panGesture];
}


@end
