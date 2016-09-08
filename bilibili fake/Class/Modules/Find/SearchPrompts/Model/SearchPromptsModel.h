//
//  SearchPromptsModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchPromptsModel : NSObject

@property(nonatomic,strong,readonly)NSMutableArray<NSString *>* promptsWordArr;

@property(nonatomic,strong,readonly)NSMutableArray<NSString *>* historyWordArr;

-(void)getPromptsWordArrWithKeyWord:(NSString*)keyword  success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)removeAllHistoryWord;
@end
