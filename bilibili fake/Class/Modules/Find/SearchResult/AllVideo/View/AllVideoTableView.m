//
//  AllVideoTableView.m
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoTableView.h"
@interface AllVideoTableView()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation AllVideoTableView
-(instancetype)init{
    if (self = [super init]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==2?0:100;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    return view;
}
@end
