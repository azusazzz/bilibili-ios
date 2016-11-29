//
//  HotWorksModel.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindModel.h"
#import "FindRequest.h"

@implementation FindModel

-(instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}
-(void)getHotWorkListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    FindRequest* request =  [FindRequest request];
    [request startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _hotWorkList = [HotWorkListEntity mj_objectWithKeyValues:request.responseObject];
            _hotWorkList.hotWorkStrList = [[NSMutableArray alloc] init];
            [_hotWorkList.hotWorkList enumerateObjectsUsingBlock:^(HotWorkEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_hotWorkList.hotWorkStrList addObject:obj.keyword];
            }];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}

@end
