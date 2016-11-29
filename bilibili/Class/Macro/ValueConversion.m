//
//  ValueConversion.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ValueConversion.h"

NSInteger IntegerLength(NSInteger integer) {
    NSInteger length = 1;
    while (integer >= 10) {
        integer /= 10;
        length += 1;
    }
    return length;
}

NSString *IntegerToTenThousand(NSInteger integer) {
    if (integer >= 10000) {
        return [NSString stringWithFormat:@"%.1lf万", integer / 10000.0];
    }
    else {
        return [NSString stringWithFormat:@"%ld", integer];
    }
}
