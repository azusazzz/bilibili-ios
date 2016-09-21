//
//  SubmitVideoCell.h
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoSubmitVideosEntity.h"
#import "UserInfoCoinVideosEntity.h"

@interface SubmitAndCoinVideoCell : UICollectionViewCell

+(CGSize)size;

@property(nonatomic,strong)SubmitVideoEntity* submitVideoEntity;

@property(nonatomic,strong)CoinVideoEntity* coinVideoEntity;

@end
