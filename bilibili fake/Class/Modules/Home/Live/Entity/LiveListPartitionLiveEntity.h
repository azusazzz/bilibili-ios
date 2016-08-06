//
//  LiveListPartitionLiveEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveListPartitionLiveEntity : NSObject


@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger room_id;

@property (assign, nonatomic) NSInteger check_version;

@property (assign, nonatomic) NSInteger online;

@property (strong, nonatomic) NSString *area;

@property (assign, nonatomic) NSInteger area_id;

@property (strong, nonatomic) NSString *playurl;

@property (assign, nonatomic) NSInteger accept_quality;

@property (assign, nonatomic) NSInteger broadcast_type;

@property (assign, nonatomic) BOOL is_tv;


#pragma mark owner

@property (strong, nonatomic) NSString *owner_face;

@property (assign, nonatomic) NSInteger owner_mid;

@property (strong, nonatomic) NSString *owner_name;


#pragma mark cover

@property (strong, nonatomic) NSString *cover_src;

@property (assign, nonatomic) CGFloat cover_height;

@property (assign, nonatomic) CGFloat cover_width;




@end
