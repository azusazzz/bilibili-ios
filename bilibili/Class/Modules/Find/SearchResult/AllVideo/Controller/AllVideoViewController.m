//
//  AllVideoViewController.m
//  bilibili fake
//
//  Created by C on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoViewController.h"

#import "Macro.h"

#import "AllVideoModel.h"
#import "SelectionView.h"

#import "ArchiveSummaryCell.h"
#import "SeasonSummaryCell.h"
#import "MovieSummaryCell.h"
#import "FindMoreReusbleView.h"

#import "VideoViewController.h"
#import "BangumiInfoViewController.h"

@interface AllVideoViewController()<UICollectionViewDelegate,UICollectionViewDataSource,SelectionDelegate>

@end

@implementation AllVideoViewController{
    SelectionView* selectionView;
    UICollectionView* videoCollectionView;
   
    AllVideoModel* model;
    BOOL isLoadfinish;
}
-(instancetype)initWithKeyword:(NSString *)keyword{
    if (self = [super init]) {
        model = [[AllVideoModel alloc] init];
        model.keyword = keyword;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)viewDidLoad{
    [self loadSubViews];
    [self loadActions];
    
    isLoadfinish = NO;
    [model getSearchResultWithSuccess:^{
        isLoadfinish = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [videoCollectionView reloadData];
        });
    } failure:^(NSString *errorMsg) {
        isLoadfinish = YES;
        NSLog(@"%@",errorMsg);
    }];
}

-(void)loadActions{
    videoCollectionView.delegate = self;
    selectionView.delegate = self;
}

#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
         [self.navigationController pushViewController:[[BangumiInfoViewController alloc] initWithID:[model.seasonArr[indexPath.row].param integerValue]] animated:YES];
    }else if (indexPath.section == 1) {
        [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:[model.movieArr[indexPath.row].param integerValue]]animated:YES];
    }else if (indexPath.section == 2) {
        [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:[model.archiveArr[indexPath.row].param integerValue]]animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - scrollView.frame.size.height) {
        if (isLoadfinish) {
            isLoadfinish = NO;
            [model getMoreSearchResultWithSuccess:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [videoCollectionView reloadData];
                    isLoadfinish = YES;
                });
            } failure:^(NSString *errorMsg) {
                NSLog(@"%@",errorMsg);
                isLoadfinish = YES;
            }];
        }
    }
}
-(void)findMoreMovie{
    if (_delegate)[_delegate findMoreMovie];
}

-(void)findMoreSeason{
    if (_delegate)[_delegate findMoreSeason];
}
#pragma UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)return model.seasonArr.count;
    if (section == 1) return  model.movieArr.count;
    return model.archiveArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SeasonSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SeasonSummaryCell" forIndexPath:indexPath];
        cell.entity = model.seasonArr[indexPath.row];
        return cell;
    }else if (indexPath.section == 1) {
        MovieSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieSummaryCell" forIndexPath:indexPath];
        cell.entity = model.movieArr[indexPath.row];
        return cell;
    }else if (indexPath.section == 2) {
        ArchiveSummaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArchiveSummaryCell" forIndexPath:indexPath];
        cell.orderType = [selectionView.selectedIndex[0] integerValue];
        cell.entity = model.archiveArr[indexPath.row];
        return cell;
    }

    return nil;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    
    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        FindMoreReusbleView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FindMoreReusbleView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            if (model.seasonCount<=3) return nil;
            else{
                [footerView.moreBtn setTitle:[NSString stringWithFormat:@"更多番剧（%lu）",model.seasonCount] forState:UIControlStateNormal];
                [footerView.moreBtn addTarget:self action:@selector(findMoreSeason) forControlEvents:UIControlEventTouchUpInside];
                return footerView;
            }
        } else if(indexPath.section == 1){
            if (model.movieCount<=3) return nil;
            else{
                [footerView.moreBtn setTitle:[NSString stringWithFormat:@"更多影视（%lu）",model.seasonCount] forState:UIControlStateNormal];
                [footerView.moreBtn addTarget:self action:@selector(findMoreMovie) forControlEvents:UIControlEventTouchUpInside];
                return footerView;
            }
        }else if (indexPath.section == 2) {
            return nil;
        }

    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (CGSize){SSize.width,[SeasonSummaryCell height]};
    }else if (indexPath.section == 1) {
        return (CGSize){SSize.width,[MovieSummaryCell height]};
    }else if (indexPath.section == 2) {
        return (CGSize){SSize.width,[ArchiveSummaryCell height]};
    }
    return (CGSize){SSize.width,70};
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (model.seasonCount<=3) return CGSizeZero;
    } else if(section == 1){
        if (model.movieCount<=3) return CGSizeZero;
        
    }else if (section == 2) {
        return CGSizeZero;
    }
    return (CGSize){SSize.width,42};
}
#pragma SelectionDelegate
-(void)selectedIndexDidChange{
    model.order = [selectionView.selectedIndex[0] integerValue];
    model.duration = [selectionView.selectedIndex[1] integerValue];
    model.ridName = selectionView.itemArrArr[2][[selectionView.selectedIndex[2] integerValue]];
    
    [model getSearchResultWithSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [videoCollectionView reloadData];
        });
    } failure:^(NSString *errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [videoCollectionView reloadData];
        });
        NSLog(@"%@",errorMsg);
    }];
}
#pragma loadSubViews
-(void)loadSubViews{

    
    videoCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSize.width, 70);
        layout.minimumLineSpacing = 0;
        UICollectionView* view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        view.dataSource = self;
        view.backgroundColor = ColorRGBA(243, 243, 243, 0);
        [view registerClass:[ArchiveSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([ArchiveSummaryCell class])];
        [view registerClass:[SeasonSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([SeasonSummaryCell class])];
        [view registerClass:[MovieSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([MovieSummaryCell class])];
        [view registerClass:[FindMoreReusbleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([FindMoreReusbleView class])];
        [self.view addSubview:view];
        view;
    });
    
    selectionView = ({
        SelectionView* view = [[SelectionView alloc] init];
        [self.view addSubview:view];
        view;
    });
    
    //layout
    [videoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
    
    [selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(selectionView.backgroundView.mas_bottom);
    }];
}
@end
