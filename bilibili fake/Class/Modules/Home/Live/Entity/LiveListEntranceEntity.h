//
//  LiveListEntranceEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveListEntranceEntity : NSObject

@property (assign, nonatomic) NSInteger id;

@property (strong, nonatomic) NSString *name;


#pragma mark entrance_icon

@property (strong, nonatomic) NSString *src;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGFloat width;




@end
