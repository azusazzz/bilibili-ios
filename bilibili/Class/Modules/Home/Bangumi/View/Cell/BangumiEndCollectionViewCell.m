//
//  BangumiEndCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEndCollectionViewCell.h"
#import "BangumiEndItemCollectionViewCell.h"

@interface BangumiEndCollectionViewCell ()
<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
{
    UICollectionView *_collectionView;
}
@end

@implementation BangumiEndCollectionViewCell


+ (CGFloat)heightForWidth:(CGFloat)width ends:(NSArray<BangumiEntity *> *)ends {
    if ([ends count]) {
        width = (width-30) / 3;
        return [BangumiEndItemCollectionViewCell heightForWitdh:width];
    }
    else {
        return 0;
    }
}

- (void)setEnds:(NSArray<BangumiEntity *> *)ends {
    _ends = ends;
    [_collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 0;
        CGFloat width = (self.bounds.size.width-30) / 3;
        flowLayout.itemSize = CGSizeMake(width, [BangumiEndItemCollectionViewCell heightForWitdh:width]);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = ColorWhite(247);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[BangumiEndItemCollectionViewCell class] forCellWithReuseIdentifier:@"BangumiEnd"];
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:NULL action:NULL];
        pan.delegate = self;
        [_collectionView addGestureRecognizer:pan];
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGFloat translationX = [gestureRecognizer translationInView:_collectionView].x;
    if ((_collectionView.contentOffset.x == 0 && translationX > 0) ||
        (_collectionView.contentOffset.x + _collectionView.width == _collectionView.contentSize.width && translationX < 0)) {
        _collectionView.scrollEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _collectionView.scrollEnabled = YES;
        });
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !_handleDidSelectedBangumi ?: _handleDidSelectedBangumi(_ends[indexPath.row]);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_ends count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"BangumiEnd" forIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(BangumiEndItemCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBangumi:_ends[indexPath.row]];
}

@end
