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


@property(nonatomic,assign)  NSInteger Selectedtag;
//返回选择按钮的指针
-(UIButton*)getSelected_button;



/**
 *  初始化
 *
 *  @param titles 标题数组
 *  @param block  点击回调
 *
 *  @return RowBotton
 */
- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles  Block:(void(^)(NSInteger btnTag))block;

/**
 *  初始化
 *
 *  @param titles 标题数组
 *  @param style  按钮样式
 *  @param block  点击回调
 *
 *  @return RowBotton
 */
- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles Style:(RowBottonStyle)style  Block:(void(^)(NSInteger btnTag))block;

/**
 *  0.00 ~ (_items.count-1).00
 */
@property (assign, nonatomic) CGFloat contentOffset;
/**
 *  重新设置标题数组
 *
 *  @param titles 标题数组
 */
- (void)setTitles:(NSMutableArray<NSString *> *)titles;

/**
 *  设置选中返回
 *
 *  @param block block
 */
- (void)setSelecteBlock:(void(^)(NSInteger btnTag))block;

/**
 *  设置间距
 */
- (void)setSpacing:(NSInteger)spacing;

/**
 *  设置选择的按钮
 *
 *  @param tag tag
 */
-(void)setSelectedBotton:(NSInteger)tag;


- (void)setFont:(UIFont*)font;

//- (void)setStyle:(RowBottonStyle)style;

@end
