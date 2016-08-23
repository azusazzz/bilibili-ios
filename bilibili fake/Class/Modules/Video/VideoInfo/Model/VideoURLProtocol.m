//
//  VideoURLProtocol.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoURLProtocol.h"
#import "UIViewController+GetViewController.h"
#import "VideoViewController.h"
#import "VideoModel.h"

#import "VideoURL.h"

@implementation VideoURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSString *urlString = [request.URL.absoluteString componentsSeparatedByString:@"?"][0].pathExtension;
    
    if ([urlString isEqualToString:@"mp4"]) {
        if ([VideoURL currentOperation]) {
            SEL sel = NSSelectorFromString(@"webViewVideoURL:");
            if ([[VideoURL currentOperation] respondsToSelector:sel]) {
                [[VideoURL currentOperation] performSelectorOnMainThread:sel withObject:request.URL waitUntilDone:NO];
            }
        }
    }
    
    return NO;
}

@end
