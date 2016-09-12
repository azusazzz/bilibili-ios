//
//  GameListEntity.h
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEntity.h"
@interface GameListEntity : NSObject

@property(nonatomic,strong)NSMutableArray<GameEntity*>* gameList;

@end
