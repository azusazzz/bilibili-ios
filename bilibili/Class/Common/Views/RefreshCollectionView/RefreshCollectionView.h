//
//  RefreshCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RefreshCollectionView;

@protocol RefreshCollectionViewDelegate <NSObject>

@optional
- (void)collectionViewRefreshing:(__kindof RefreshCollectionView *)collectionView;

@end


@interface RefreshCollectionView : UICollectionView
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (assign, nonatomic) CGFloat pullOffsetY;

@property (assign, nonatomic) CGFloat backgroundViewOffsetY;

@property (assign, nonatomic) BOOL refreshing;

@property (assign, nonatomic) id<RefreshCollectionViewDelegate> refreshDelegate;

- (instancetype)init RequiresSuper;

- (void)layoutSubviews RequiresSuper;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView RequiresSuper;

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate RequiresSuper;

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath RequiresSuper;

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath RequiresSuper;


@end
