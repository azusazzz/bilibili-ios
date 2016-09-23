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
#import "UserInfoSubmitVideosEntity.h"
#import "UserInfoCoinVideosEntity.h"
#import "UserInfoFavoritesEntity.h"
#import "UserInfoBangumiEntity.h"
#import "UserInfoGameEntity.h"

@interface UserInfoModel : NSObject

@property(nonatomic,readonly)NSInteger mid;

@property(nonatomic,strong)UserInfoCardEntity* cardEntity;

@property(nonatomic,strong)UserInfoLiveEntity* liveEntity;//无不显示

@property(nonatomic,strong)UserInfoElecEntity* elecEntity;

@property(nonatomic,strong)UserInfoSubmitVideosEntity* submitVideosEntity;

@property(nonatomic,strong)UserInfoCoinVideosEntity* coinVideosEntity;

@property(nonatomic,strong)NSMutableArray<UserInfoFavoritesEntity*>* favoritesEntityArr;

@property(nonatomic,strong)UserInfoBangumiEntity* bangumiEntity;

@property(nonatomic,strong)UserInfoGameEntity* gameEntity;


-(instancetype)initWithMid:(NSInteger)mid;


-(void)getLiveEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getCardEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getElecEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getSubmitVideosEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getCoinVideosEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getFavoritesEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getBangumiEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getGameEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
