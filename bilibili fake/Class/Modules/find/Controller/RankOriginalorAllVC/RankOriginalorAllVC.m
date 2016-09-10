//
//  RankOriginalorAllVC.m
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RankOriginalorAllVC.h"
#import "RowBotton.h"
#import "TabBar.h"
#import "VideoRangTableView.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>

@interface RankOriginalorAllVC ()<UIScrollViewDelegate>

@end

@implementation RankOriginalorAllVC{
    NSMutableArray<NSString* >* titles;
    NSMutableArray<VideoRangTableView* > *_tableViews;
    
    TabBar*      _titleTabBar;
    UIScrollView*   _scrollView;
    
}
-(instancetype)initWithType:(RankType)type{
    self = [super init];
    if (self) {
        switch (type) {
            case RankOriginal:
                self.title = @"原创";
                titles = [[NSMutableArray alloc] initWithObjects:
                          @"原创",
                          @"全站",
                          @"新番", nil];
                break;
            case RankAll:
                self.title = @"全区";
                titles = [[NSMutableArray alloc] initWithObjects:
                          @"番剧",
                          @"动画",
                          @"音乐",
                          @"舞蹈",
                          @"游戏",
                          @"科技",
                          @"生活",
                          @"鬼畜",
                          @"时尚",
                          @"娱乐",
                          @"电影",
                          @"电视剧",nil];
                break;
            default:
                break;
        }

    }
    return self;
}


- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
     [[SDImageCache sharedImageCache] clearMemory];//清理内存中的
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:UIView.new];
    [self loadSubviews];
    [self scrollViewDidEndDecelerating:_scrollView];
    [self loadActions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



-(void)loadActions{
    __weak UIScrollView* scrollView = _scrollView;
    [_titleTabBar setOnClickItem:^(NSInteger idx) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * idx, 0) animated:YES];
    }];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    _titleTabBar.contentOffset = scrollView.contentOffset.x / scrollView.width;
    //加载附近的两个视图数据
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    for(int i = page -1; i <page +2; i++){
       if(i>=0&&i<_tableViews.count)[_tableViews[page] setData];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}
#pragma mark - ActionDealt
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark loadSubviews
//加载视图
-(void)loadSubviews{
    
    
    UIView* headView = [UIView new];
//    headView.layer.borderWidth = 0.5;
//    headView.layer.borderColor = [ColorRGB(200, 200, 200) CGColor];
//    headView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    headView.layer.shadowOffset = CGSizeMake(0,-1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    headView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//    headView.layer.shadowRadius = 2;//阴影半径，默认3
    [self.view addSubview:headView];
    //下边框
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(0.0f, 63.0f, SSize.width,1.0f);
    TopBorder.backgroundColor = [ColorRGB(200, 200, 200) CGColor];
    [headView.layer addSublayer:TopBorder];

    
    //返回按钮
    UIView* backbtn_bg  = [UIView new];
    [headView addSubview:backbtn_bg];
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setImage:ImageWithName(@"common_back") forState:UIControlStateNormal];
    [backbtn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    [backbtn_bg addSubview:backbtn];
    
//    //标题按钮
    if (titles.count>4) {
       _titleTabBar = [[TabBar alloc] initWithTitles:titles style:TabBarStyleScroll];
    }else{
        _titleTabBar = [[TabBar alloc] initWithTitles:titles style:TabBarStyleNormal];
    }
    _titleTabBar.backgroundColor = [UIColor whiteColor];
    _titleTabBar.tintColorRGB = @[@253,@129,@164];
    _titleTabBar.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _titleTabBar.spacing = 40;

    [headView addSubview:_titleTabBar];

    
    //底部列表
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.bounces = NO;//设置没有弹性
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.frame = CGRectMake(0, 64, SSize.width,SSize.height-64);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*titles.count, 0);
    [self.view addSubview:_scrollView];
    
    
    _tableViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count; i++) {
        VideoRangTableView *vrtv = [[VideoRangTableView alloc] initWithTitle:titles[i]];
        vrtv.frame = CGRectMake( _scrollView.frame.size.width*i, 0, _scrollView.frame.size.width,_scrollView.frame.size.height);
        [_scrollView addSubview:vrtv];
        [_tableViews addObject:vrtv];
    }
    // Layout
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    [backbtn_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left).offset(0);
        make.top.mas_equalTo(headView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backbtn_bg);
    }];
    
    [_titleTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backbtn.mas_right);
        make.right.equalTo(headView);
        make.top.mas_equalTo(headView.mas_top).offset(20);
        make.bottom.equalTo(headView.mas_bottom).offset(-1);
    }];
    
//    titleScr.contentSize = CGSizeMake(SSize.width*0.2*titles.count, 44);
  
    
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(headView.mas_bottom);
        make.bottom.equalTo(self.view).offset(64);
    }];
//    _titleTabBar.frame = CGRectMake(0, 0, _titleTabBar.itemWidth * titles.count, 44);
//    [_titleTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset = 0;
//        make.height.equalTo(@(44+20));
//    }];
    
 
    
}
@end
