//
//  SearchResultModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

-(void)addHistoryWord:(NSString*)keyword;

-(void)getSearchResultPageinfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@property(nonatomic,strong)NSString* keyword;

@property(nonatomic,readonly)NSInteger seasonCount;
@property(nonatomic,readonly)NSInteger movieCount;
@property(nonatomic,readonly)NSInteger upuserCount;
@property(nonatomic,readonly)NSInteger specialCount;

@end
