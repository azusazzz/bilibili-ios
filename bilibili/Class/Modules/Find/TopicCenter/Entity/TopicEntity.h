//
//  TopicEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicEntity : NSObject

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@property(nonatomic,strong)NSString* link;

@end
/*
 {
 "title" : "童年不是这些真是太好了—毁童年游戏慎点",
 "cover" : "http:\/\/i0.hdslb.com\/group1\/M00\/B7\/FE\/oYYBAFfWNPSATgKfAAO9pgN41xY655.jpg",
 "link" : "http:\/\/www.bilibili.com\/topic\/v2\/phone1508.html"
 }
 */
