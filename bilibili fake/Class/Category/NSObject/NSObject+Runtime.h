//
//  NSObject+Runtime.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

+ (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
