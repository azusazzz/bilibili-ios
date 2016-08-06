//
//  LiveListModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveListEntity.h"


@interface LiveListModel : NSObject

@property (strong, nonatomic) LiveListEntity *liveList;

- (void)getLiveListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
