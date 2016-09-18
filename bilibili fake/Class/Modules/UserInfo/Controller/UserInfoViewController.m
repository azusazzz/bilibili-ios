//
//  UserInfoViewController.m
//  bilibili fake
//
//  Created by C on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoViewController.h"

#import "Macro.h"
#import <Masonry.h>
#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "UIView+Frame.h"


#import "UserInfoModel.h"

#import "UserInfoCardView.h"
#import "UserInfoLiveView.h"

@interface UserInfoViewController()<UIGestureRecognizerDelegate, UIScrollViewDelegate>


@end

@implementation UserInfoViewController{
    UIImageView* backgroundImageView;
    UIScrollView* userInfoScrollView;
    UserInfoCardView* userInfoCardView;
    UserInfoLiveView* userInfoLiveView;
    
    UserInfoModel * model;
}

-(instancetype)initWithMid:(NSInteger)mid{
    if (self = [super init]) {
        self.title = @"用户名字";
        model = [[UserInfoModel alloc] initWithMid:mid];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadSubviews];
    [self loadActions];
    [self loadData];
    [self.navigationBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 0;
        make.height.offset = 64;
    }];
    [self navigationBar].alpha = 0;;
}

-(void)loadActions{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
}
-(void)loadData{
    [model getCardEntityWithSuccess:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            userInfoCardView.entity = model.cardEntity;
        }];
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    
    [model getLiveEntityWithSuccess:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            userInfoLiveView.entity = model.liveEntity;
        }];
    } failure:^(NSString *errorMsg) {
        
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

#pragma UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    [backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.view);
        make.height.mas_equalTo(120-scrollView.contentOffset.y>SSize.width*0.57?120-scrollView.contentOffset.y:SSize.width*0.57);
        make.width.equalTo(backgroundImageView.mas_height).multipliedBy(1.75);
    }];
    self.navigationBar.alpha = scrollView.contentOffset.y/64.0;
}


#pragma loadSubviews

-(void)loadSubviews{
    self.view.backgroundColor = ColorWhite(243);
    
    backgroundImageView = ({
        UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space_header"]];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.backgroundColor = ColorWhite(0);
        [self.view addSubview:view];
        view;
    });
    

    userInfoScrollView = ({
        UIScrollView* src =  [[UIScrollView alloc] initWithFrame:self.view.bounds];
        src.delegate = self;
        src.contentSize = CGSizeMake(SSize.width, 1000);
        src.backgroundColor = ColorWhiteAlpha(243, 0);
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:src];
        src;
    });
    
    userInfoCardView = [[UserInfoCardView alloc] init];
    [userInfoScrollView addSubview:userInfoCardView];
    
    userInfoLiveView = [[UserInfoLiveView alloc] init];
    [userInfoScrollView addSubview:userInfoLiveView];
    
    
    UIImageView* scrollBgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userInfoBg.jpg"]];
    scrollBgview.backgroundColor = ColorWhite(243);
    [userInfoScrollView addSubview:scrollBgview];
    [userInfoScrollView sendSubviewToBack:scrollBgview];
    

    
    
    //layout
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(backgroundImageView.mas_width).multipliedBy(0.57);
    }];
    
  
    [userInfoCardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoScrollView);
        make.left.equalTo(userInfoScrollView);
        make.height.equalTo(@(270)).priorityLow();
        make.width.equalTo(@(SSize.width));
    }];
    
    [userInfoLiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoCardView.mas_bottom).offset(20);
        make.left.equalTo(userInfoScrollView).offset(10);
        make.height.equalTo(@(50)).priorityLow();;
        make.width.equalTo(@(SSize.width-20));
    }];
    
    
    [scrollBgview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoCardView.mas_bottom);
        make.left.right.equalTo(userInfoCardView);
        make.height.equalTo(scrollBgview.mas_width).multipliedBy(1.7);
    }];

    
    [userInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(scrollBgview.mas_bottom);
    }];


}




@end
