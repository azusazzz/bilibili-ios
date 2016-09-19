//
//  UserInfoElecEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UserInfoElecPayuserEntity;
@interface UserInfoElecEntity : NSObject

@property(nonatomic)NSInteger count;
@property(nonatomic)NSInteger total_count;
@property(nonatomic)NSArray<UserInfoElecPayuserEntity *>* list;

@end


@interface UserInfoElecPayuserEntity : NSObject

@property(nonatomic,strong)NSString* avatar;
@property(nonatomic,strong)NSString* message;
@property(nonatomic,strong)NSString* uname;

@property(nonatomic)NSInteger rank;
@property(nonatomic)NSInteger pay_mid;

@end

//{"code":500011,"msg":"mid cant support"}//不支持充电的返回
/*
{
    "data" : {
        "count" : 48,
        "total_count" : 517,
        "list" : [
                  {
                      "avatar" : "http:\/\/i0.hdslb.com\/bfs\/face\/e94d45cba9de745edab4f5265a6a77ab0249377c.jpg",
                      "mid" : 893053,
                      "msg_deleted" : 0,
                      "message" : "支持一可！",
                      "rank" : 1,
                      "uname" : "血狱年华",
                      "pay_mid" : 1467950
                  },
                  {
                      "avatar" : "http:\/\/i2.hdslb.com\/bfs\/face\/bdb5e09d6315ea24694483b3e167f6fe13f164c1.jpg",
                      "mid" : 893053,
                      "msg_deleted" : 0,
                      "message" : "",
                      "rank" : 2,
                      "uname" : "极北冬狼",
                      "pay_mid" : 4798662
                  }
                  ]
    },
    "code" : 0
}
*/