//
//  ActivityEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityEntity : NSObject

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@property(nonatomic,strong)NSString* link;

@property(nonatomic)NSInteger state;//0进行中 1已结束 准备中：不详

@end
/*
 {
 "title" : "TGS2016之去了没去",
 "state" : 0,
 "cover" : "http:\/\/i1.hdslb.com\/event\/24771327191327145087ac802c5d6d95.jpg",
 "link" : "http:\/\/www.bilibili.com\/html\/activity-TGS2016-m.html"
 }
 */
