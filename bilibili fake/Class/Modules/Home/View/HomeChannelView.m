//
//  HomeChannelView.m
//  bilibili fake
//
//  Created by cezr on 16/6/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeChannelView.h"
#import "HomeChannelRequest.h"
#import "HomeChannelModel.h"
#import "HomeChannelCollectionViewCell.h"


#define ReuseIdentifier @"ChannelCell"

@interface HomeChannelView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    
    HomeChannelModel *_model;
    
    UICollectionViewFlowLayout *_flowLayout;
    
    UICollectionView *_collectionView;
    
}

@end

@implementation HomeChannelView

- (instancetype)init; {
    if (self = [super init]) {
        self.backgroundColor = ColorWhite(240);
        
        _model = [[HomeChannelModel alloc] init];
        [_model getChannelDataWithSuccess:^{
            [self loadSubviews];
        } failure:^(NSString *errorMsg) {
            NSLog(@"%@", errorMsg);
        }];
    }
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _model.entitys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(HomeChannelCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath; {
    [cell setChannelEntity:_model.entitys[indexPath.row]];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return CGSizeMake(collectionView.bounds.size.width / 3, collectionView.bounds.size.width / 3);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section; {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section; {
    return 0;
}

#pragma mark - Subviews

- (void)loadSubviews; {
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = ColorWhite(240);
    [_collectionView registerClass:[HomeChannelCollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

@end
