//
//  SearchPromptsTableView.h
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPromptsModel.h"
@interface SearchPromptsTableView : UITableView

-(instancetype)initWithModel:(SearchPromptsModel*)searchPromptsModel;

@property(nonatomic,strong,readonly)NSMutableArray<NSString *>* wordArr;

@property(nonatomic,readonly)NSInteger avId;

@property(nonatomic,strong)NSString* keyWord;

@end
