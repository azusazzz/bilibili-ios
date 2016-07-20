//
//  SearchAnimateView.m
//  bilibili fake
//
//  Created by cxh on 16/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchAnimateView.h"

@implementation SearchAnimateView{
        
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //self.backgroundColor = [UIColor redColor];
        [self loadSubviews];
        [self noResult];
    }
    return self;
}
#pragma loadActions
-(void)inSearch{
    [_animateView stopAnimating];
    _animateView.animationDuration = 1.0;//设置动画总时间
    _animateView.animationRepeatCount= -1; //设置重复次数，0表示不重复
    _animateView.animationImages=[NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"common_loading_loading_1"],
                                  [UIImage imageNamed:@"common_loading_loading_2"],nil];
    [_animateView startAnimating];
    
    _label.text = @"搜索中...";
}


-(void)noResult{
    [_animateView stopAnimating];
    _animateView.image = [UIImage imageNamed:@"common_loading_noData"];
    _label.text = @"什么都没有找到啊T T";
}

#pragma loadSubviews
-(void)loadSubviews{
    //动画
    _animateView = [[UIImageView alloc] init];
    [self addSubview:_animateView];
    
    
    //标签
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = ColorRGB(100, 100, 100);
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
     // Layout
    [_animateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
        make.top.equalTo(self.mas_centerY);
    }];

}
@end
