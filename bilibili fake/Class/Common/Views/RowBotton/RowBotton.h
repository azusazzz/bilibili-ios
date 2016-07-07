//
//  RowBotton.h
//  bilibili fake
//
//  Created by cxh on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RowBottonStyle) {
    RowBottonDefaultStyle,//下面有红线的
    RowBottonStyle2//选中有红色边框的
};

@interface RowBotton : UIView

- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles  Block:(void(^)(NSInteger btnTag))block;

- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles Style:(RowBottonStyle)style  Block:(void(^)(NSInteger btnTag))block;

- (void)setTitles:(NSMutableArray<NSString *> *)titles;

//- (void)setFont:(UIFont*)font;

//- (void)setStyle:(RowBottonStyle)style;

@end
