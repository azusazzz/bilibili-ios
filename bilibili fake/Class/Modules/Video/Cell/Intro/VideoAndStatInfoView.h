//
//  VideoAndStatInfoView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoAndStatInfoView : UIView


/**
 *  <#Description#>
 *
 *  @param title         标题
 *  @param viewCount     播放数量
 *  @param danmakuCount  弹幕数量
 *  @param desc          描述
 *  @param favoriteCount 收藏数量
 *  @param coinCount     硬币数量
 *  @param shareCount    分享数量
 */
- (void)setupTitle:(NSString *)title viewCount:(NSInteger)viewCount danmakuCount:(NSInteger)danmakuCount desc:(NSString *)desc favorite:(NSInteger)favoriteCount coin:(NSInteger)coinCount share:(NSInteger)shareCount;

@end
