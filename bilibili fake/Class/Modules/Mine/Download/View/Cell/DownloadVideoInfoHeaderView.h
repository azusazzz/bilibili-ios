//
//  DownloadVideoInfoHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadVideoInfoHeaderView : UICollectionReusableView

@property (strong, nonatomic, readonly) UILabel *titleLabel;

@property (strong, nonatomic) void (^handleTap)(void);

+ (CGFloat)height;

@end
