//
//  UserInfoLiveView.h
//  bilibili fake
//
//  Created by cxh on 16/9/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoLiveEntity.h"

@interface UserInfoLiveView : UIView

@property(nonatomic,strong)void (^onClickPlay)(void);

@property(nonatomic,strong)UserInfoLiveEntity* entity;

@end
