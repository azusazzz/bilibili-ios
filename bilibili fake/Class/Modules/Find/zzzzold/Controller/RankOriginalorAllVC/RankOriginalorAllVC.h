//
//  RankOriginalorAllVC.h
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RankType) {
    RankOriginal,//原创排行
    RankAll//全区排行
};

@interface RankOriginalorAllVC : UIViewController

-(instancetype)initWithType:(RankType)type;

@end
