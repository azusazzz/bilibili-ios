//
//  RegionListViewController.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionListViewController.h"
#import "RegionListModel.h"
#import "RegionCollectionViewCell.h"

#import "RegionShowViewController.h"

#import "ScrollTabBarController.h"
#import "URLRouter.h"

@interface RegionListViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) RegionListModel *model;

@end

@implementation RegionListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_category_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_category_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = CRed;
    
    [self loadSubviews];
    
    _model = [[RegionListModel alloc] init];
    [_model getRegionListWithSuccess:^{
        //
        [_collectionView reloadData];
    } failure:^(NSString *errorMsg) {
        //
        HUDFailure(errorMsg);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}


- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RegionEntity *region = _model.list[indexPath.row];
    if ([region.param length]) {
        [URLRouter openURL:region.param];
    }
    else {
        NSLog(@"%@", region.name);
        [self.navigationController pushViewController:[[RegionShowViewController alloc] initWithRegion:region] animated:YES];
    }
}


#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_collectionView];
    return fabs(translation.x) > fabs(translation.y);
}


#pragma mark Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_model.list count];
}

#pragma mark Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Region" forIndexPath:indexPath];
}

#pragma  mark Data
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(RegionCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setRegion:_model.list[indexPath.row]];
}

#pragma mark Subviews
- (void)loadSubviews {
    UILabel *titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = Font(16);
        label.textColor = ColorWhite(255);
        label.backgroundColor = CRed;
        label.text = @"分区";
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        label;
    });
    
    _collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat itemWidth = (SSize.width - 40*4) / 3;
        flowLayout.itemSize = CGSizeMake(itemWidth, [RegionCollectionViewCell heightForWidth:itemWidth]);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 39;
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 40, 15, 40);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = ColorWhite(247);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[RegionCollectionViewCell class] forCellWithReuseIdentifier:@"Region"];
        collectionView.layer.cornerRadius = 6;
        collectionView.layer.masksToBounds = YES;
        [self.view addSubview:collectionView];
        collectionView;
    });
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 20;
        make.height.offset = 44;
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(titleLabel.mas_bottom);
        make.bottom.offset = 3;
    }];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [_collectionView addGestureRecognizer:panGestureRecognizer];
}


@end
