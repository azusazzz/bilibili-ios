//
//  TabBar.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TabBarStyle) {
    TabBarStyleScroll
};

@class TabBar;

@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(TabBar *)tabBar didSelectIndex:(NSInteger)index;

@end


@interface TabBar : UIView

@property (assign, nonatomic, readonly) NSInteger currentIndex;

@property (assign, nonatomic) TabBarStyle style;

/**
 *  0.0 ~ 1.0
 */
@property (assign, nonatomic) CGFloat contentOffset;


@property (weak, nonatomic) id<TabBarDelegate> delegate;


@property (copy, nonatomic) void (^onClickItem)(NSInteger index);


@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/**
 *  色调  RGB   @[@255, @255, @255]
 */
@property (strong, nonatomic) NSArray<NSNumber *> *tintColorRGB;

/**
 *  间距
 */
@property (assign, nonatomic) CGFloat spacing;


- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

- (void)setTitle:(NSString *)title forIndex:(NSInteger)index;



@end
