//
//  NSObject+Runtime.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector; {
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    if (class_addMethod([self class],originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod([self class],swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
