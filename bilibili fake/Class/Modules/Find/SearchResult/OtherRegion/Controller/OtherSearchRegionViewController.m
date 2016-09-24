//
//  OtherSearchRegionViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "OtherSearchRegionViewController.h"
#import "OtherSearchRegionModel.h"

#import "VideoViewController.h"
#import "SeasonSummaryCell.h"
#import "UPUserSummaryCell.h"
#import "MovieSummaryCell.h"
#import "SpecialSummaryCell.h"
#import "UserInfoViewController.h"
#import "BangumiInfoViewController.h"

@interface OtherSearchRegionViewController()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation OtherSearchRegionViewController{
    OtherSearchRegionModel* model;
    BOOL isLoadfinish;
    UICollectionView* searchResultCollectionView;
}

-(instancetype)initWithType:(NSInteger)type keyword:(NSString*)keyword{
    if (self = [super init]) {
        model = [[OtherSearchRegionModel alloc] init];
        model.keyword = keyword;
        model.type = type;
        
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
            [searchResultCollectionView reloadData];
        });
    } failure:^(NSString *errorMsg) {
        isLoadfinish = YES;
        NSLog(@"%@",errorMsg);
    }];
}

-(void)loadActions{
    searchResultCollectionView.delegate = self;
}
#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (model.type) {
        case 1:
            [self.navigationController pushViewController:[[BangumiInfoViewController alloc] initWithID:[((SeasonSummaryEntity*)model.searchResultArr[indexPath.row]).param integerValue]]animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[UserInfoViewController alloc] initWithMid:[((UPUserSummaryEntity*)model.searchResultArr[indexPath.row]).param integerValue]] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:[((MovieSummaryEntity*)model.searchResultArr[indexPath.row]).param integerValue]] animated:YES];
            break;
        case 4:
            break;
        default:
            break;
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - scrollView.frame.size.height) {
        if (isLoadfinish) {
            isLoadfinish = NO;
            [model getMoreSearchResultWithSuccess:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [searchResultCollectionView reloadData];
                    isLoadfinish = YES;
                });
            } failure:^(NSString *errorMsg) {
                NSLog(@"%@",errorMsg);
                isLoadfinish = YES;
            }];
        }
    }
}

#pragma UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return model.searchResultArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (model.type == 1) {
        SeasonSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SeasonSummaryCell" forIndexPath:indexPath];
        cell.entity = model.searchResultArr[indexPath.row];
        return cell;
    }else if (model.type == 2) {
        UPUserSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UPUserSummaryCell" forIndexPath:indexPath];
        cell.entity = model.searchResultArr[indexPath.row];
        return cell;
    }else if (model.type == 3) {
        MovieSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieSummaryCell" forIndexPath:indexPath];
        cell.entity = model.searchResultArr[indexPath.row];
        return cell;
    }else if (model.type == 4) {
        SpecialSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpecialSummaryCell" forIndexPath:indexPath];
        cell.entity = model.searchResultArr[indexPath.row];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (model.type) {
        case 1:
            return CGSizeMake(SSize.width, [SeasonSummaryCell height]);
            break;
        case 2:
            return CGSizeMake(SSize.width,[UPUserSummaryCell height]);
            break;
        case 3:
            return CGSizeMake(SSize.width,[MovieSummaryCell height]);
            break;
        case 4:
            return CGSizeMake(SSize.width,[SpecialSummaryCell height]);
            break;
        default:
            break;
    }
    return (CGSize){SSize.width,70};
}


#pragma loadSubViews
-(void)loadSubViews{
    
    
    searchResultCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSize.width, 70);
        layout.minimumLineSpacing = 0;
        layout.footerReferenceSize= CGSizeZero;
        UICollectionView* view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        view.dataSource = self;
        view.backgroundColor = ColorRGBA(243, 243, 243, 0);
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        [view registerClass:[SeasonSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([SeasonSummaryCell class])];
        [view registerClass:[UPUserSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([UPUserSummaryCell class])];
        [view registerClass:[MovieSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([MovieSummaryCell class])];
        [view registerClass:[SpecialSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([SpecialSummaryCell class])];
        [self.view addSubview:view];
        view;
    });
    

    
    //layout
    [searchResultCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
    }];
    

}
@end
