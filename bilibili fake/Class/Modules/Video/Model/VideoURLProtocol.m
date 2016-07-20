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

@implementation VideoURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    if ([request.URL.absoluteString rangeOfString:@"mp4"].length) {
//        NSLog(@"%@", request.URL.absoluteString);
        
        [NSURLProtocol unregisterClass:[self class]];
        
        UIViewController *controller = UIViewController.currentViewController;
        if ([controller isKindOfClass:[VideoViewController class]]) {
            VideoViewController *video = (VideoViewController *)controller;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [video.model webViewVideoURL:request.URL];
            }];
            
        }
//        return YES;
    }
    
    return NO;
}

@end
