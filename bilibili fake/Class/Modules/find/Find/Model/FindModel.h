//
//  HotWorksModel.h
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotWorkListEntity.h"

@interface FindModel : NSObject

@property(nonatomic,strong)HotWorkListEntity* hotWorkList;

-(void)getHotWorkListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
