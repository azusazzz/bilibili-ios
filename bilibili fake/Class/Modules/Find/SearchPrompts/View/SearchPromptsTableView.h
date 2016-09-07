//
//  SearchPromptsTableView.h
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPromptsTableView : UITableView

@property(nonatomic,strong,readonly)NSArray<NSString *>* wordArr;

@property(nonatomic,readonly)NSInteger avId;

@property(nonatomic,strong)NSString* keyWord;

@end
