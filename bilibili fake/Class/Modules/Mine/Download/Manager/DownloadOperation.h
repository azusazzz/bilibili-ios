//
//  DownloadOperation.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/3.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, DownloadOperationStatus) {
    DownloadOperationStatusNone,
    DownloadOperationStatusWaiting,
    DownloadOperationStatusRuning,
    DownloadOperationStatusPause,
    DownloadOperationStatusSuccess,
    DownloadOperationStatusFailure,
};


@interface DownloadOperation : NSObject

@property (strong, nonatomic, readonly, nonnull) NSURL *url;

@property (assign, nonatomic, readonly) DownloadOperationStatus status;

@property (assign, nonatomic, readonly) unsigned long long countOfBytesReceived;

@property (assign, nonatomic, readonly) unsigned long long countOfBytesExpectedToReceive;

@property (assign, nonatomic, readonly) unsigned long long speed;

@property (strong, nonatomic, nonnull) NSString *downloadDirectory;

- (nonnull instancetype)initWithURL:(nonnull NSURL *)url session:(nonnull NSURLSession *)session queue:(nonnull NSOperationQueue *)queue;

- (void)resume;

- (void)pause;

- (void)stop;

- (void)receiveData:(nonnull NSData *)data;

- (void)completeWithError:(nullable NSError *)error;

@end



@interface NSURLSessionTask (Download)

@property (weak, nonatomic, nullable) DownloadOperation *operation;

@end