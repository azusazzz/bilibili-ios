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


@property (assign, nonatomic, readonly) DownloadOperationStatus status;

@property (assign, nonatomic, readonly) NSUInteger countSuccess;

@property (assign, nonatomic, readonly) NSUInteger countRuning;

@property (assign, nonatomic, readonly) NSUInteger countWaiting;

@end
