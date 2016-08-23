//
//  VideoURL.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoURL : NSObject

- (instancetype)initWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page completionBlock:(void (^)(NSURL *videoURL))completionBlock;


+ (void)getVideoURLWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page completionBlock:(void (^)(NSURL *videoURL))completionBlock;

+ (VideoURL *)currentOperation;

@end
