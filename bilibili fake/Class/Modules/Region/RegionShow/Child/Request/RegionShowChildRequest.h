//
//  RegionShowChildRequest.h
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface RegionShowChildRequest : BaseRequest

+ (instancetype)requestWithRid:(NSInteger)rid;

@end
