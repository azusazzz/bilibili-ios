//
//  RegionShowChildRequest.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowChildRequest.h"


@interface RegionShowChildRequest ()

@property (assign, nonatomic) NSInteger rid;

@end

@implementation RegionShowChildRequest

+ (instancetype)requestWithRid:(NSInteger)rid {
    RegionShowChildRequest *request = [RegionShowChildRequest request];
    request.rid = rid;
    return request;
}

- (NSString *)URLString; {
    return @"http://app.bilibili.com/x/v2/region/show/child";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSObject *)parameters {
    return @{@"rid": @(_rid), @"build": @3600};
}

@end
