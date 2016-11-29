//
//  LiveListEntranceEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListEntranceEntity.h"

@implementation LiveListEntranceEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName; {
    return @{@"src": @"entrance_icon.src",
             @"height": @"entrance_icon.height",
             @"width": @"entrance_icon.width"};
}

@end
