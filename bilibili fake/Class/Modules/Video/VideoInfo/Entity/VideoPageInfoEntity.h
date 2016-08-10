//
//  VideoPageInfoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  视频分集信息
 */
@interface VideoPageInfoEntity : NSObject

@property (assign, nonatomic) NSInteger cid;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSString *part;

@end
