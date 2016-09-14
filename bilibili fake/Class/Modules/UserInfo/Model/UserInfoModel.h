//
//  UserInfoModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoCardEntity.h"
@interface UserInfoModel : NSObject

@property(nonatomic,readonly)NSInteger mid;

@property(nonatomic,strong)UserInfoCardEntity* cardEntity;

-(instancetype)initWithMid:(NSInteger)mid;


-(void)getCardEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
