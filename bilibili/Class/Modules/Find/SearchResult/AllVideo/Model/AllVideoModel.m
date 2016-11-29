//
//  AllVideoModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoModel.h"
#import "AllVideoRequest.h"
#import "TidDictionary.h"

@implementation AllVideoModel{
    AllVideoRequest* allVideoRequest;
}
-(instancetype)init{
    if (self = [super init]) {
        allVideoRequest = [AllVideoRequest request];
        allVideoRequest.ps = 20;
        allVideoRequest.order = @"default";
        allVideoRequest.duration = 0;
        allVideoRequest.rid = 0;
        [self clean];
    }
    return self;
}
-(void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    allVideoRequest.keyword = keyword;
}
-(void)setOrder:(NSInteger)order{
    _order = order;
    switch (order) {
        case 0:
            allVideoRequest.order = @"default";
            break;
         case 1:
            allVideoRequest.order = @"view";
            break;
        case 2:
            allVideoRequest.order = @"pubdate";
            break;
        case 3:
            allVideoRequest.order = @"danmaku";
            break;
        default:
            break;
    }
    [self clean];
}
-(void)setDuration:(NSInteger)duration{
    _duration = duration;
    allVideoRequest.duration = duration;
    [self clean];
}

-(void)setRidName:(NSString *)ridName{
    _ridName = ridName;
    allVideoRequest.rid = [[TidDictionary objectForKey:ridName] integerValue];
    [self clean];
}
-(void)clean{
    _movieArr = [[NSMutableArray alloc] init];
    _seasonArr = [[NSMutableArray alloc] init];
    _archiveArr = [[NSMutableArray alloc] init];
    allVideoRequest.pn = 1;
}

-(void)getSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    [allVideoRequest stop];
    [self clean];
    [allVideoRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _movieCount = [[[request.responseData objectForKey:@"nav"][2] objectForKey:@"total"] integerValue];
            _seasonCount = [[[request.responseData objectForKey:@"nav"][0] objectForKey:@"total"] integerValue];
            
            NSArray<NSDictionary *>* arr =[[request.responseData objectForKey:@"items"] objectForKey:@"movie"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [_movieArr addObject:[MovieSummaryEntity mj_objectWithKeyValues:obj]];
            }];
            
            arr =[[request.responseData objectForKey:@"items"] objectForKey:@"season"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isKindOfClass:[NSNull class]])
                    [_seasonArr addObject:[SeasonSummaryEntity mj_objectWithKeyValues:obj]];
            }];
            
            arr =[[request.responseData objectForKey:@"items"] objectForKey:@"archive"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isKindOfClass:[NSNull class]])
                    [_archiveArr addObject:[ArchiveSummaryEntity mj_objectWithKeyValues:obj]];
            }];
            success();
        }else{
            if(failure)failure(request.errorMsg);
        }
    }];
    
}

-(void)getMoreSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    ++allVideoRequest.pn;
    if (_archiveArr.count%allVideoRequest.ps)return;
    
    [allVideoRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            NSMutableArray* arr =[[request.responseData objectForKey:@"items"] objectForKey:@"archive"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isKindOfClass:[NSNull class]])
                    [_archiveArr addObject:[ArchiveSummaryEntity mj_objectWithKeyValues:obj]];
            }];
            success();
        }else{
            if(failure)failure(request.errorMsg);
        }
    }];
}

@end
