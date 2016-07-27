//
//  HomeRecommendEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeRecommendBodyEntity;
@class HomeRecommendBannerEntity;

@interface HomeRecommendEntity : NSObject

@property (strong, nonatomic) NSString *param;

@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSString *style;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSArray<HomeRecommendBodyEntity *> *body;

@property (strong, nonatomic) NSArray<HomeRecommendBannerEntity *> *banner_top;

@property (strong, nonatomic) NSArray<HomeRecommendBannerEntity *> *banner_bottom;


@end

@interface HomeRecommendBodyEntity : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *cover;

@property (strong, nonatomic) NSString *uri;

@property (strong, nonatomic) NSString *param;

@property (strong, nonatomic) NSString *_goto;

@property (assign, nonatomic) NSInteger play;

@property (assign, nonatomic) NSInteger danmaku;

@end


@interface HomeRecommendBannerEntity : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *image;

@property (strong, nonatomic) NSString *_hash;

@property (strong, nonatomic) NSString *uri;

@end

