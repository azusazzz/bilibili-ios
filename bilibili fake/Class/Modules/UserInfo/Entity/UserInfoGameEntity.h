//
//  UserInfoGameEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UGameEntity :NSObject

@property(nonatomic,strong)NSString* image;

@property(nonatomic,strong)NSString* name;

@end


@interface UserInfoGameEntity : NSObject

@property(nonatomic)NSInteger count;

@property(nonatomic,strong)NSMutableArray<UGameEntity*>* games;

@end
/*
{
    "status" : true,
    "data" : {
        "games" : [
                   {
                       "website" : "http:\/\/xsqst.biligame.com\/",
                       "image" : "http:\/\/i2.hdslb.com\/u_user\/b3c01eb5b7d9925e4488f581baef8006.jpg",
                       "name" : "像素骑士团"
                   }
                   ],
        "count" : 1
    }
}
 */