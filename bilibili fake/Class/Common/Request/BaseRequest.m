//
//  BaseRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (NSInteger)responseCode; {
    if (self.responseObject) {
        return [[self.responseObject valueForKey:@"code"] integerValue];
    }
    else {
        return -1;
    }
}

- (id)responseData {
    if (self.responseObject) {
        id data = [self.responseObject valueForKey:@"data"];
        if (data) {
            return data;
        }
        else {
            return NULL;
        }
    }
    else {
        return NULL;
    }
}

- (NSString *)errorMsg {
    if (self.error) {
        return self.error.localizedDescription;
    }
    else if ([self.responseData objectForKey:@"message"]) {
        return [self.responseData objectForKey:@"message"];
    }
    else {
        return @"网络请求出错";
    }
}

- (void)startWithCompletionBlock:(void (^)(BaseRequest *))completionBlock {
    [super startWithCompletionBlock:completionBlock];
}

@end
