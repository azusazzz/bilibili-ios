//
//  VideoRangData.h
//  bilibili fake
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoRangData : NSObject

-(void)getRangData:(NSString*)title block:(void(^)(NSMutableArray* data))block;

@end
