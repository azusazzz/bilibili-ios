//
//  VideoCommentView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentView.h"
#import "VideoCommentTableViewCell.h"
#import "NSString+Size.h"

@interface VideoCommentView ()
<UITableViewDelegate, UITableViewDataSource>

@end

@implementation VideoCommentView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped]) {
        self.backgroundColor = ColorWhite(247);
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[VideoCommentTableViewCell class] forCellReuseIdentifier:@"VideoComment"];
        [self registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"Header"];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollViewDelegate scrollViewDidScroll:scrollView];
}

- (void)setCommentList:(NSArray<NSArray<VideoCommentItemEntity *> *> *)commentList {
    _commentList = [commentList copy];
    [self reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _commentList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentList[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"VideoComment"];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(VideoCommentTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setupCommentInfo:_commentList[indexPath.section][indexPath.row] showReply:indexPath.section != 0];
    cell.topLine.hidden = indexPath.row == 0;
    if (_hasNext && indexPath.section == _commentList.count-1 && indexPath.row == _commentList[_commentList.count-1].count-1) {
        _hasNext = NO;
        _handleLoadNextPage ? _handleLoadNextPage() : NULL;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_commentList[indexPath.section][indexPath.row].height == 0) {
        _commentList[indexPath.section][indexPath.row].height = [VideoCommentTableViewCell heightForComment:_commentList[indexPath.section][indexPath.row] showReply:indexPath.section != 0];
    }
    return _commentList[indexPath.section][indexPath.row].height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 60;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NULL;
    }
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (headerView.tag == 0) {
        headerView.contentView.backgroundColor = ColorWhite(247);
        headerView.tag = 1;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWhite(200);
        [headerView addSubview:lineView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"更多热门评论>>" forState:UIControlStateNormal];
        [button setTitleColor:CRed forState:UIControlStateNormal];
        button.titleLabel.font = Font(13);
        button.backgroundColor = ColorWhite(247);
        [headerView addSubview:button];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.centerY.equalTo(headerView);
            make.height.offset = 0.5;
        }];
        CGFloat buttonWidth = [button.titleLabel.text widthWithFont:Font(13) maxHeight:15] + 10;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = buttonWidth;
            make.height.offset = 30;
            make.center.equalTo(headerView);
        }];
    }
    return headerView;
}


@end
