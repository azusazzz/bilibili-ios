//
//  GameEntity.h
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEntity : NSObject

@property(nonatomic)NSInteger id;

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* summary;

@property(nonatomic,strong)NSString* download_link;

@property(nonatomic,strong)NSString* cover;


@end
