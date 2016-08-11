//
//  DanmakuRequest.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface DanmakuRequest : BaseRequest

+ (instancetype)requestWithCid:(NSInteger)cid;

@end
