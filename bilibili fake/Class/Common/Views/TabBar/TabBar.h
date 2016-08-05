//
//  TabBar.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TabBarStyle) {
    TabBarStyleNormal,
    TabBarStyleScroll
};

@class TabBar;

@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(TabBar *)tabBar didSelectIndex:(NSInteger)index;

@end


@interface TabBar : UIView

@property (assign, nonatomic, readonly) NSInteger currentIndex;


@property (assign, nonatomic, readonly) TabBarStyle style;

/**
 *  0.00 ~ (_items.count-1).00
 */
@property (assign, nonatomic) CGFloat contentOffset;


@property (weak, nonatomic) id<TabBarDelegate> delegate;


@property (copy, nonatomic) void (^onClickItem)(NSInteger index);

/**
 *  Default  UIEdgeInsetsZero
 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/**
 *  按钮色调  RGB   @[@255, @255, @255]
 */
@property (strong, nonatomic) NSArray<NSNumber *> *tintColorRGB;
/**
 *  选中按钮的色调
 */
@property (strong, nonatomic) NSArray<NSNumber *> *selTintColorRGB;

/**
 *  间距
 */
@property (assign, nonatomic) CGFloat spacing;


- (instancetype)initWithTitles:(NSArray<NSString *> *)titles style:(TabBarStyle)style;

- (void)setTitle:(NSString *)title forIndex:(NSInteger)index;



@end
