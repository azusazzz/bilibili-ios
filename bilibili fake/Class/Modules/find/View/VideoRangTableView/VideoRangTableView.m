//
//  VideoRangTableView.m
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRangTableView.h"
@interface VideoRangTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation VideoRangTableView

-(instancetype)initWithTitle:(NSString *)title{
    self = [super self];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

//分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1234"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1234"];
        cell.imageView.image = [UIImage imageNamed:@"search_history_icon"];
    }
    return cell;

}
@end
