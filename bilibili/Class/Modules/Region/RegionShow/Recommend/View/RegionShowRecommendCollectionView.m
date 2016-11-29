//
//  RegionShowRecommendCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowRecommendCollectionView.h"
#import "RegionShowHeaderView.h"

#import "RegionShowBannerCollectionViewCell.h"
#import "RegionShowAvCollectionViewCell.h"

@interface RegionShowRecommendCollectionView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSInteger _tid;
}
@end

@implementation RegionShowRecommendCollectionView

- (instancetype)initWithTid:(NSInteger)tid {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    if (self) {
        _tid = tid;
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = ColorWhite(247);
//        self.backgroundView.backgroundColor = ColorWhite(247);
        
        [self registerClass:[RegionShowHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self registerClass:[RegionShowBannerCollectionViewCell class] forCellWithReuseIdentifier:@"Banner"];
        [self registerClass:[RegionShowAvCollectionViewCell class] forCellWithReuseIdentifier:@"Video"];
        
    }
    return self;
}

- (void)setRegionShow:(RegionShowRecommendEntity *)regionShow {
    if (!regionShow && !_regionShow) {
        return;
    }
    _regionShow = regionShow;
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        !_handleDidSelectedVideo ?: _handleDidSelectedVideo(_regionShow.recommends[indexPath.row]);
    }
    else if (indexPath.section == 2) {
        !_handleDidSelectedVideo ?: _handleDidSelectedVideo(_regionShow.news[indexPath.row]);
    }
    else if (indexPath.section == 3) {
        !_handleDidSelectedVideo ?: _handleDidSelectedVideo(_regionShow.dynamics[indexPath.row]);
    }
}

#pragma mark - Number

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_regionShow.banners count] ? 1 : 0;
        case 1:
            return [_regionShow.recommends count];
        case 2:
            return [_regionShow.news count];
        case 3:
            return [_regionShow.dynamics count];
        default:
            return 0;
    }
}

#pragma mark - Size

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    else {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }
    else {
        return CGSizeMake(SSize.width, [RegionShowHeaderView height]);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [RegionShowBannerCollectionViewCell sizeForWidth:SSize.width];
    }
    else {
        return [RegionShowAvCollectionViewCell sizeForContentWidth:SSize.width];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 15;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 15;
    }
}

#pragma mark - Cell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    }
    else {
        return NULL;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Banner" forIndexPath:indexPath];
    }
    else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Video" forIndexPath:indexPath];
    }
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        ((RegionShowHeaderView *)view).leftTitleLabel.text = @"热门推荐";
        ((RegionShowHeaderView *)view).leftImageView.image = [UIImage imageNamed:@"hd_home_recommend"];
    }
    else if (indexPath.section == 2) {
        ((RegionShowHeaderView *)view).leftTitleLabel.text = @"最新投稿";
        ((RegionShowHeaderView *)view).leftImageView.image = [UIImage imageNamed:@"home_new_region"];
    }
    else if (indexPath.section == 3) {
        ((RegionShowHeaderView *)view).leftTitleLabel.text = @"全区动态";
        ((RegionShowHeaderView *)view).leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_region_icon_%ld", _tid]];
    }
    view.backgroundColor = ColorWhite(247);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [((RegionShowBannerCollectionViewCell *)cell) setBanners:_regionShow.banners];
        ((RegionShowBannerCollectionViewCell *)cell).onClickBannerItem = _onClickBannerItem;
    }
    else if (indexPath.section == 1) {
        [((RegionShowAvCollectionViewCell *)cell) setVideo:_regionShow.recommends[indexPath.row]];
    }
    else if (indexPath.section == 2) {
        [((RegionShowAvCollectionViewCell *)cell) setVideo:_regionShow.news[indexPath.row]];
    }
    else if (indexPath.section == 3) {
        [((RegionShowAvCollectionViewCell *)cell) setVideo:_regionShow.dynamics[indexPath.row]];
    }
}




@end
