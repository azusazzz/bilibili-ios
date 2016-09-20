//
//  HistoryTableView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryEntity.h"

@interface HistoryTableView : UITableView

@property (strong, nonatomic) NSArray<HistoryEntity *> *list;

@property (copy, nonatomic) void (^delHistory)(HistoryEntity *history);

@property (copy, nonatomic) void (^selHistory)(HistoryEntity *history);



@end
