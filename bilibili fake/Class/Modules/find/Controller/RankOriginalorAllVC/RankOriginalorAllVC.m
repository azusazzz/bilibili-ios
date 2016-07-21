//
//  RankOriginalorAllVC.m
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RankOriginalorAllVC.h"

@implementation RankOriginalorAllVC
-(instancetype)initWithType:(RankType)type{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
@end
