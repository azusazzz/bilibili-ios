//
//  HomeRecommendView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendView.h"
#import "HomeRecommendModel.h"

#import "HomeRecommendHeaderView.h"
#import "HomeRecommendFooterView.h"

#import "HomeRecommendCollectionViewCell.h"
#import "HomeRecommendAvCollectionViewCell.h"



#import "VideoViewController.h"
#import "UIViewController+GetViewController.h"


@interface HomeRecommendView ()
//<UITableViewDataSource, UITableViewDelegate>
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) HomeRecommendModel *model;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation HomeRecommendView

- (instancetype)init; {
    if (self = [super init]) {
        self.backgroundColor = ColorWhite(247);
        
        
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableView.backgroundColor = ColorWhite(247);
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        [_tableView registerClass:[HomeRecommendBodyItemTableViewCell class] forCellReuseIdentifier:@"Recommend"];
//        [_tableView registerClass:[HomeRecommendHeaderView class] forHeaderFooterViewReuseIdentifier:@"Header"];
//        [_tableView registerClass:[HomeRecommendFooterView class] forHeaderFooterViewReuseIdentifier:@"Footer"];
//        [self addSubview:_tableView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = ColorWhite(247);
        [_collectionView registerClass:[HomeRecommendHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [_collectionView registerClass:[HomeRecommendFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
        [_collectionView registerClass:[HomeRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"Recommend"];
        [_collectionView registerClass:[HomeRecommendAvCollectionViewCell class] forCellWithReuseIdentifier:@"RecommendAv"];
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        _model = [[HomeRecommendModel alloc] init];
        [_model getRecommendListWithSuccess:^{
            //
            [_collectionView reloadData];
        } failure:^(NSString *errorMsg) {
            //
            HUDFailure(errorMsg);
        }];
        
    }
    return self;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeRecommendBodyEntity *body = _model.recommendList[indexPath.section].body[indexPath.row];
    if ([body._goto isEqualToString:@"av"]) {
        NSInteger aid = [body.param integerValue];
        [UIViewController.currentNavigationViewController pushViewController:[[VideoViewController alloc] initWithAid:aid] animated:YES];
    }
    
}


#pragma mark - UICollectionViewDataSource

/**
 *  Number
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_model.recommendList count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_model.recommendList[section].body count];
}
/**
 *  Size
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SSize.width, [HomeRecommendHeaderView heightForRecommend:_model.recommendList[section] width:SSize.width]);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SSize.width, [HomeRecommendFooterView heightForBanner:_model.recommendList[section].banner_bottom width:SSize.width]);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SSize.width-15*3) / 2;
    return CGSizeMake(width, [HomeRecommendCollectionViewCell heightForWidth:width]);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
/**
 *  Cell
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
    }
    else {
        return NULL;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_model.recommendList[indexPath.section].body[indexPath.row]._goto isEqualToString:@"av"]) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendAv" forIndexPath:indexPath];
    }
    else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Recommend" forIndexPath:indexPath];
    }
}
/**
 *  Data
 */
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        ((HomeRecommendHeaderView *)view).recommend = _model.recommendList[indexPath.section];
    }
    else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
//        view.backgroundColor = [UIColor greenColor];
        ((HomeRecommendFooterView *)view).banner = _model.recommendList[indexPath.section].banner_bottom;
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(HomeRecommendCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.body = _model.recommendList[indexPath.section].body[indexPath.row];
}




/*
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_model.recommendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"Recommend"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor grayColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
*/



@end
