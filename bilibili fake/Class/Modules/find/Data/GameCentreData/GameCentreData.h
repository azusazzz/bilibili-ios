//
//  GameCentreData.h
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCentreData : NSObject

+(instancetype)share;

-(void)getGamesInfo:(void(^)(NSArray* GamesInfo))block;

@end
