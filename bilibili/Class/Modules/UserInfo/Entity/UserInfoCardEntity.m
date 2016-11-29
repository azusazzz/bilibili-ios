//
//  UserInfoCardEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCardEntity.h"

@implementation UserInfoCardEntity

-(NSInteger)current_level{
    NSInteger i = [[_level_info objectForKey:@"current_level"] integerValue];
    if (i<0&&i>9)  return 0;
    return i;
}

-(NSInteger)current_exp{
    NSInteger i = [[_level_info objectForKey:@"current_exp"] integerValue];
    if (i<0)  return 0;
    return i;
}

-(CGFloat)next_exp{
    CGFloat i = [[_level_info objectForKey:@"next_exp"] floatValue];
    return i<self.current_exp?self.current_exp:i;
}

-(NSString*)officialDesc{
    return [_official_verify objectForKey:@"desc"];
}

@end
