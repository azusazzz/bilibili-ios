//
//  UserInfoCardView.h
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoCardEntity.h"

@interface UserInfoCardView : UIView

+(CGFloat)height;

@property(nonatomic,strong)UserInfoCardEntity* entity;

@end
