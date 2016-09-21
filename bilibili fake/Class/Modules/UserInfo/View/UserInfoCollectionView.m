//
//  UserInfoSubmitVideosView.m
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCollectionView.h"
#import "SubmitAndCoinVideoCell.h"
#import "UserInfoHeaderReusableView.h"

@implementation UserInfoCollectionView
-(instancetype)init{
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [SubmitAndCoinVideoCell size];
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(SSize.width-20, 20);
    layout.footerReferenceSize = CGSizeZero;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
   
    if ( self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        self.dataSource =self;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[SubmitAndCoinVideoCell class] forCellWithReuseIdentifier:NSStringFromClass([SubmitAndCoinVideoCell class])];
        [self registerClass:[UserInfoHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UserInfoHeaderReusableView class])];
    }
    return self;
}

-(void)setSubmitVideosEntity:(UserInfoSubmitVideosEntity *)submitVideosEntity{
    _submitVideosEntity = submitVideosEntity;
    [self reloadData];
}

-(void)setCoinVideosEntity:(UserInfoCoinVideosEntity *)coinVideosEntity{
    _coinVideosEntity = coinVideosEntity;
    [self reloadData];
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = ceil(_submitVideosEntity.vlist.count/2.0)*([SubmitAndCoinVideoCell size].height+10)+30;
        height += (_coinVideosEntity.list.count?1:0)*([SubmitAndCoinVideoCell size].height+10)+30;
        make.height.equalTo(@(height));
    }];
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {

        return _submitVideosEntity.vlist.count;
    }else if(section == 1){
        return _coinVideosEntity.list.count;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SubmitAndCoinVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SubmitAndCoinVideoCell class]) forIndexPath:indexPath];
        //cell.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
        cell.submitVideoEntity = _submitVideosEntity.vlist[indexPath.row];
        return cell;
    }else if(indexPath.section == 1){
        SubmitAndCoinVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SubmitAndCoinVideoCell class]) forIndexPath:indexPath];
        cell.coinVideoEntity = _coinVideosEntity.list[indexPath.row];
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UserInfoHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UserInfoHeaderReusableView" forIndexPath:indexPath];
        //footerView.backgroundColor = ColorWhite(230);
        switch (indexPath.section) {
            case 0:
                [headerView setTitle:@"全部投稿" Count:_submitVideosEntity.count];
                break;
            case 1:
                [headerView setTitle:@"最近投币" Count:_coinVideosEntity.count];
            default:
                break;
        }
        return headerView;
    }
    return nil;
}
@end
