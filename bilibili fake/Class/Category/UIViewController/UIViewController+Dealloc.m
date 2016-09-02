//
//  UIViewController+Dealloc.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/2.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIViewController+Dealloc.h"
#import "NSObject+Runtime.h"

@implementation UIViewController (Dealloc)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:NSSelectorFromString(@"dealloc") swizzledSelector:@selector(aop_dealloc)];
    });
}

- (void)aop_dealloc {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"UI"]) {
        NSLog(@"dealloc: %@", className);
    }
    [self aop_dealloc];
}

@end
