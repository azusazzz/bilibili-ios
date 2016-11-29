//
//  UserInfoCardView.m
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCardView.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>


@implementation UserInfoCardView{
    UIImageView* faceImageView;
    UIButton* privateLetterBtn;
    UIButton* followBtn;
    UILabel* nameLabel;
    UIImageView* sexImageview;
    
    UIButton* followCountBtn;
    UIButton* fansCountBtn;
    
    UIImageView* approveImageView;
    UILabel* officialDescLabel;
    
    UILabel* signLabel;
    
    UIImageView* levelImageView;
    UIView* currentExpView;
    UILabel* currentExpLabel;
}

-(instancetype)init{
    if ([super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self loadSubViews];
        [self loadActions];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
//    UIBezierPath* rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0 , 120 , rect.size.width, rect.size.height - 50)];
//    UIBezierPath* arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(60, 120) radius:44 startAngle:M_PI endAngle:0 clockwise:YES];
//    [rectPath appendPath:arcPath];
//    [ColorWhite(255) setFill];
//    [rectPath fill];
}

-(void)loadActions{
    [followCountBtn addTarget:self action:@selector(onClickFollowCount) forControlEvents:UIControlEventTouchUpInside];
    [fansCountBtn addTarget:self action:@selector(onClickFansCount) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onClickFollowCount{
    _onClickFollowCountBtn?_onClickFollowCountBtn():NULL;
}
-(void)onClickFansCount{
    _onClickFansCountBtn?_onClickFansCountBtn():NULL;
}


-(void)setEntity:(UserInfoCardEntity *)entity{
    if (entity) {
        _entity = entity;
        
        [faceImageView sd_setImageWithURL:[NSURL URLWithString:entity.face]];
        
        nameLabel.text = entity.name;
        [nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([self getTitleWidth:nameLabel]>self.width-175?self.width-175:[self getTitleWidth:nameLabel]));
        }];
        
        if ([entity.sex isEqualToString:@"男"]) {
            sexImageview.image = [UIImage imageNamed:@"space_sex_male"];
        }else if([entity.sex isEqualToString:@"女"]){
            sexImageview.image = [UIImage imageNamed:@"space_sex_female"];
        }else{
            sexImageview.image = [UIImage imageNamed:@"space_sex_sox"];
        }
        
        [followCountBtn setTitle:[NSString stringWithFormat:@"%lu",entity.attentions.count] forState:UIControlStateNormal];
        [followCountBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([self getTitleWidth:followCountBtn.titleLabel]+30));
        }];
        
        [fansCountBtn setTitle:[NSString stringWithFormat:@"%lu",entity.fans] forState:UIControlStateNormal];
        [fansCountBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([self getTitleWidth:fansCountBtn.titleLabel]+30));
        }];
        
        if (entity.approve) {
            approveImageView.image = [UIImage imageNamed:@"space_auth_icon"];
            officialDescLabel.text = entity.officialDesc;
            [approveImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@15);
            }];
        }
        
        
        signLabel.text = entity.sign;
        [signLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@([self getSignLabelHeight]));
        }];
        
        self.height = 220 + [self getSignLabelHeight];
        //等级
        levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"misc_level_whiteLv%lu",entity.current_level]];
        NSArray* arr = @[ColorRGB(177, 177, 177),ColorRGB(177, 177, 177),ColorRGB(133, 216, 163),ColorRGB(130, 199, 223),ColorRGB(253, 163, 105),ColorRGB(252, 85, 8),ColorRGB(251, 0, 7),ColorRGB(219, 0, 231),ColorRGB(111, 0, 247),ColorRGB(0, 0, 0)];
        currentExpView.backgroundColor = arr[entity.current_level];
        currentExpLabel.text = [NSString stringWithFormat:@"%lu/%0.0f",entity.current_exp,entity.next_exp];
        [currentExpView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo( entity.current_exp/entity.next_exp*100);
        }];
    }

}

#pragma 计算Label的宽度
-(CGFloat)getTitleWidth:(UILabel*)label{
   return  [self getTitleWidth:label.text Font:label.font];
}

-(CGFloat)getTitleWidth:(NSString*)text Font:(UIFont*)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width+5;
}

