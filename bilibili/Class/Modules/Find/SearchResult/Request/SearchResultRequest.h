//
//  SearchResultModel.h
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface SearchResultRequest : BaseRequest
@property(nonatomic,strong)NSString* keywork;
@end
