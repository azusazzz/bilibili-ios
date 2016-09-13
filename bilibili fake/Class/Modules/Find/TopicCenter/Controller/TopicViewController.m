//
//  TopicViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "TopicViewController.h"

#import "RefreshCollectionView.h"

#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "Macro.h"

#import "TopicCenterModel.h"
#import "TopicCell.h"
#import "URLRouter.h"

@interface TopicViewController()<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,RefreshCollectionViewDelegate>


@end

@implementation TopicViewController{
    RefreshCollectionView* topicCollectionView;
    TopicCenterModel* model;
     BOOL isLoadfinish;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"话题中心";
        
        model = [[TopicCenterModel alloc] init];
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
    [model getTopicArrWithSuccess:^{
        isLoadfinish = YES;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [topicCollectionView reloadData];
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
     [URLRouter openURL: model.topicArr[indexPath.row].link];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - scrollView.frame.size.height) {
        if (isLoadfinish) {
            isLoadfinish = NO;
            [model getMoreTopicArrWithSuccess:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [topicCollectionView reloadData];
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
    return model.topicArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TopicCell class]) forIndexPath:indexPath];
    cell.entity = model.topicArr[indexPath.row];
    //cell.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
    return cell;
}


#pragma loadSubviews
-(void)loadSubviews{
    topicCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSize.width-20, [TopicCell height]);
        layout.minimumLineSpacing = 10;
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        RefreshCollectionView* col =  [[RefreshCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
         col.refreshDelegate = self;
        col.delegate = self;
        col.dataSource = self;
        col.refreshDelegate = self;
        col.backgroundColor = ColorRGBA(243, 243, 243, 0);
        //col.layer.cornerRadius = 5.0;
        
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorRGB(243, 243, 243);
        col.backgroundView = view;
        col.showsVerticalScrollIndicator = NO;
        [col registerClass:[TopicCell class] forCellWithReuseIdentifier:NSStringFromClass([TopicCell class])];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:col];
        col;
    });
    
    
    //layout
    [topicCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
    
}
@end
