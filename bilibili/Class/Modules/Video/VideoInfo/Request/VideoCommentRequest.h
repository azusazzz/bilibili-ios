//
//  VideoCommentRequest.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface VideoCommentRequest : Request

+ (instancetype)requestWithAid:(NSInteger)aid;

- (BOOL)nextPageWithCompletionBlock:(void (^)(__kindof VideoCommentRequest *request))completionBlock;

@end
