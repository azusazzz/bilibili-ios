//
//  VideoRankViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRankViewController.h"

#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "Macro.h"
#import "UIView+Frame.h"
#import "TabBar.h"

#import "VideoRankCollectionView.h"
#import "VideoViewController.h"

@interface VideoRankViewController()<UIGestureRecognizerDelegate,UIScrollViewDelegate,UICollectionViewDelegate>

@end

@implementation VideoRankViewController{
    NSArray<NSString *>* titleArr;
    UIScrollView* videoRankScrollView;
    NSMutableArray<VideoRankCollectionView *>* videoRankViews;
    TabBar*      titleTabBar;
}
-(instancetype)initWithTitles:(NSArray<NSString *>*) titles{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        titleArr = titles;
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
    
    [self navigationBar];
    [self loadSubviews];
    [self loadActions];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = UIStyleBackgroundColor;
    
    self.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIStyleForegroundColor};

    titleTabBar.backgroundColor = UIStyleBackgroundColor;
    titleTabBar.tintColorRGB = [UIStyleMacro share].SearchResultTabBarTintColor;
    titleTabBar.selTintColorRGB = [UIStyleMacro share].SearchResultTabBarCelTintColor;
    
    [videoRankViews enumerateObjectsUsingBlock:^(VideoRankCollectionView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = UIStyleBackgroundColor;
    }];
}

-(void)loadActions{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [[videoRankViews firstObject] addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    videoRankScrollView.delegate = self;
    
    __weak UIScrollView* scrollView = videoRankScrollView;
    [titleTabBar setOnClickItem:^(NSInteger idx) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * idx, 0) animated:YES];
    }];
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:videoRankViews[collectionView.tag].model.videoRanking[indexPath.row].aid] animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    titleTabBar.contentOffset = scrollView.contentOffset.x / scrollView.width;
}
#pragma loadSubviews
-(void)loadSubviews{
    titleTabBar = ({
        TabBar* tabBar;
        if (titleArr.count>4) {
            tabBar = [[TabBar alloc] initWithTitles:titleArr style:TabBarStyleScroll];
        }else{
            tabBar = [[TabBar alloc] initWithTitles:titleArr style:TabBarStyleNormal];
        }
        tabBar.edgeInsets = UIEdgeInsetsMake(0, 0, 2, 0);
        tabBar.spacing = 20;
        [self.view addSubview:tabBar];
        tabBar;
    });
    
    videoRankScrollView = ({
        UIScrollView* view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
        view.contentSize = CGSizeMake(view.width*titleArr.count, 0);
        view.showsHorizontalScrollIndicator = YES;
        view.pagingEnabled = YES;
        [self.view addSubview:view];
        view;
    });
    
    videoRankViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArr.count; i++) {
        VideoRankCollectionView* view = [[VideoRankCollectionView alloc] initWithTitle:titleArr[i]];
        view.frame = CGRectMake(videoRankScrollView.width*i, 0, videoRankScrollView.width, videoRankScrollView.height);
        view.tag = i;
        view.delegate = self;
        [videoRankViews addObject:view];
        [videoRankScrollView addSubview:view];
    }
    
    //layout
    [titleTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        if (titleArr.count>4)
            make.right.equalTo(self.view);
        else
            make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(self.view).offset = 20;
        make.height.equalTo(@(44));
    }];
}
@end
