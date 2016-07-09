//
//  SearchResultVC.h
//  bilibili fake
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultVC : UIViewController

-(instancetype)initWithKeywork:(NSString*)keywork;

-(void)setKeywork:(NSString*)keywork;

@end
