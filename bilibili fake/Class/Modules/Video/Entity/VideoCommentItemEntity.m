//
//  VideoCommentItemEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentItemEntity.h"

@implementation VideoCommentItemEntity

+ (NSDictionary *)mj_objectClassInArray; {
    return @{@"reply": NSStringFromClass([VideoCommentItemEntity class])};
}

@end
