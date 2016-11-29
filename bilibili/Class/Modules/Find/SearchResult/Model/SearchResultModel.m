//
//  SearchResultModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultModel.h"
#import "SearchResultRequest.h"

@implementation SearchResultModel{
    SearchResultRequest *searchResultRequest;
}
-(instancetype)init{
    if (self = [super init]) {
        searchResultRequest = [SearchResultRequest request];
    }
    return self;
}

-(void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    searchResultRequest.keywork = keyword;
}
-(void)addHistoryWord:(NSString*)keyword{
    if (keyword.length == 0)return;
    
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"SearchHistory.plist"];
    
    NSMutableArray* arr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (arr == nil)arr = [[NSMutableArray alloc] init];
    
    [arr removeObject:keyword];
    [arr insertObject:keyword atIndex:0];
    if (arr.count == 6) [arr removeLastObject];
    
    [arr writeToFile:path atomically:YES];
}

-(void)getSearchResultPageinfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    [searchResultRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _seasonCount = [[[request.responseData objectForKey:@"nav"][0] objectForKey:@"total"] integerValue];
            _upuserCount = [[[request.responseData objectForKey:@"nav"][1] objectForKey:@"total"] integerValue];
            _movieCount = [[[request.responseData objectForKey:@"nav"][2] objectForKey:@"total"] integerValue];
            _specialCount = [[[request.responseData objectForKey:@"nav"][3] objectForKey:@"total"] integerValue];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];

}
@end
