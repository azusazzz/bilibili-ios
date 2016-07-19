//
//  VideoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"

@interface VideoViewController ()

{
    NSInteger _aid;
    
    VideoModel *_model;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    _model = [[VideoModel alloc] init];
    
    [_model getVideoInfoWithAid:_aid success:^{
        //
    } failure:^(NSString *errorMsg) {
        //
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}





@end
