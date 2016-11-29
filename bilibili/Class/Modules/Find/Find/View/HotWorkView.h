//
//  HotWorkView.h
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"

@interface HotWorkView : UIView

@property(nonatomic,strong)UILabel* label;

@property(nonatomic,strong)JCTagListView *hotWorkListView;

@property(nonatomic,strong)UIButton* openSwitchBtn;

@property(nonatomic)BOOL isOpen;
-(void)updateColor;

@end
