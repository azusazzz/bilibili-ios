//
//  BannerView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView

/**
 *  Default 4.0
 */
@property (assign, nonatomic) NSTimeInterval scrollTimeInterval;

@property (copy, nonatomic) NSArray<NSURL *> *urls;

@property (strong, nonatomic) void (^onClickBannerItem)(NSUInteger index);

@end