-(CGFloat)getSignLabelHeight{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:signLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [signLabel.text boundingRectWithSize:CGSizeMake(SSize.width - 40 ,MAXFLOAT ) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    //算一下/r/n的数量
    NSInteger count = ([signLabel.text  length] - [[signLabel.text  stringByReplacingOccurrencesOfString:@"\r\n" withString:@""] length])/[@"\r\n" length];
    CGFloat otherHeight = count*[@"" boundingRectWithSize:CGSizeMake(SSize.width - 40 ,MAXFLOAT ) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    
    return size.height+otherHeight+5;
}

#pragma loadSubViews
-(void)loadSubViews{
    
    UIView* backgroundView = ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorWhite(255);
        [self addSubview:view];
        view;
    });
    
    UIView* faceImageBgView = ({
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 84, 84)];
        view.backgroundColor = ColorWhite(255);
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        view.layer.mask = maskLayer;
        [self addSubview:view];
        view;
    });
    
    faceImageView = ({
        UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 80, 80)];
        view.backgroundColor = [UIColor clearColor];
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        view.layer.mask = maskLayer;
        [self addSubview:view];
        view;
    });

    privateLetterBtn = ({
        UIButton* btn = [UIButton new];
        [btn setTitle:@"私信" forState:UIControlStateNormal];
        UIColor *color = ColorRGB(253, 129, 164);
        [btn setTitleColor:color forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setBorderWidth:1.0];
        [btn.layer setCornerRadius:3.0];
        btn.layer.borderColor = color.CGColor;
        [self addSubview:btn];
        btn;
    });
    
    followBtn = ({
        UIButton* btn = [UIButton new];
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        btn.backgroundColor = ColorRGB(253, 129, 164);
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:3.0];
        [self addSubview:btn];
        btn;
    });
    
    nameLabel = ({
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = ColorWhite(50);
        [self addSubview:label];
        label;
    });
    
    sexImageview = ({
        UIImageView* view = [[UIImageView alloc] init];
        [self addSubview:view];
        view;
    });
    
    followCountBtn = ({
        UIButton* btn = [UIButton new];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [btn setTitleColor:ColorWhite(50) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:btn];
        
        UILabel* label = [[UILabel alloc] init];
        label.text = @"关注";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = ColorWhite(150);
        [btn addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(btn);
            make.width.equalTo(@30);
        }];
        
        btn;
    });
    
    
    
    fansCountBtn = ({
        UIButton* btn = [UIButton new];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [btn setTitleColor:ColorWhite(50) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:btn];
        
        UILabel* label = [[UILabel alloc] init];
        label.text = @"关注";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = ColorWhite(150);
        [btn addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(btn);
            make.width.equalTo(@30);
        }];
        
        btn;
    });
    
    approveImageView = ({
        UIImageView* view = [[UIImageView alloc] init];
        [self addSubview:view];
        view;
    });
    officialDescLabel = ({
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = ColorRGB(236, 197, 6);
        [self addSubview:label];
        label;
    });
    
    signLabel = ({
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = ColorWhite(150);
        [self addSubview:label];
        label;
    });
    
    //等级
    levelImageView = ({
        UIImageView* view = [[UIImageView alloc] init];
        [self addSubview:view];
        view;
    });
    
    UIView* currentExpBgView = ({
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight
                                                         cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        view.layer.mask = maskLayer;
        view.layer.masksToBounds =YES;
        view.backgroundColor = ColorWhite(50);
        [self addSubview:view];
        view;
    });
    currentExpView = ({
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
        view.backgroundColor = ColorWhite(50);
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight
                                                         cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        view.layer.mask = maskLayer;
        [currentExpBgView addSubview:view];
        view;
    });

    currentExpLabel = ({
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = ColorWhite(255);
        label.textAlignment = NSTextAlignmentRight;
        [currentExpBgView addSubview:label];
        label;
    });
    
    //layout
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(120);
    }];
    
    [faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(80);
        make.left.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [faceImageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(faceImageView);
        make.size.mas_equalTo(CGSizeMake(84, 84));
    }];
    
    [followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(faceImageBgView.mas_centerY).offset(10);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [privateLetterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(followBtn);
        make.right.equalTo(followBtn.mas_left).offset(-10);
        make.size.mas_equalTo(followBtn);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(faceImageView.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    
    [sexImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(sexImageview.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    
    [currentExpBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel).offset(2);
        make.left.equalTo(levelImageView.mas_right).offset(-1);
        make.size.mas_equalTo(CGSizeMake(100, 10));
    }];
    
    [currentExpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(currentExpBgView);
        make.width.equalTo(currentExpBgView).priorityLow();
    }];
    
    [currentExpLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(currentExpBgView);
        make.right.equalTo(currentExpBgView).offset(-5);
    }];
    
    [followCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];
    
    [fansCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(followCountBtn.mas_right).offset(10);
        make.top.equalTo(followCountBtn).offset(0);
        make.height.equalTo(@20);
    }];
    
    [approveImageView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self).offset(20);
         make.width.equalTo(@10);
         make.top.equalTo(fansCountBtn.mas_bottom).offset(5);
    }];
    [officialDescLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(approveImageView.mas_right).offset(10);
        make.right.equalTo(self).offset(-20);
        make.top.bottom.equalTo(approveImageView);
    }];
    
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(approveImageView.mas_bottom).offset(0);
    }];
    

    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(signLabel).offset(10);
    }];
}
@end
