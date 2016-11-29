//
//  StartInfoEntity.m
//  bilibili fake
//
//  Created by cxh on 16/9/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "StartInfoEntity.h"

@implementation StartInfoEntity
+(NSDictionary *)mj_objectClassInArray{
    return @{@"startPages":NSStringFromClass([StartPageEntity class])};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    // 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
    return @{@"startPages" : @"data"};
}
@end
