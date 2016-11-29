//
//  VideoRequest.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface VideoRequest : BaseRequest

+ (instancetype)requestWithAid:(NSInteger)aid;

@end
