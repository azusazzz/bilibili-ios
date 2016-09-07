//
//  GameCenterModel.h
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameListEntity.h"

@interface GameCenterModel : NSObject

@property(nonatomic,strong)GameListEntity* gameList;

-(void)getGameListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
