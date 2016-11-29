//
//  DownloadVideoTableView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoTableView.h"
#import "DownloadVideoTableViewCell.h"

#define Identifier @"Download"

@interface DownloadVideoTableView ()
<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@end

@implementation DownloadVideoTableView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero style:UITableViewStylePlain]) {
        self.backgroundColor = ColorWhite(247);
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 80;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[DownloadVideoTableViewCell class] forCellReuseIdentifier:Identifier];
    }
    return self;
}

- (void)setList:(NSArray<DownloadVideoEntity *> *)list {
    _list = list;
    [self reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !_selectedVideo ?: _selectedVideo(_list[indexPath.row]);
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
    DownloadVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    [cell setDownloadVideoEntity:_list[indexPath.row]];
    cell.delegate = self;
    return cell;
}

@end
