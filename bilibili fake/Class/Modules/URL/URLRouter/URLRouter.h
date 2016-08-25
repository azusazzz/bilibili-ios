//
//  URLRouter.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLRouterProtocol <NSObject>

@optional
- (instancetype)initWithURL:(NSString *)URL;

@end



@interface URLRouter : NSObject

+ (void)openURL:(NSString *)URL;

@end
