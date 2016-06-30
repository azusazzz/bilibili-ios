//
//  CXHStartViewController.m
//  webView_bilibili
//
//  Created by C on 16/6/26.
//  Copyright © 2016年 C. All rights reserved.
//

#import "CXHStartViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Masonry.h"



@implementation CXHStartViewController{
    NSString* startView_data_path;//启动图数据储存路径
    NSString* activity_URL;//跳转网页地址
    BOOL Jump; //是否跳转
    NSTimer *MouseTimer;//计时器
    UIButton* skip_btn;//跳过按钮
    NSInteger skip_time;//跳过的时间
    UIViewController* _oldVC;
}

+(void)show{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[CXHStartViewController alloc] initWithOldVC:[UIApplication sharedApplication].keyWindow.rootViewController];
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
    //self.navigationController.navigationBar.hidden = YES;
    NSDictionary* startView_data_dic = nil;
    NSURL *image_URL = nil;//仅在不使用默认视图时有值
    activity_URL = nil;
    Jump = NO;
    NSInteger duration = 3000;
    skip_time = 3;
    
    
    
    
    //检查是否有启动图数据
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    startView_data_path = [cachesPath stringByAppendingPathComponent:@"CXHstarView_data.json"];
    NSFileManager* mgr = [NSFileManager defaultManager];
    if([mgr fileExistsAtPath:startView_data_path] == YES){//查看文件是否存在
        
        //如果存在解析出有用的数据（当前和未来的启动图数据）
        NSArray* startView_data = [self get_startView_data];
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval now_time=[dat timeIntervalSince1970];
        if (startView_data.count) {
            NSDictionary* dic = startView_data[0];
            NSLog(@"%@",dic);
            //比对时间
            if ([[dic objectForKey:@"start_time"] doubleValue]<now_time) {
                image_URL = [NSURL URLWithString:[dic objectForKey:@"image"]];
                //判断图片是否已加载
                startView_data_dic = dic;
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                if ([manager diskImageExistsForURL:image_URL] == NO) {
                    image_URL = nil;
                }
                //判断是否是广告(猜错了这个不是判断广告的)
//                if ([[dic objectForKey:@"type"] integerValue] == 1) {
//                    //判断广告是否播放过
//                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//                    NSString* key = [NSString stringWithFormat:@"advertisementId:%@",[dic objectForKey:@"id"]];
//                    NSInteger ii =[[defaults objectForKey:key] integerValue];
//                    if (ii) {
//                        //不为空说明播放过
//                        image_URL = nil;
//                    }else{
//                        [defaults setObject:@1 forKey:key];
//                        [defaults synchronize];
//                    }
//                }
            }
        }
    }
    //开始刷新启动图的数据
    [self download_startView_data];
 
    
    
    
    
    MouseTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(MouseMove) userInfo:nil repeats:YES];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgimageView = UIImageView.new;
    [self.view addSubview:bgimageView];
    [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
    if (image_URL) {
        //读取服务端控制的启动图
        
        
        //添加跳转事件
        NSString* param = [startView_data_dic objectForKey:@"param"];//param ＝ bilibili://events/626 的时候无法获取活动网址
        if (param.length) {//param  不为空时点击下方就会跳转到链接
                activity_URL = [[NSString alloc] initWithString:param];
        }
        //赋值启动图时间
        duration = [[startView_data_dic objectForKey:@"duration"] integerValue]*1000;
        skip_time = duration/1000;
        //设置背景图
        [bgimageView sd_setImageWithURL:image_URL];
        //增加跳过按钮
        NSInteger skip = [[startView_data_dic objectForKey:@"skip"] integerValue];
        if (skip ==1) {
            skip_btn = UIButton.new;
            bgimageView.userInteractionEnabled = YES;
            [bgimageView addSubview:skip_btn];
            [skip_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(60, 30));
                make.right.equalTo(bgimageView.mas_right).offset(-10);
                make.top.equalTo(bgimageView.mas_left).offset(20);
            }];
            [skip_btn.layer setCornerRadius:6.0];
            skip_btn.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
            [skip_btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [skip_btn setTitle: [NSString stringWithFormat:@"跳过 %lus",skip_time] forState:UIControlStateNormal];
            [skip_btn addTarget:self action:@selector(skip_btn_action:) forControlEvents:UIControlEventTouchUpInside];
        }

        
    }else{
        
        
        //默认启动图方式
        [bgimageView setImage:[UIImage imageNamed: @"bilibili_splash_iphone_bg"]];
        
        
        UIImageView *bgimageView = UIImageView.new;
        [bgimageView setImage:[UIImage imageNamed: @"bilibili_splash_iphone_bg"]];
        [self.view addSubview:bgimageView];
        [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        
        UIImageView *imageView =  UIImageView.new;
        [self.view addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"bilibili_splash_default"];
        imageView.center = self.view.center;
        
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
    }
    

}
//计时器
-(void)MouseMove{
    skip_time--;
    if(skip_time){
        if(skip_btn)[skip_btn setTitle: [NSString stringWithFormat:@"跳过 %lus",skip_time] forState:UIControlStateNormal];
    }else{
        [self removeVC];
    }
}
//按钮点击事件
-(void)skip_btn_action:(id)sender{
    [self removeVC];
}


//移除事件
-(void)removeVC{
    //移除定时器
    [MouseTimer setFireDate:[NSDate distantFuture]];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.alpha = 0;
//    } completion:^(BOOL finished) {
//        self.navigationController.navigationBar.hidden = NO;//显示导航栏
//        [self.navigationController popViewControllerAnimated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = _oldVC;
    if (Jump) {
        //先把调用接口留好
        NSLog(@"请跳转至%@",activity_URL);
    }
//    }];

}
//点击松开事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (activity_URL) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch  locationInView:self.view];
        //NSLog(@"%f,%f",point.x,point.y);
        float h = self.view.frame.size.height;
        float w = self.view.frame.size.width;
        if (point.y > h*0.7&&point.y<h*0.9&&point.x > w*0.3&&point.x < w*0.7) {
            Jump = YES;
        }
    }
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

//下载数据
-(void)download_startView_data{
    //获取宽高的分辨率
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.bilibili.com/x/splash?build=3390&channel=appstore&height=%0.0f&plat=1&width=%0.0f",height*scale_screen,width*scale_screen]]];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;//忽略本地缓存数据
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (!error)
                                          {
                                              //保存数据
                                              NSLog(@"写入启动图数据:%@",startView_data_path);
                                              [data writeToFile:startView_data_path atomically:YES];
                                              //预加载一遍视图
                                              NSMutableArray* arr = [self get_startView_data];
                                              
                                              for(NSDictionary* dic in arr) {
                                                  NSURL* url = [NSURL URLWithString:[dic objectForKey:@"image"]];
                                                  UIImageView *imageview = UIImageView.new;
                                                  [imageview sd_setImageWithURL:url];
                                              }
                                          }
                                          
                                      }];
    // 使用resume方法启动任务
    [dataTask resume];
}


//解析数据
-(NSMutableArray*)get_startView_data{
    NSData *data = [[NSData alloc] initWithContentsOfFile:startView_data_path];
    NSDictionary* startView_data_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",startView_data_dic);
    startView_data_dic = [startView_data_dic objectForKey:@"data"];
    //获取当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now_time=[dat timeIntervalSince1970];
    NSLog(@"当前的时间戳:%f",now_time);
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in startView_data_dic) {
        if([[dic objectForKey:@"end_time"] doubleValue] > now_time){
            [arr addObject:dic];
        }
    }
    return arr;
}

@end
