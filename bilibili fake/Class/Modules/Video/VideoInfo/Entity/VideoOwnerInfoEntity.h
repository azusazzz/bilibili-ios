//
//  VideoOwnerInfoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Up主信息
 */
@interface VideoOwnerInfoEntity : NSObject

@property (assign, nonatomic) NSInteger mid;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *face;

@end
