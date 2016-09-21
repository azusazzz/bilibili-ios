//
//  BangumiInfoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoViewController.h"
#import "BangumiInfoModel.h"

@interface BangumiInfoViewController ()

@property (assign, nonatomic) NSInteger ID;

@property (strong, nonatomic) BangumiInfoModel *model;

@end

@implementation BangumiInfoViewController

- (instancetype)initWithID:(NSInteger)ID {
    if (self = [super init]) {
        _ID = ID;
        _model = [[BangumiInfoModel alloc] initWithID:ID];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_model getBangumiInfoWithSuccess:^{
        //
    } failure:^(NSString *errorMsg) {
        //
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
