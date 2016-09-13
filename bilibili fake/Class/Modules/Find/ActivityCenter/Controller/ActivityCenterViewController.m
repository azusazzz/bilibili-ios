//
//  ActivityCenterViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ActivityCenterViewController.h"

#import "RefreshCollectionView.h"

#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "Macro.h"

#import "ActivityCenterModel.h"
#import "ActivityCell.h"
#import "URLRouter.h"

@interface ActivityCenterViewController()<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,RefreshCollectionViewDelegate>


@end

@implementation ActivityCenterViewController{
    RefreshCollectionView* activityCollectionView;
    ActivityCenterModel* model;
    BOOL isLoadfinish;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"活动中心";
        
        model = [[ActivityCenterModel alloc] init];
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
    
    
    isLoadfinish = NO;
    [model getActivityArrWithSuccess:^{
        isLoadfinish = YES;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [activityCollectionView reloadData];
        }];
    } failure:^(NSString *errorMsg) {
        isLoadfinish = YES;
        NSLog(@"%@",errorMsg);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = UIStyleBackgroundColor;
    
    self.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIStyleForegroundColor};
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}
#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
       [URLRouter openURL: model.activityArr[indexPath.row].link];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - scrollView.frame.size.height) {
        if (isLoadfinish) {
            isLoadfinish = NO;
            [model getMoreActivityArrWithSuccess:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [activityCollectionView reloadData];
                    isLoadfinish = YES;
                });
            } failure:^(NSString *errorMsg) {
                NSLog(@"%@",errorMsg);
                isLoadfinish = YES;
            }];
        }
    }
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return model.activityArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ActivityCell class]) forIndexPath:indexPath];
    //cell.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
    cell.entity = model.activityArr[indexPath.row];
    return cell;
}


- (void)collectionViewRefreshing:(__kindof RefreshCollectionView *)collectionView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        collectionView.refreshing = NO;
    });
}

#pragma loadSubviews
-(void)loadSubviews{
    activityCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSize.width-20, [ActivityCell height]);
        layout.minimumLineSpacing = 10;
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        RefreshCollectionView* col =  [[RefreshCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        col.delegate = self;
        col.dataSource = self;
        col.refreshDelegate = self;
        col.backgroundColor = ColorRGBA(243, 243, 243, 0);
        //col.layer.cornerRadius = 5.0;
        
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorRGB(243, 243, 243);
        col.backgroundView = view;
        col.showsVerticalScrollIndicator = NO;
        [col registerClass:[ActivityCell class] forCellWithReuseIdentifier:NSStringFromClass([ActivityCell class])];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:col];
        col;
    });
    
    
    //layout
    [activityCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
    
}

@end
