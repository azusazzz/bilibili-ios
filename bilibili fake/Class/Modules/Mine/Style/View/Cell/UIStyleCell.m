//
//  UIStyleCell.m
//  bilibili fake
//
//  Created by cxh on 16/8/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIStyleCell.h"
#import "UIStyleMacro.h"
#import "Macro.h"

@implementation UIStyleCell{
    NSDictionary* dataDic;
    
    UIButton *selectionbotton;
    UILabel *styleNameLabel;
    UILabel *selectionLabel;
}

-(instancetype)initWithIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        dataDic = [UIStyleMacro share].uiStyleDataArr[index];
        [self loadSubviews];
    }
    return self;
}




-(void)loadSubviews{
    
    selectionbotton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:selectionbotton];
    [selectionbotton.layer setBorderWidth:0.2];
    [selectionbotton.layer setBorderColor:[UIColor grayColor].CGColor];
    [selectionbotton.layer setCornerRadius:10.0];
    selectionbotton.backgroundColor = [UIColor whiteColor];
    
    styleNameLabel = [UILabel new];
    styleNameLabel.text = [dataDic objectForKey:@"styleName"];
    styleNameLabel.textAlignment = NSTextAlignmentLeft;
    styleNameLabel.font = UIStyleFont_1;
    styleNameLabel.textColor = [dataDic objectForKey:@"styleNameLabelColor"];
    [self addSubview:styleNameLabel];
    
    selectionLabel = [UILabel new];
    selectionLabel.font = UIStyleFont_1;
    selectionLabel.textAlignment = NSTextAlignmentCenter;
    selectionLabel.backgroundColor = CRed;
    selectionLabel.layer.masksToBounds = YES;
    [selectionLabel.layer setCornerRadius:5.0];
    selectionLabel.textColor = [UIColor whiteColor];
    selectionLabel.text = @"使用";
    [self addSubview:selectionLabel];
    //判断是否是当前选择的主题风格
    if ([UIStyleName isEqualToString:[dataDic objectForKey:@"styleName"]]) {
        [selectionbotton setImage:[UIImage imageNamed:@"download_complete"] forState:UIControlStateNormal];
         selectionbotton.backgroundColor = UIStyleBackgroundColor;
         selectionbotton.tintColor = UIStyleColourBtnColor;
        
         selectionLabel.text = @"使用中";
         selectionLabel.backgroundColor = ColorRGB(200, 200, 200);
         selectionLabel.textColor = [UIColor whiteColor];
    }
    

    //layout
    [selectionbotton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self).offset(10);
    }];
    
    [styleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(selectionbotton.mas_right).offset(10);
        make.height.equalTo(@20);
    }];
    
    [selectionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(styleNameLabel.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@35);
        make.width.equalTo(@60);
    }];
    
}
@end
