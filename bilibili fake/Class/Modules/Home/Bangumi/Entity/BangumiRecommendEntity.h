//
//  BangumiRecommendEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangumiRecommendEntity : NSObject

@property (strong, nonatomic) NSString *cover;

@property (assign, nonatomic) NSInteger cursor;

@property (strong, nonatomic) NSString *desc;

@property (assign, nonatomic) NSInteger id;

@property (assign, nonatomic) BOOL is_new;

@property (strong, nonatomic) NSString *link;

@property (strong, nonatomic) NSString *title;

@end
