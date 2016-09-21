//
//  UserInfoCoinVideosEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCoinVideosEntity.h"

@implementation CoinVideoEntity

-(NSInteger)danmaku{
    return [[_stat objectForKey:@"danmaku"] integerValue];
}
-(NSInteger)play{
    return [[_stat objectForKey:@"view"] integerValue];
}

@end

@implementation UserInfoCoinVideosEntity

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":NSStringFromClass([CoinVideoEntity class])};
}

@end
