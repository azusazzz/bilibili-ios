//
//  DownloadEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadOperation.h"

@class DownloadItemEntity;

@interface DownloadEntity : NSObject

@property (assign, nonatomic) NSInteger aid;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *pic;

@property (strong, nonatomic) NSArray<DownloadItemEntity *> *items;

@end


@interface DownloadItemEntity : NSObject

@property (assign, nonatomic) NSInteger cid;

@property (strong, nonatomic) NSString *part;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSString *filePath;

@property (strong, nonatomic) DownloadOperation *operation;

@end