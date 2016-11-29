//
//  AllVideoViewController.h
//  bilibili fake
//
//  Created by C on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllVideoViewControllerDelegate;

@interface AllVideoViewController : UIViewController

@property(nonatomic,weak)id<AllVideoViewControllerDelegate> delegate;

-(instancetype)initWithKeyword:(NSString*)keyword;

@end

@protocol AllVideoViewControllerDelegate <NSObject>
@optional
-(void)findMoreMovie;
-(void)findMoreSeason;
@end