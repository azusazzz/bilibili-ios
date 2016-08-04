//
//  DownloadModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadEntity.h"

@interface DownloadModel : NSObject

@property (strong, nonatomic, readonly) NSArray<DownloadEntity *> *list;


+ (instancetype)sharedInstance;

- (void)downloadVideo:(DownloadEntity *)download;


@end
