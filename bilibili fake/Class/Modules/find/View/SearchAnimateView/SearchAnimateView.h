//
//  SearchAnimateView.h
//  bilibili fake
//
//  Created by cxh on 16/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAnimateView : UIView

@property(nonatomic,strong)UIImageView* animateView;

@property(nonatomic,strong)UILabel* label;

-(void)inSearch;

-(void)noResult;

-(void)eorro:(NSInteger)code;

-(void)hide;

@end
