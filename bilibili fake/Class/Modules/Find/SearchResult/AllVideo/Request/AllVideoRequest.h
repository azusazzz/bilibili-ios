//
//  AllVideoRequest.h
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"

@interface AllVideoRequest : BaseRequest

@property(nonatomic,strong)NSString* keyword;

@property(nonatomic)NSInteger duration;//0(全部时长) 1(1-10分钟) 2 3

@property(nonatomic,strong)NSString* order;//排序方式 default（默认） view（播放多） pubdate(新发布) danmaku（弹幕多）

@property(nonatomic)NSInteger rid;//分区号

@property(nonatomic)NSInteger pn;//第几页

@property(nonatomic)NSInteger ps;//一页有几个数据

@end
