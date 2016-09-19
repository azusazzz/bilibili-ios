//
//  UserInfoModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoCardEntity.h"
#import "UserInfoLiveEntity.h"
#import "UserInfoElecEntity.h"

@interface UserInfoModel : NSObject

@property(nonatomic,readonly)NSInteger mid;

@property(nonatomic,strong)UserInfoCardEntity* cardEntity;

@property(nonatomic,strong)UserInfoLiveEntity* liveEntity;//无不显示

@property(nonatomic,strong)UserInfoElecEntity* elecEntity;

-(instancetype)initWithMid:(NSInteger)mid;


-(void)getLiveEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getCardEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getElecEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
