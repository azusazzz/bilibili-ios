//
//  RegionViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionViewController.h"
#import "RegionModel.h"
#import "RegionCollectionViewCell.h"
#import "ScrollTabBarController.h"

@interface RegionViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
{
    UICollectionView *_collectionView;
}

@property (strong, nonatomic) RegionModel *model;

@end

@implementation RegionViewController

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
    
    _model = [[RegionModel alloc] init];
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


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
#define _ABS(value) ( (value) >= 0 ? (value) : -(value) )
    CGPoint translation = [gestureRecognizer translationInView:_collectionView];
    return _ABS(translation.x) > _ABS(translation.y);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_model.regions count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Region" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(RegionCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setRegion:_model.regions[indexPath.row]];
}


- (void)loadSubviews {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(16);
    titleLabel.textColor = ColorWhite(255);
    titleLabel.backgroundColor = CRed;
    titleLabel.text = self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat itemWidth = (SSize.width - 40*4) / 3;
    flowLayout.itemSize = CGSizeMake(itemWidth, [RegionCollectionViewCell heightForWidth:itemWidth]);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 40;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 40, 15, 40);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = ColorWhite(247);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[RegionCollectionViewCell class] forCellWithReuseIdentifier:@"Region"];
    _collectionView.layer.cornerRadius = 6;
    _collectionView.layer.masksToBounds = YES;
    [self.view addSubview:_collectionView];
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [_collectionView addGestureRecognizer:panGestureRecognizer];
    
    
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
}


@end
