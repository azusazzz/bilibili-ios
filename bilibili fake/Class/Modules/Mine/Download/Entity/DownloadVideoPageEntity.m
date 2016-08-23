//
//  DownloadVideoPageEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoPageEntity.h"
#import "DownloadManager.h"

@interface DownloadVideoPageEntity ()
{
    DownloadOperation *_operation;
}
@end

@implementation DownloadVideoPageEntity

@dynamic operation;

- (DownloadOperation *)operation {
    if (!_operation && _aid > 0 && _cid > 0) {
        _operation = [[DownloadManager manager] operationWithAid:_aid cid:_cid page:_page];
    }
    return _operation;
}

@end
