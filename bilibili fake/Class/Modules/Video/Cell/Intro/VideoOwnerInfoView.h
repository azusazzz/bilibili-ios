//
//  VideoOwnerInfoView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoOwnerInfoView : UIView

/**
 *  <#Description#>
 *
 *  @param face    头像
 *  @param name    昵称
 *  @param pubdate 投递时间
 */
- (void)setupFace:(NSString *)face name:(NSString *)name pubdate:(NSTimeInterval)pubdate;

@end
