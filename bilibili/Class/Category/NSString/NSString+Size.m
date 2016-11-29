//
//  NSString+Size.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGFloat)widthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight {
    return [self boundingRectWithSize:CGSizeMake(9999, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:NULL].size.width;
}

@end
