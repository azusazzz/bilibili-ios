//
//  HistoryTableViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <SWTableViewCell.h>
#import "HistoryEntity.h"

@interface HistoryTableViewCell : SWTableViewCell

- (void)setHistory:(HistoryEntity *)history;

@end
