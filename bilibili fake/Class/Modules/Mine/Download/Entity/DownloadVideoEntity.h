//
//  DownloadVideoEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadVideoPageEntity.h"

@interface DownloadVideoEntity : NSObject

@property (assign, nonatomic) NSInteger aid;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *pic;

@property (strong, nonatomic, readonly) NSMutableArray<DownloadVideoPageEntity *> *pages;

//- (void)insertPages:(NSArray<DownloadVideoPageEntity *> *)pages;

@end
