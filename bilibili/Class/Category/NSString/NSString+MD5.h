//
//  NSString+MD5.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/3.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 *  MD5  小写
 */
@property (assign, nonatomic, readonly) NSString *md5;

/**
 *  MD5  大写
 */
@property (assign, nonatomic, readonly) NSString *MD5;

@end
