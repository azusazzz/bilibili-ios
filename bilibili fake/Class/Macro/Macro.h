//
//  Macro.h
//  bilibili fake
//
//  Created by cezr on 16/6/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


#define LogLevelNONE    0
#define LogLevelDEBUG   1
#define LogLevelERROR   2
#define LogLevelWARN    3
#define LogLevelINFO    4


#define LogDEBUG(...) Log(LogLevelDEBUG, __VA_ARGS__)
#define LogINFO(...) Log(LogLevelINFO, __VA_ARGS__)
#define LogWARN(...) Log(LogLevelWARN, __VA_ARGS__)
#define LogERROR(...) Log(LogLevelERROR, __VA_ARGS__)

#define LogLevel LogLevelINFO

#define Log(level, ...)  \
if(level <= LogLevel) { \
    printf("\n%s 第%d行 level:%d\n%s\n",__func__,__LINE__,LogLevelDEBUG,[[NSString stringWithFormat:__VA_ARGS__] cStringUsingEncoding:NSUTF8StringEncoding]);   \
}



#define SSize   [UIScreen mainScreen].bounds.size





#import "UIStyleMacro.h"
#pragma mark - Color

#define ColorRGBA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ColorRGB(r, g, b)                   ColorRGBA((r), (g), (b), 1.0)
#define ColorWhiteAlpha(white, _alpha)      [UIColor colorWithWhite:(white)/255.0 alpha:_alpha]
#define ColorWhite(white)                   ColorWhiteAlpha(white, 1.0)



#define Font(fontSize) [UIFont fontWithName:@"ArialMT" size:fontSize]


#define ImageWithName(name)  [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[name stringByAppendingString:@".png"]]]


#pragma mark - Defult UI

//#define CRed ColorRGB(219,92,92)
#define CRed ColorRGB(253,129,164)




#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static void DeferBlock(__strong void(^*block)(void)) {
    (*block)();
}
#pragma clang diagnostic pop


/**
 *  作用域结束后会调用Block   后进先出
 *  Defer {
 *      printf("...");
 *  };
 */
#define Defer __strong void(^deferBlock)(void) __attribute__((cleanup(DeferBlock), unused)) = ^

// 标志子类继承这个方法时需要调用 super，否则给出编译警告
#define RequiresSuper __attribute__((objc_requires_super))


#endif /* Macro_h */
