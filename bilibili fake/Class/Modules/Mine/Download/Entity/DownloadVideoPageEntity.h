//
//  DownloadVideoPageEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadOperation.h"

@interface DownloadVideoPageEntity : NSObject

@property (assign, nonatomic) NSInteger cid;

@property (strong, nonatomic) NSString *part;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSString *filePath;

@property (strong, nonatomic, readonly) DownloadOperation *operation;

@end
