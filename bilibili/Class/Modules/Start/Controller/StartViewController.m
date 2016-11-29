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
#import "StartInfoModel.h"
#import "Macro.h"


@implementation StartViewController{

    StartInfoModel* model;

    BOOL Jump; //是否跳转
    NSTimer *MouseTimer;//计时器
    UIButton* skip_btn;//跳过按钮
    NSInteger skip_time;//跳过的时间
    
    UIImageView* bilibili2233ImageView;
    UIViewController* _oldVC;
}

+(void)show{
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[StartViewController alloc] initWithOldVC:[UIApplication sharedApplication].keyWindow.rootViewController];
//    UIViewController* rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [rootVC presentViewController:[[StartViewController alloc] init] animated:NO completion:^{}];
    
    [[UIApplication sharedApplication].keyWindow addSubview:[[StartViewController alloc] init].view];
    
}

//-(id)initWithOldVC:(UIViewController*)oldVC{
//    self = [super init];
//    if (self) {
//        _oldVC = oldVC;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    Jump = NO;
    skip_time = 3;
    
    model = [[StartInfoModel alloc] init];
    
    if (model.currentStartPage) {
        [self loadInternetSubviews];
        skip_time = model.currentStartPage.duration;
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
    [MouseTimer invalidate];
//    [UIApplication sharedApplication].keyWindow.rootViewController = _oldVC;
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.view removeFromSuperview];
    if (Jump) {
        //先把调用接口留好
        NSString* param = model.currentStartPage.param;//param ＝ bilibili://events/626 的时候无法获取活动网址
        if (param.length) {
            NSLog(@"跳转至%@",param);;
        }
    }


}
#pragma  UIViewControllerDelegate
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
    
    UIImageView *bgimageView = ({
        UIImageView *imageView = UIImageView.new;
        [imageView setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[@"bilibili_splash_iphone_bg" stringByAppendingString:@".png"]]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        imageView;
    });

    bilibili2233ImageView =({
        UIImageView *imageView =  UIImageView.new;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"bilibili_splash_default.png"]];
        imageView.center = self.view.center;
        [self.view addSubview:imageView];
        imageView;
    });


    // Layout
    [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [bilibili2233ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
    }];
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:0.1f];
}
-(void)animate{
    [UIView animateWithDuration:0.8 animations:^{
        [bilibili2233ImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.mas_width);
            make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.8);
            make.top.left.right.mas_equalTo(self.view);
        }];
        [bilibili2233ImageView layoutIfNeeded];
    }];
}
//加载网络启动图
-(void)loadInternetSubviews{
    
    UIImageView *bgimageView = ({
        UIImageView *imageView = UIImageView.new;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.currentStartPage.image]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        imageView;
    });
    
    //增加跳过按钮
    if (model.currentStartPage.skip== 1) {
        skip_btn = ({
            UIButton* btn = UIButton.new;
            bgimageView.userInteractionEnabled = YES;
            [btn.layer setCornerRadius:6.0];
            btn.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
            [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [btn setTitle: [NSString stringWithFormat:@"跳过 %lus",skip_time] forState:UIControlStateNormal];
            [bgimageView addSubview:btn];
            btn;
        });
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
