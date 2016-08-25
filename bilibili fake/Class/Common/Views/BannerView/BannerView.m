//
//  BannerView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BannerView.h"
#import <UIImageView+WebCache.h>

@interface BannerItem : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation BannerItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end




@interface BannerView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSTimer *_scrollTimer;
    UIPageControl *_pageControl;
}

@property (assign, nonatomic) NSInteger index;

@end

@implementation BannerView

- (instancetype)init {
    if (self = [super init]) {
        _scrollTimeInterval = 4;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BannerItem class] forCellWithReuseIdentifier:@"Banner"];
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = CRed;
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset = -5;
            make.right.offset = -15;
            make.height.offset = 14;
            make.width.offset = 0;
        }];
    }
    return self;
}

- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = NULL;
    }
    if (scrollTimeInterval > 0 && _urls.count > 1) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:_scrollTimeInterval target:self selector:@selector(scroll) userInfo:NULL repeats:YES];
    }
}

- (void)scroll {
    NSInteger scrollIndex = _index + 1;
    if (_index == _urls.count - 1) {
        scrollIndex = 0;
    }
    [_collectionView setContentOffset:CGPointMake(_collectionView.width * scrollIndex, 0) animated:YES];
}


- (void)setUrls:(NSArray<NSURL *> *)urls {
    if ([urls count] <= 1) {
        _urls = [urls copy];
        _collectionView.bounces = NO;
        [_collectionView reloadData];
        [_scrollTimer invalidate];
        [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 0;
        }];
    }
    else {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:urls.count+2];
        [array addObject:urls.lastObject];
        [array addObjectsFromArray:urls];
        [array addObject:urls.firstObject];
        _urls = [array copy];
        _collectionView.bounces = YES;
        [_collectionView reloadData];
        
        [self layoutIfNeeded];
        [_collectionView layoutIfNeeded];
        [_collectionView setContentOffset:CGPointMake(_collectionView.width, 0)];
        self.index = 1;
        [self setScrollTimeInterval:_scrollTimeInterval];
        
        _pageControl.numberOfPages = urls.count;
        [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset = [_pageControl sizeForNumberOfPages:urls.count].width;
        }];
    }
    
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate / UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_urls count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SSize.width, self.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Banner" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(BannerItem *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell.imageView sd_setImageWithURL:_urls[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if ([_urls count] > 1) {
        if (index == 0) {
            index = [_urls count] - 2 - 1;
        }
        else if (index == [_urls count] -1) {
            index = 0;
        }
        else {
            index -= 1;
        }
    }
    
    !_onClickBannerItem ?: _onClickBannerItem(_index - 1);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_scrollTimer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.index = scrollView.contentOffset.x / scrollView.width;
    if (_index == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * (_urls.count - 2), 0) animated:NO];
        self.index = _urls.count - 2;
    }
    else if (_index == _urls.count-1) {
        [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:NO];
        self.index = 1;
    }
    [self setScrollTimeInterval:_scrollTimeInterval];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.index = scrollView.contentOffset.x / scrollView.width;
    if (_index == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * (_urls.count - 2), 0) animated:NO];
        self.index = _urls.count - 2;
    }
    else if (_index == _urls.count-1) {
        [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:NO];
        self.index = 1;
    }
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if (_index == 0 || _index == _urls.count-1) {
        return;
    }
    _pageControl.currentPage = _index - 1;
    
}

@end
