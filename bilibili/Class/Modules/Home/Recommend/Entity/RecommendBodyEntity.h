//
//  RecommendBodyEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendBodyEntity : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *cover;

@property (strong, nonatomic) NSString *uri;

@property (strong, nonatomic) NSString *param;

@property (strong, nonatomic) NSString *_goto;

// AV

@property (assign, nonatomic) NSInteger play;

@property (assign, nonatomic) NSInteger danmaku;

// Live

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *face;

@property (assign, nonatomic) NSInteger online;

// bangumi

@property (strong, nonatomic) NSString *mtime;

@property (assign, nonatomic) NSInteger index;

@end
