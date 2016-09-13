//
//  VideoRankModel.h
//  bilibili fake
//
//  Created by C on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankingVideoEntity.h"
@interface VideoRankModel : NSObject

@property(nonatomic,strong)NSMutableArray<RankingVideoEntity *>* videoRanking;

-(void)getvideoRankingWithTitle:(NSString*)title success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
