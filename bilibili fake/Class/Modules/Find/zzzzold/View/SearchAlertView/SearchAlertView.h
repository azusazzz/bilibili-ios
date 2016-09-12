//
//  SearchAlertTableView.h
//  bilibili fake
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAlertView : UIView<UITableViewDelegate,UITableViewDataSource>

-(void)setKeyword:(NSString*)str;

@end
