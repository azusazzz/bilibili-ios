//
//  SelectionView.h
//  bilibili fake
//
//  Created by C on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectionDelegate;

@interface SelectionView : UIView

-(instancetype)init;

@property(nonatomic,weak)id<SelectionDelegate> delegate;

@property(nonatomic,strong)NSArray<NSArray<NSString*>*>* itemArrArr;//每个按钮下对应的选择标签文字
@property(nonatomic,strong,readonly)NSMutableArray<NSNumber*> *selectedIndex;//当前选中的标签 0开始


@property(nonatomic,strong)UIView* titleView;
@property(nonatomic,strong)NSMutableArray<UIButton *>* titleBtnArr;

@property(nonatomic,strong)UIView* selectionView;
@property(nonatomic,strong)UIView* backgroundView;

@end

@protocol SelectionDelegate

-(void)selectedIndexDidChange;

@end
