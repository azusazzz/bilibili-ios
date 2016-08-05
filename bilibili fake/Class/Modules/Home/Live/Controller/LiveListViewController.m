//
//  LiveListViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListViewController.h"

@interface LiveListViewController ()

@end

@implementation LiveListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"直播";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWhite(247);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LogDEBUG(@"")
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LogDEBUG(@"")
}

@end
