//
//  VideoCommentItemEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoCommentItemEntity : NSObject

@property (assign, nonatomic) NSInteger mid;

@property (assign, nonatomic) NSInteger lv;

@property (assign, nonatomic) NSInteger fbid;

@property (assign, nonatomic) NSInteger ad_check;

@property (assign, nonatomic) NSInteger good;

@property (assign, nonatomic) BOOL isgood;

@property (strong, nonatomic) NSString *msg;

@property (strong, nonatomic) NSString *device;

@property (assign, nonatomic) NSInteger create;

@property (strong, nonatomic) NSString *create_at;

@property (assign, nonatomic) NSInteger reply_count;

@property (strong, nonatomic) NSString *face;

@property (assign, nonatomic) NSInteger rank;

@property (strong, nonatomic) NSString *nick;

@property (strong, nonatomic) NSDictionary *level_info;

@property (strong, nonatomic) NSString *sex;

@property (strong, nonatomic) NSArray<VideoCommentItemEntity *> *reply;

@property (assign, nonatomic) CGFloat height;

@end
