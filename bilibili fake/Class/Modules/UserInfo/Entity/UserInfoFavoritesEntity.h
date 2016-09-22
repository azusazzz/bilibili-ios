//
//  UserInfoFavoritesEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesVideoEntity : NSObject

@property(nonatomic,strong)NSString* pic;

@property(nonatomic)NSInteger aid;

@end




@interface UserInfoFavoritesEntity : NSObject

@property(nonatomic,strong)NSString* name;

@property(nonatomic)NSInteger cur_count;

@property(nonatomic)NSInteger fid;//应该是个比较重要的东西

@property(nonatomic,strong)NSMutableArray<FavoritesVideoEntity*>* videos;

@end
/*
{
    "data" : [
              {
                  "state" : 0,
                  "ctime" : 1470373431,
                  "videos" : [
                              {
                                  "aid" : 5684886,
                                  "pic" : "http:\/\/i0.hdslb.com\/bfs\/archive\/d8fd3c986b02a2a5bfcee858db980b4397cd4c25.jpg"
                              }
                              ],
                  "mid" : 37268498,
                  "cur_count" : 1,
                  "fid" : 34594619,
                  "atten_count" : 0,
                  "name" : "默认收藏夹",
                  "max_count" : 200
              }
              ],
    "code" : 0
}*/