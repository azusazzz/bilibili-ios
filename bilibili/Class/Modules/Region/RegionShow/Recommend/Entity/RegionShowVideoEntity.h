//
//  RegionShowVideoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionShowVideoEntity : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *cover;

@property (strong, nonatomic) NSString *uri;

@property (strong, nonatomic) NSString *param;

//@property (strong, nonatomic) NSString *goto;

@property (strong, nonatomic) NSString *name;

@property (assign, nonatomic) NSInteger play;

@property (assign, nonatomic) NSInteger danmaku;

@property (assign, nonatomic) NSInteger reply;

@property (assign, nonatomic) NSInteger favourite;

@end
