//
//  DownloadManager.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/3.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadOperation.h"


@interface DownloadManager : NSObject

@property (strong, nonatomic, readonly) NSArray<DownloadOperation *> *operations;

+ (instancetype)manager;

- (DownloadOperation *)operationWithURL:(NSURL *)url;

- (DownloadOperation *)operationWithAid:(NSInteger)aid cid:(NSInteger)cid page:(NSInteger)page;

@end
