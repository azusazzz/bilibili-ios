//
//  AllVideoModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieSummaryEntity.h"
#import "SeasonSummaryEntity.h"
#import "ArchiveSummaryEntity.h"

@interface AllVideoModel : NSObject

@property(nonatomic,strong)NSString* keyword;
@property(nonatomic,strong)NSString* ridName;//分区名字
@property(nonatomic)NSInteger duration;
@property(nonatomic)NSInteger order;



@property(nonatomic,readonly)NSInteger seasonCount;
@property(nonatomic,readonly)NSInteger movieCount;

@property(nonatomic,strong,readonly)NSMutableArray<SeasonSummaryEntity *>* seasonArr;
@property(nonatomic,strong,readonly)NSMutableArray<MovieSummaryEntity *>* movieArr;
@property(nonatomic,strong,readonly)NSMutableArray<ArchiveSummaryEntity *>* archiveArr;



-(void)getSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getMoreSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
