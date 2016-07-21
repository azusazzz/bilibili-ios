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

@interface RankOriginalorAllVC ()<UIScrollViewDelegate>

@end

@implementation RankOriginalorAllVC{
    NSMutableArray<NSString* >* titles;
    
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
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    _titleTabBar.contentOffset = scrollView.contentOffset.x / scrollView.contentSize.width;
}

#pragma mark - ActionDealt
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark loadSubviews
//加载视图
-(void)loadSubviews{
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:ImageWithName(@"common_back") forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=back;
    //标题按钮
    _titleTabBar = [[TabBar alloc] initWithTitles:titles];
    _titleTabBar.itemWidth = 80;
    self.navigationItem.titleView = _titleTabBar;
    //底部列表
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.pagingEnabled = YES;
//    _scrollView.bounces = NO;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.frame = CGRectMake(0, 0, SSize.width,SSize.height);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*titles.count, _scrollView.frame.size.height);
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < titles.count; i++) {
        VideoRangTableView *vrtv = [[VideoRangTableView alloc] init];
        vrtv.frame = CGRectMake( _scrollView.frame.size.width*i, 0, _scrollView.frame.size.width,_scrollView.frame.size.height);
        [_scrollView addSubview:vrtv];
    }
    // Layout
    btn.frame = CGRectMake(0, 5, 15, 15);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    _titleTabBar.frame = CGRectMake(0, 0, _titleTabBar.itemWidth * titles.count, 44);
   

}
@end
