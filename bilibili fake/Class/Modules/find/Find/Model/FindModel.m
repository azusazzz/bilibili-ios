//
//  HotWorksModel.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindModel.h"
#import "FindReqiest.h"

@implementation FindModel

-(instancetype)init{
    self = [super init];
    if (self) {
        FindReqiest* request =  [FindReqiest request];
        [request startWithCompletionBlock:^(BaseRequest *request) {
            if (request.responseCode == 0) {
                _hotWorkList = [HotWorkListEntity mj_objectWithKeyValues:request.responseObject];
            }
        }];
    }
    return self;
}


@end
