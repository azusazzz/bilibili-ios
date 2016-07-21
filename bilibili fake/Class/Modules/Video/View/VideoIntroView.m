//
//  VideoIntroView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroView.h"


#import "VideoIntroHeaderView.h"

#import "VideoIntroRelateCollectionViewCell.h"

@interface VideoIntroView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    
}

@property (strong, nonatomic) VideoIntroHeaderView *headerView;

@end

@implementation VideoIntroView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundColor = ColorWhite(247);
        [self registerClass:[VideoIntroRelateCollectionViewCell class] forCellWithReuseIdentifier:@"relates"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
    }
    return self;
}

//- (void)setIntroDataSource:(NSArray *)introDataSource {
//    _introDataSource = introDataSource;
//    [self reloadData];
//}

- (void)setVideoInfo:(VideoInfoEntity *)videoInfo {
    _videoInfo = videoInfo;
    [self.headerView setupVideoInfo:_videoInfo];
    [self reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollViewDelegate scrollViewDidScroll:scrollView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _videoInfo.relates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"relates" forIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    [view addSubview:self.headerView];
    self.headerView.frame = view.bounds;
    return view;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(VideoIntroRelateCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setupVideoInfo:_videoInfo.relates[indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SSize.width, self.headerView.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SSize.width, 100);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(5, 15, 5, 15);
//}

#pragma mark - get / set 

- (VideoIntroHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[VideoIntroHeaderView alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 0)];
    }
    return _headerView;
}


@end
