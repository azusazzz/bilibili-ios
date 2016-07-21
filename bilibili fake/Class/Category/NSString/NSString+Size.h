//
//  NSString+Size.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

- (CGFloat)widthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;

@end
