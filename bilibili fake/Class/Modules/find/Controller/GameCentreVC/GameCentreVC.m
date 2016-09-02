//
//  GameCentreVC.m
//  bilibili fake
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCentreVC.h"
#import "Macro.h"
#import "GameCenterCell.h"
#import <UIImageView+WebCache.h>
#import "GameCentreData.h"
#import "UIView+CornerRadius.h"

@interface GameCentreVC ()

@end

@implementation GameCentreVC{
    NSArray* GameData_Arr;
}
-(id)init{
    self = [super init];
    if (self) {
      self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    GameData_Arr = @[];
    [self getGameData];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorRGBA(0, 0, 0, 0);
    self.tableView.backgroundColor = ColorRGBA(0, 0, 0, 0);
    //设置标题栏
    self.title = @"游戏中心";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-ActionDealt

//获取游戏数据
-(void)getGameData{
    [[GameCentreData share] getGamesInfo:^(NSArray *GamesInfo) {
        GameData_Arr = GamesInfo;
        [self.tableView reloadData];
    }];
}

//返回
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - Table view data source
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = GameData_Arr[indexPath.row];
     NSLog(@"请跳转到:%@",[dic objectForKey:@"download_link"]);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GameData_Arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCentreVC_cell"];
    
    if (cell == nil) {
        cell = [[GameCenterCell alloc] initWithData:GameData_Arr[indexPath.row]];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width/2 + 50 + 10;
}
@end
