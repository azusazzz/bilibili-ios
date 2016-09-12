//
//  OtherSearchRegion.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface OtherSearchRegionRequest : BaseRequest

@property(nonatomic,strong)NSString* keyword;

@property(nonatomic)NSInteger type;

@property(nonatomic)NSInteger ps;//一页有几个数据

@property(nonatomic)NSInteger pn;//第几页

@end
