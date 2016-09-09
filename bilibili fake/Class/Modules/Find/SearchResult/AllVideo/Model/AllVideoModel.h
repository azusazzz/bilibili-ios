//
//  AllVideoModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllVideoModel : NSObject

@property(nonatomic,strong)NSString* ridName;

@property(nonatomic)NSInteger duration;

@property(nonatomic)NSInteger order;


@property(nonatomic,strong,readonly)NSMutableArray<NSDictionary *>*videoArr;

-(void)getSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getMoreSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
