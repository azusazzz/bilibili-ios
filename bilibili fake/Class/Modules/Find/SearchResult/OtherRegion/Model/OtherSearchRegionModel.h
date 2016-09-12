//
//  OtherSearchRegionModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherSearchRegionModel : NSObject

@property(nonatomic)NSInteger type;

@property(nonatomic,strong)NSString* keyword;

@property(nonatomic,strong,readonly)NSMutableArray* searchResultArr;

-(void)getSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getMoreSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
