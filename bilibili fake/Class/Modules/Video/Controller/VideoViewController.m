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

{
    NSInteger _aid;
    
    VideoModel *_model;
    
    VideoHeaderView *_headerView;
    
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
//    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset = 0;
//        make.right.offset = 0;
//        make.top.offset = 0;
//        make.height.equalTo(_headerView.mas_width).multipliedBy(450.0/720.0);
//    }];
    
    
    _backgroundScrollView = [[UIScrollView alloc] init];
    _backgroundScrollView.pagingEnabled = YES;
    [self.view addSubview:_backgroundScrollView];
    
    _introView = [[VideoIntroView alloc] init];
    [_backgroundScrollView addSubview:_introView];
    
    _commentView = [[VideoCommentView alloc] init];
    [_backgroundScrollView addSubview:_commentView];
    
    
    
    _headerView.frame = CGRectMake(0, 0, self.view.width, self.view.width * 450.0/720.0);
    _backgroundScrollView.frame = CGRectMake(0, _headerView.maxY, self.view.width, self.view.height - _headerView.maxY);
    _introView.frame = CGRectMake(0, 0, _backgroundScrollView.width, _backgroundScrollView.height);
    _commentView.frame = CGRectMake(_backgroundScrollView.width, 0, _backgroundScrollView.width, _backgroundScrollView.height);
    
    _backgroundScrollView.contentSize = CGSizeMake(_backgroundScrollView.width*2, 0);
    
    
    _model = [[VideoModel alloc] init];
    
    [_model getVideoInfoWithAid:_aid success:^{
        //
        [_headerView setupVideoInfo:_model.videoInfo];
    } failure:^(NSString *errorMsg) {
        //
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
