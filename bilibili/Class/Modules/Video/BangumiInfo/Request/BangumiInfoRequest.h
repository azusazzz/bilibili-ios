//
//  BangumiInfoRequest.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface BangumiInfoRequest : BaseRequest

+ (instancetype)requestWithID:(NSInteger)ID;

@end
