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
#define LogLevelINFO    2
#define LogLevelWARN    3
#define LogLevelERROR   4


#define LogDEBUG(...) Log(LogLevelDEBUG, __VA_ARGS__)
#define LogINFO(...) Log(LogLevelINFO, __VA_ARGS__)
#define LogWARN(...) Log(LogLevelWARN, __VA_ARGS__)
#define LogERROR(...) Log(LogLevelERROR, __VA_ARGS__)

// 这里设置日志显示的级别
#define LogLevel LogLevelERROR

#define Log(level, ...)  \
if(level <= LogLevel) { \
    printf("\n%s 第%d行 level:%d\n %s\n\n",__func__,__LINE__,LogLevelDEBUG,[[NSString stringWithFormat:__VA_ARGS__] cStringUsingEncoding:NSUTF8StringEncoding]);   \
}



#define SSize   [UIScreen mainScreen].bounds.size




/*
#ifdef DEBUG
#define Log(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define Log(...)
#endif
*/







#pragma mark - Color

#define ColorRGBA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ColorRGB(r, g, b)                   ColorRGBA((r), (g), (b), 1.0)
#define ColorWhiteAlpha(white, _alpha)      [UIColor colorWithWhite:(white)/255.0 alpha:_alpha]
#define ColorWhite(white)                   ColorWhiteAlpha(white, 1.0)



#define Font(size) [UIFont systemFontOfSize:size]


#define ImageWithName(name)  [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[name stringByAppendingString:@".png"]]]


#pragma mark - Defult UI

//#define CRed ColorRGB(219,92,92)
#define CRed ColorRGB(253,129,164)

#endif /* Macro_h */
