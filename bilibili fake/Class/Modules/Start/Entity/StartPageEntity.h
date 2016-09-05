//
//  StartPageEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StartPageEntity : NSObject
@property(nonatomic)NSInteger start_time;
@property(nonatomic)NSInteger end_time;
@property(nonatomic)NSInteger duration;

@property(strong , nonatomic)NSString* image;
@property(strong , nonatomic)NSString* param;

@property(strong , nonatomic)NSString* key;
@property(nonatomic)NSInteger type;
@property(nonatomic)NSInteger skip;
@property(nonatomic)NSInteger id;
@property(nonatomic)NSInteger times;

@end
