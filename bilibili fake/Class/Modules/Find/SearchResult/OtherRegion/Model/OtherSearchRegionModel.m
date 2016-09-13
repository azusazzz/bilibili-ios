//
//  OtherSearchRegionModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "OtherSearchRegionModel.h"
#import "OtherSearchRegionRequest.h"

#import "SeasonSummaryEntity.h"
#import "UPUserSummaryEntity.h"
#import "MovieSummaryEntity.h"
#import "SpecialSummaryEntity.h"


@implementation OtherSearchRegionModel{
    OtherSearchRegionRequest* otherSearchRegionRequest;
    NSInteger pages;
}
-(instancetype)init{
    if (self = [super init]) {
        otherSearchRegionRequest = [OtherSearchRegionRequest request];
        pages=INTMAX_MAX;
        otherSearchRegionRequest.ps = 20;
        otherSearchRegionRequest.type = 1;
        otherSearchRegionRequest.keyword = @"1";
    }
    return self;
}
-(void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    otherSearchRegionRequest.keyword = keyword;
}
-(void)setType:(NSInteger)type{
    _type = type;
    otherSearchRegionRequest.type = type;
}

-(void)getSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    [otherSearchRegionRequest stop];
    otherSearchRegionRequest.pn = 0;
    _searchResultArr = [[NSMutableArray alloc] init];
    
    [self getMoreSearchResultWithSuccess:success failure:failure];
    
}

-(void)getMoreSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    ++otherSearchRegionRequest.pn;
    if (_searchResultArr.count%otherSearchRegionRequest.ps&&otherSearchRegionRequest.pn>pages)return;
    
    [otherSearchRegionRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            NSMutableArray* arr =[request.responseData objectForKey:@"items"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                switch (_type) {
                    case 1:
                        [_searchResultArr addObject:[SeasonSummaryEntity mj_objectWithKeyValues:obj]];
                        break;
                    case 2:
                        [_searchResultArr addObject:[UPUserSummaryEntity mj_objectWithKeyValues:obj]];
                        break;
                    case 3:
                        [_searchResultArr addObject:[MovieSummaryEntity mj_objectWithKeyValues:obj]];
                        break;
                    case 4:
                        [_searchResultArr addObject:[SpecialSummaryEntity mj_objectWithKeyValues:obj]];
                    default:
                        break;
                }
            }];
            success();
        }else{
            if(failure)failure(request.errorMsg);
        }
    }];
}
@end
