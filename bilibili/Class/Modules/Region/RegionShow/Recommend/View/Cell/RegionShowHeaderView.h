//
//  RegionShowHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/31.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionShowHeaderView : UICollectionReusableView

@property (strong, nonatomic) UIImageView *leftImageView;

@property (strong, nonatomic) UILabel     *leftTitleLabel;

+ (CGFloat)height;

@end
