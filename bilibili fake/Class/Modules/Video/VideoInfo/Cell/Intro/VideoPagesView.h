//
//  VideoPagesView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPageInfoEntity.h"

@interface VideoPagesView : UIView

@property (strong, nonatomic) NSArray<VideoPageInfoEntity *> *pages;

- (void)setupPages:(NSArray *)pages;

@property (copy, nonatomic) void (^onClickPageItem)(NSInteger idx);

@end
