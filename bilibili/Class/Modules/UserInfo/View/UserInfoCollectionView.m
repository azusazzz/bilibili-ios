//
//  UserInfoSubmitVideosView.m
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//
#import "UserInfoCollectionView.h"

#import "SubmitAndCoinVideoCell.h"
#import "FavoritesCell.h"
#import "UserInfoHeaderReusableView.h"
#import "UBangumiCell.h"
#import "UGameCell.h"

@implementation UserInfoCollectionView
-(instancetype)init{
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(SSize.width-20, 30);
    layout.footerReferenceSize = CGSizeZero;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
   
    if ( self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[SubmitAndCoinVideoCell class] forCellWithReuseIdentifier:NSStringFromClass([SubmitAndCoinVideoCell class])];
        [self registerClass:[FavoritesCell class] forCellWithReuseIdentifier:NSStringFromClass([FavoritesCell class])];
        [self registerClass:[UBangumiCell class] forCellWithReuseIdentifier:NSStringFromClass([UBangumiCell class])];
        [self registerClass:[UGameCell class] forCellWithReuseIdentifier:NSStringFromClass([UGameCell class])];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
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

-(void)setFavoritesEntityArr:(NSMutableArray<UserInfoFavoritesEntity *> *)favoritesEntityArr{
    _favoritesEntityArr = favoritesEntityArr;
    [self reloadData];
}

-(void)setBangumiEntity:(UserInfoBangumiEntity *)bangumiEntity{
    _bangumiEntity = bangumiEntity;
    [self reloadData];
}

-(void)setGameEntity:(UserInfoGameEntity *)gameEntity{
    _gameEntity = gameEntity;
    [self reloadData];
}

#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _onClickCell?_onClickCell(indexPath):NULL;
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = 0;
        height += ceil(_submitVideosEntity.vlist.count/2.0)*([SubmitAndCoinVideoCell size].height+10)+40;
        height += (_coinVideosEntity.list.count?1:0)*([SubmitAndCoinVideoCell size].height+10)+40;
        height += _favoritesEntityArr.count?(SSize.width-50)/3.0+40:40;
        height += _bangumiEntity.result.count?(SSize.width-50)/3.0*1.4+40:40;
        height += (_gameEntity.games.count<7?_gameEntity.games.count:6)*100+40;
        make.height.equalTo(@(height));
    }];
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _submitVideosEntity.vlist.count;
    }else if(section == 1){
        return _coinVideosEntity.list.count<3?_coinVideosEntity.count:2;
    }else if(section == 2){
        return _favoritesEntityArr.count<4?_favoritesEntityArr.count:3;
    }else if(section == 3){
        return _bangumiEntity.result.count<4?_bangumiEntity.result.count:3;
    } if(section == 4){
        return _gameEntity.games.count<7?_gameEntity.games.count:6;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SubmitAndCoinVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SubmitAndCoinVideoCell class]) forIndexPath:indexPath];
        cell.submitVideoEntity = _submitVideosEntity.vlist[indexPath.row];
        return cell;
    }else if(indexPath.section == 1){
        SubmitAndCoinVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SubmitAndCoinVideoCell class]) forIndexPath:indexPath];
        cell.coinVideoEntity = _coinVideosEntity.list[indexPath.row];
        return cell;
    }else if(indexPath.section == 2){
        FavoritesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FavoritesCell class]) forIndexPath:indexPath];
        cell.entity = _favoritesEntityArr[indexPath.row];
        return cell;
    }else if(indexPath.section == 3){
        UBangumiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UBangumiCell class]) forIndexPath:indexPath];
        cell.entity = _bangumiEntity.result[indexPath.row];
        return cell;
    }else if(indexPath.section == 4){
        UGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UGameCell class]) forIndexPath:indexPath];
        cell.entity = _gameEntity.games[indexPath.row];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UserInfoHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UserInfoHeaderReusableView" forIndexPath:indexPath];
        switch (indexPath.section) {
            case 0:
                [headerView setTitle:@"全部投稿" Count:_submitVideosEntity.count];
                break;
            case 1:
                [headerView setTitle:@"最近投币" Count:_coinVideosEntity.count];
                break;
            case 2:
                [headerView setTitle:@"TA的收藏夹" Count: _favoritesEntityArr.count];
                break;
            case 3:
                [headerView setTitle:@"TA追的番" Count: _bangumiEntity.result.count];
                break;
            case 4:
                [headerView setTitle:@"TA玩的游戏" Count: _gameEntity.games.count];
                break;
            default:
                break;
        }
        return headerView;
    }
    return nil;
}

//size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return   [SubmitAndCoinVideoCell size];;
    }else if (indexPath.section == 2) {
        CGFloat h = (SSize.width-50)/3.0;
        return CGSizeMake(h, h);
    }else if (indexPath.section ==3) {
        CGFloat h = (SSize.width-50)/3.0;
        return CGSizeMake(h, h*1.4);
    }else if (indexPath.section ==4) {
        return CGSizeMake(SSize.width - 20, 100);
    }
    return CGSizeZero;
}

@end
