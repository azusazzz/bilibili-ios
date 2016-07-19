//
//  VideoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"

#import "VideoHeaderView.h"
#import "VideoIntroView.h"
#import "VideoCommentView.h"

@interface VideoViewController ()
<UIScrollViewDelegate>
{
    NSInteger _aid;
    
    VideoModel *_model;
    
    VideoHeaderView *_headerView;
    
    UIView *_tabBar;
    
    UIScrollView *_backgroundScrollView;
    
    VideoIntroView *_introView;
    VideoCommentView *_commentView;
}

@end

@implementation VideoViewController

- (instancetype)initWithAid:(NSInteger)aid; {
    if (self = [super init]) {
        _aid = aid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWhite(240);
    
    _headerView = [[VideoHeaderView alloc] init];
    [self.view addSubview:_headerView];
    
    _tabBar = [[UIView alloc] init];
    _tabBar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_tabBar];
    
    _backgroundScrollView = [[UIScrollView alloc] init];
    _backgroundScrollView.bounces = NO;
    _backgroundScrollView.pagingEnabled = YES;
    [self.view addSubview:_backgroundScrollView];
    
    _introView = [[VideoIntroView alloc] init];
    _introView.scrollViewDelegate = self;
    [_backgroundScrollView addSubview:_introView];
    
    _commentView = [[VideoCommentView alloc] init];
    _commentView.scrollViewDelegate = self;
    [_backgroundScrollView addSubview:_commentView];
    
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 0;
        make.height.equalTo(_headerView.mas_width).multipliedBy(450.0/720.0);
    }];
    [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(_headerView.mas_bottom);
        make.height.offset = 30;
    }];
    [_backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(_tabBar.mas_bottom);
        make.bottom.offset = 0;
    }];
    [_introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.offset = 0;
        make.width.equalTo(_backgroundScrollView);
        make.height.equalTo(_backgroundScrollView);
    }];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_introView.mas_right);
        make.top.offset = 0;
        make.width.equalTo(_backgroundScrollView);
        make.height.equalTo(_backgroundScrollView);
    }];
    [_backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_commentView);
    }];
    
    
    _model = [[VideoModel alloc] init];
    
    [_model getVideoInfoWithAid:_aid success:^{
        //
        [_headerView setupVideoInfo:_model.videoInfo];
    } failure:^(NSString *errorMsg) {
        //
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y / 2;
    if (offset < 0) {
        offset = 0;
    }
    if (_headerView.height - offset < 44) {
        offset = _headerView.height - 44;
    }
    
    static NSInteger lastState = 0;
    
    if (_headerView.y > -offset) {
        lastState = 0;
        NSLog(@"Up");
    }
    else {
        lastState = 1;
        NSLog(@"Down");
    }
    
    
    NSLog(@"%lf", offset);
    [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset = -offset;
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}



@end
