//
//  UserInfoElecView.m
//  bilibili fake
//
//  Created by cxh on 16/9/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoElecView.h"
#import <UIImageView+WebCache.h>

@implementation UserInfoElecView{
    
    UIImageView* imageView;
    UILabel* pianQianLabel;
    UILabel* elecTotalCountLabel;
    UIButton* pianQianBtn;
    
    UIImageView* payUser1ImageView;
    UIImageView* payUser2ImageView;
    UIImageView* payUser3ImageView;
    UILabel* elecCountLabel;
    UIButton* morePayUserBtn;
}
-(instancetype)init{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, SSize.width-20, 150)]) {
        self.backgroundColor = [UIColor clearColor];
        
        imageView = ({
            UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_battery_power_ico"]];
            [self addSubview:view];
            view;
        });
        
        pianQianLabel = ({
            UILabel* label  = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"快给我更多的钱";
            label.textColor = CRed;
            [self addSubview:label];
            label;
        });
        
        elecTotalCountLabel = ({
            UILabel* label  = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = CRed;
            [self addSubview:label];
            label;
        });
        
        pianQianBtn = ({
            UIButton* btn = [[UIButton alloc] init];
            [btn setTitle:@"给钱" forState:UIControlStateNormal];
            btn.backgroundColor = ColorRGB(253, 129, 164);
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [self addSubview:btn];
            btn;
        });
        
        payUser1ImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 10.0;
            [self addSubview:view];
            view;
        });
        payUser2ImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 10.0;
            [self addSubview:view];
            view;
        });
        payUser3ImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 10.0;
            [self addSubview:view];
            view;
        });
        
        elecCountLabel = ({
            UILabel* label  = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"更多的充值更多的力量";
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = CRed;
            [self addSubview:label];
            label;
        });
        
        morePayUserBtn = ({
            UIButton* btn = [UIButton new];
            [btn setTitle:@"查看榜单" forState:UIControlStateNormal];
            UIColor *color = ColorRGB(253, 129, 164);
            [btn setTitleColor:color forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setCornerRadius:5.0];
            btn.layer.borderColor = ColorWhite(200).CGColor;
            [self addSubview:btn];
            btn;
        });
        
        //layout
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(55, 80));
        }];
        [pianQianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(45);
            make.size.mas_equalTo(CGSizeMake(70, 35));
        }];
        
        [pianQianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pianQianBtn);
            make.left.equalTo(imageView.mas_right);
            make.right.equalTo(pianQianBtn.mas_left);
            make.bottom.equalTo(elecTotalCountLabel.mas_top);
        }];
        
        [elecTotalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right);
            make.right.equalTo(pianQianBtn.mas_left);
            make.height.equalTo(@0).priorityLow();
            make.bottom.equalTo(pianQianBtn);
        }];
        
        [payUser1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.width.equalTo(@(0)).priorityLow();
            make.bottom.equalTo(self).offset(-15);
            make.height.equalTo(@20);
        }];
        [payUser2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(payUser1ImageView.mas_right).offset(0);
            make.width.equalTo(@(0)).priorityLow();
            make.bottom.equalTo(self).offset(-15);
            make.height.equalTo(@20);
        }];
        [payUser3ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(payUser2ImageView.mas_right).offset(0);
            make.width.equalTo(@(0)).priorityLow();
            make.bottom.equalTo(self).offset(-15);
            make.height.equalTo(@20);
        }];
        
        [elecCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(payUser3ImageView.mas_right).offset(0);
            make.right.equalTo(morePayUserBtn.mas_left).offset(0);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@30);
        }];
        
        [morePayUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self).offset(-10);
            make.width.equalTo(@(70)).priorityLow();
            make.height.equalTo(@30);
        }];
        
    }
    return self;
}

-(void)setEntity:(UserInfoElecEntity *)entity{
    _entity = entity;
    
    if (entity == nil) {
        for(UIView *view in [self subviews])[view removeFromSuperview];//移除以前的按钮
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    if (entity.total_count) {
        elecTotalCountLabel.text = [NSString stringWithFormat:@"已有%lu人上当受骗",entity.total_count];
        [elecTotalCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
        }];
    }
    if (entity.count) {
        if (entity.list.count>0){
            [payUser1ImageView sd_setImageWithURL:[NSURL URLWithString:entity.list[0].avatar]];
            [payUser1ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@20);
            }];
        }
        if (entity.list.count>1) {
            [payUser2ImageView sd_setImageWithURL:[NSURL URLWithString:entity.list[1].avatar]];
            [payUser2ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@20);
            }];
        }
        if (entity.list.count>2) {
            [payUser3ImageView sd_setImageWithURL:[NSURL URLWithString:entity.list[2].avatar]];
            [payUser3ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@20);
            }];
        }
        NSString* str = [NSString stringWithFormat:@"等%lu人本月上当受骗",entity.count];
        NSString* subStr = [NSString stringWithFormat:@"%lu人",entity.count];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:ColorWhite(100)
                              range:NSMakeRange(0, str.length)];
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:CRed
                              range:[str rangeOfString:subStr]];
        [elecCountLabel setAttributedText:attributedStr];
        
        [morePayUserBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(70));
        }];
        
    }else{
        [morePayUserBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    }
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(5, 30, rect.size.width-10, rect.size.height-30) cornerRadius:10];
    [CRed setStroke];
    [ColorWhite(255) setFill];
    [path fill];
    [path stroke];
    
    UIBezierPath* path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(5, 100)];
    [path2 setLineWidth:0.5];
    [path2 addLineToPoint:CGPointMake(rect.size.width - 5, 100)];
    [ColorWhite(200) setStroke];
    [path2 stroke];
}

@end
