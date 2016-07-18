//
//  VideoViewController.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 视频播放页面
 */
@interface VideoViewController : UIViewController

/**
 *  初始化
 *
 *  @param aid AV号
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithAid:(NSInteger)aid;

@end
