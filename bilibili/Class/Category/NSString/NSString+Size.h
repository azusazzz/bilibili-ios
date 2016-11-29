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

/**
 *  计算文本显示的宽度
 *
 *  @param font      字体
 *  @param maxHeight 最大高度
 *
 *  @return 宽度
 */
- (CGFloat)widthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;

@end
