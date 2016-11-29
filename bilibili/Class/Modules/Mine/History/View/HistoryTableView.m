//
//  HistoryTableView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HistoryTableView.h"
#import "HistoryTableViewCell.h"

#define Identifier @"History"

@interface HistoryTableView ()
<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>

@end

@implementation HistoryTableView

- (void)setList:(NSArray<HistoryEntity *> *)list {
    _list = list;
    [self reloadData];
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero style:UITableViewStylePlain]) {
        self.backgroundColor = [UIColor whiteColor];
        self.rowHeight = 90;
        self.sectionHeaderHeight = 10;
        self.sectionFooterHeight = 10;
        [self registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:Identifier];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !_selHistory ?: _selHistory(_list[indexPath.row]);
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    [cell hideUtilityButtonsAnimated:YES];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    !_delHistory ?: _delHistory(_list[indexPath.row]);
}


#pragma mark - Number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_list count];
}

#pragma mark - Cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    [cell setHistory:_list[indexPath.row]];
    cell.delegate = self;
    return cell;
}

@end
