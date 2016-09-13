//
//  GameCentreViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCenterViewController.h"
#import "RefreshCollectionView.h"

#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "Macro.h"

#import "GameCell.h"
#import "GameCenterModel.h"
#import "UIView+CornerRadius.h"

@interface GameCenterViewController()<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,RefreshCollectionViewDelegate>


@end

@implementation GameCenterViewController{
    RefreshCollectionView* gameCollectionView;
    GameCenterModel* model;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"游戏中心";
        model = [[GameCenterModel alloc] init];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    [self loadSubviews];
    [self navigationBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = UIStyleBackgroundColor;
    
    self.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIStyleForegroundColor};
    gameCollectionView.backgroundColor = UIStyleBackgroundColor;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return model.gameList.gameList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GameCell *cell = [gameCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GameCell class]) forIndexPath:indexPath];
    cell.gameEntity = model.gameList.gameList[indexPath.row];
    if (indexPath.row == 0&&indexPath.section == 0) {
       [cell cornerRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight withCornerRadius:6.0];
    }
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [URLRouter openURL: model.gameList.gameList[indexPath.row].download_link];
}

- (void)collectionViewRefreshing:(__kindof RefreshCollectionView *)collectionView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        collectionView.refreshing = NO;
    });
}

#pragma loadSubviews
-(void)loadSubviews{
    gameCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSize.width, SSize.width*0.5 + 50 + 10);
        layout.minimumLineSpacing = 10;
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        RefreshCollectionView* col =  [[RefreshCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [gameCollectionView cornerRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight withCornerRadius:10.0];
        col.delegate = self;
        col.dataSource = self;
        col.refreshDelegate = self;
        
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorRGB(243, 243, 243);
        col.backgroundView = view;
        //col.layer.masksToBounds = YES;
        col.showsVerticalScrollIndicator = NO;
        [col registerClass:[GameCell class] forCellWithReuseIdentifier:NSStringFromClass([GameCell class])];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:col];
        col;
    });
    
    [model getGameListWithSuccess:^{
        [gameCollectionView reloadData];
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    //layout
    [gameCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
    }];


}
@end
