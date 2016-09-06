//
//  FindTabelView.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindTableView.h"
#import "FindCell.h"
#import "UIView+CornerRadius.h"

@implementation FindTableView{
    NSArray<NSArray *>* dataArr;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource =self;
        self.backgroundColor = ColorRGB(247, 247, 247);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.layer.cornerRadius = 5.0;

        dataArr = @[@[@{@"title":@"兴趣圈",@"icon":@"discovery_circle_ico"},@{@"title":@"话题中心",@"icon":@"discovery_circle_ico"},@{@"title":@"活动中心",@"icon":@"discovery_circle_ico"}],
                         @[@{@"title":@"原创排行榜",@"icon":@"discovery_rankOriginal_ico"},@{@"title":@"全区排行榜",@"icon":@"discovery_rankAll_ico"}],
                         @[@{@"title":@"游戏中心",@"icon":@"discovery_game_ico"}]];
    
    }
    return self;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"FindViewCell";
    
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == NULL) {
        cell = [[FindCell alloc] init];
    }

    NSDictionary* dic = dataArr[indexPath.section][indexPath.row];
    [cell setIconImage:[UIImage imageNamed:[dic objectForKey:@"icon"]] TitleText:[dic objectForKey:@"title"] line:indexPath.row];
    return cell;
}

@end
