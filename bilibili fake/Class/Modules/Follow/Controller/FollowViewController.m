//
//  FollowViewController.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FollowViewController.h"

@interface FollowViewController ()

@end

@implementation FollowViewController

- (instancetype)init; {
    if (self = [super init]) {
        self.title = @"关注";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
