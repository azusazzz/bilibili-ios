//
//  RefreshCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RefreshCollectionView.h"
#import "PullAnimationView.h"


#define PullLabelTopOffset 20.0
#define PullLabelHeight 15.0
#define PullAnimationViewHeight 40.0



@interface RefreshCollectionView ()

{
    NSMutableArray<UIView *> *_headerViews;
}

@property (assign, nonatomic) BOOL refreshing;


@property (strong, nonatomic) UILabel *pullLabel;
@property (strong, nonatomic) UILabel *refreshLabel;
@property (strong, nonatomic) PullAnimationView *pullAnimationView;

@end

@implementation RefreshCollectionView


- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = CRed;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = ColorWhite(247);
        
        _headerViews = [NSMutableArray array];
        
        _backgroundViewOffsetY = 40;
        _pullOffsetY = _backgroundViewOffsetY + 40 + 15 + 20;
        
        
        _refreshLabel = [[UILabel alloc] init];
        _refreshLabel.font = Font(10);
        _refreshLabel.textColor = ColorWhite(146);
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        
        
        _pullLabel = [[UILabel alloc] init];
        _pullLabel.font = Font(14);
        _pullLabel.textColor = ColorWhite(230);
        _pullLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pullLabel];
        
        _pullAnimationView = [[PullAnimationView alloc] init];
        [self addSubview:_pullAnimationView];
        [_pullAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.width.equalTo(self);
            make.height.offset = 50;
            make.bottom.equalTo(self.mas_top).offset = -_backgroundViewOffsetY;
        }];
        
    }
    return self;
}

- (void)setRefreshing:(BOOL)refreshing {
    if (_refreshing == refreshing) {
        return;
    }
    _refreshing = refreshing;
    if (_refreshing) {
        [self startAnimating];
    }
    else {
        [self stopAnimating];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (!_refreshing && -offsetY > _pullOffsetY) {
        self.refreshing = YES;
        [_pullAnimationView stop];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (self.dragging) {
        CGFloat progress = (-offsetY - _backgroundViewOffsetY - 45) / 20;
        if (progress < 0) {
            progress = 0;
        }
        _pullLabel.alpha = progress;
        if (-offsetY > _pullOffsetY) {
            _pullLabel.text = @"松手加载";
        }
        else {
            _pullLabel.text = @"下拉刷新";
        }
        _pullAnimationView.pullProgress = (-offsetY - _backgroundViewOffsetY) / (40 + 15 + 20) / 2;
    }
    
    for (UIView *view in [_headerViews arrayByAddingObjectsFromArray:self.visibleCells]) {
        CGFloat viewOffsetY = offsetY > -_backgroundViewOffsetY ? -offsetY : _backgroundViewOffsetY;
        view.transform = CGAffineTransformMakeTranslation(0, viewOffsetY);
    }
    
}

- (void)startAnimating {
    
    _refreshLabel.text = @"正在更新...";
    [self.backgroundView addSubview:_refreshLabel];
    
    if (-self.contentOffset.y >= _pullOffsetY) {
        _refreshLabel.frame = CGRectMake(0, _backgroundViewOffsetY-15, self.backgroundView.width, 15);
    }
    
    self.bounces = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentInset = UIEdgeInsetsMake(_backgroundViewOffsetY, 0, 0, 0);
        self.contentOffset = CGPointMake(0, -_backgroundViewOffsetY);
        _refreshLabel.frame = CGRectMake(0, _backgroundViewOffsetY-15, self.backgroundView.width, 15);
    } completion:^(BOOL finished) {
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.refreshing = NO;
    });
}

- (void)stopAnimating {
    _refreshLabel.text = @"更新完成";
    
    self.bounces = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentInset = UIEdgeInsetsZero;
        _refreshLabel.frame = CGRectMake(0, -15, self.backgroundView.width, 15);
    } completion:^(BOOL finished) {
        [_refreshLabel removeFromSuperview];
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _pullLabel.frame = CGRectMake(0, -_pullOffsetY + 20, self.width, 15);
    
    CGFloat offsetY = self.contentOffset.y;
    if (offsetY < -_backgroundViewOffsetY) {
        self.backgroundView.y = -_backgroundViewOffsetY;
    }
    
    if (!self.backgroundView.layer.mask || !CGRectEqualToRect(self.backgroundView.bounds, self.backgroundView.layer.mask.frame)) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backgroundView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.backgroundView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.backgroundView.layer.mask = maskLayer;
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.width, 100);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 0, 15, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    }
    return NULL;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor grayColor];
    [self.backgroundView addSubview:cell];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        view.backgroundColor = ColorWhite(86);
    }
    [self.backgroundView addSubview:view];
    if (view.tag == 0) {
        view.tag = 1;
        [_headerViews addObject:view];
    }
}



@end
