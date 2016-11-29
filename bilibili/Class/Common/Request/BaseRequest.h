//
//  BaseRequest.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "Request.h"

@interface BaseRequest : Request

@property (assign, nonatomic, readonly) NSInteger responseCode;

@property (strong, nonatomic, readonly) id responseData;

@property (strong, nonatomic, readonly) NSString *errorMsg;

- (void)startWithCompletionBlock:(void (^)(BaseRequest *request))completionBlock;

@end
