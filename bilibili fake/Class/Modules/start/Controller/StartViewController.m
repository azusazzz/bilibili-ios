//
//  CXHStartViewController.m
//  webView_bilibili
//
//  Created by C on 16/6/26.
//  Copyright © 2016年 C. All rights reserved.
//

#import "StartViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Masonry.h"
#import "StartVCData.h"
#import "Macro.h"

@implementation StartViewController{

    NSMutableDictionary* _data_dic;

    BOOL Jump; //是否跳转
    NSTimer *MouseTimer;//计时器
    UIButton* skip_btn;//跳过按钮
    NSInteger skip_time;//跳过的时间
    
    
    UIViewController* _oldVC;
}

+(void)show{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[StartViewController alloc] initWithOldVC:[UIApplication sharedApplication].keyWindow.rootViewController];

}

-(id)initWithOldVC:(UIViewController*)oldVC{
    self = [super init];
    if (self) {
        _oldVC = oldVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Jump = NO;
    skip_time = 3;
    
    _data_dic = [StartVCData getStartViewData];
    
    if (_data_dic) {
        [self loadInternetSubviews];
        skip_time = [[_data_dic objectForKey:@"duration"] integerValue];
    }else{
        [self loadDefaultSubviews];
    }
    
    [self loadActions];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ActionDealt
-(void)loadActions{
    //加定时器
    MouseTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    //跳过事件
    if(skip_btn)[skip_btn addTarget:self action:@selector(skip_btn_action:) forControlEvents:UIControlEventTouchUpInside];
}

//计时器
-(void)timerAction{
    skip_time--;
    if(skip_time){
        if(skip_btn)[skip_btn setTitle: [NSString stringWithFormat:@"跳过 %lus",skip_time] forState:UIControlStateNormal];
    }else{
        //移除事件
        [self removeVC];
    }
}
//跳过按钮点击事件
-(void)skip_btn_action:(id)sender{
    [self removeVC];
}

//移除事件
-(void)removeVC{
    //移除定时器
    [MouseTimer setFireDate:[NSDate distantFuture]];
    [UIApplication sharedApplication].keyWindow.rootViewController = _oldVC;
    if (Jump) {
        //先把调用接口留好
        NSString* param = [_data_dic objectForKey:@"param"];//param ＝ bilibili://events/626 的时候无法获取活动网址
        if (param.length) {//param  不为空时点击下方就会跳转到链接
            NSLog(@"请跳转至%@",param);;
        }
    }


}
#pragma  UIViewControllerDelegate
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

//点击跳转按钮（按钮一般放在图中的下方）
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];
    //NSLog(@"%f,%f",point.x,point.y);
    float h = self.view.frame.size.height;
    float w = self.view.frame.size.width;
    if (point.y > h*0.7&&point.y<h*0.9&&point.x > w*0.3&&point.x < w*0.7) {
        Jump = YES;
    }
    
}

#pragma mark loadSubviews
//加载默认子视图
-(void)loadDefaultSubviews{
    //默认启动图方式
    self.view.backgroundColor = ColorRGB(246, 246, 246);
    
    UIImageView *bgimageView = UIImageView.new;
    [bgimageView setImage:[UIImage imageNamed: @"bilibili_splash_iphone_bg"]];
    bgimageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgimageView];

    UIImageView *imageView =  UIImageView.new;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"bilibili_splash_default"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];

    // Layout
    [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
        make.center.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:1.2 animations:^{
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.mas_width);
            make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.8);
            make.top.left.right.mas_equalTo(self.view);
        }];
        [imageView layoutIfNeeded];//强制绘制
    }];
    //
}

//加载网络启动图
-(void)loadInternetSubviews{
    UIImageView *bgimageView = UIImageView.new;
    [bgimageView sd_setImageWithURL:[NSURL URLWithString:[_data_dic objectForKey:@"image"]]];
    bgimageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgimageView];
    
    //增加跳过按钮
    NSInteger skip = [[_data_dic objectForKey:@"skip"] integerValue];
    if (skip == 1) {
        skip_btn = UIButton.new;
        bgimageView.userInteractionEnabled = YES;
        [skip_btn.layer setCornerRadius:6.0];
         skip_btn.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
        [skip_btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [skip_btn setTitle: [NSString stringWithFormat:@"跳过 %lus",skip_time] forState:UIControlStateNormal];
        [bgimageView addSubview:skip_btn];
    }

    // Layout
    [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [skip_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(bgimageView.mas_right).offset(-10);
        make.top.equalTo(bgimageView.mas_left).offset(20);
    }];
}
@end
