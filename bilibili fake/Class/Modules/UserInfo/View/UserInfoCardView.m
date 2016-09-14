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

//没详细判断官方帐号之类的。懒得写了。
@implementation UserInfoCardView{
    UIImageView* faceImageView;
    UIButton* privateLetterBtn;
    UIButton* followBtn;
    UILabel* nameLabel;
    UIImageView* sexImageview;
    //
    UIButton* followCountBtn;
    UIButton* fansCountBtn;
    UILabel* signLabel;
}

+(CGFloat)height{
    return 270;
}
-(instancetype)init{
    if ([super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self loadSubViews];
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

-(void)setEntity:(UserInfoCardEntity *)entity{
    if (entity) {
        _entity = entity;
        
        [faceImageView sd_setImageWithURL:[NSURL URLWithString:entity.face]];
        
        nameLabel.text = entity.name;
        [nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([self getTitleWidth:nameLabel]));
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
        
        signLabel.text = entity.sign;
        [signLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@([self getSignLabelHeight]));
        }];
        
        self.height = 220 + [self getSignLabelHeight];
        
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
    
    return size.height+otherHeight;
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
    
    
    signLabel = ({
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = ColorWhite(150);
        [self addSubview:label];
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
    
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(fansCountBtn.mas_bottom).offset(10);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(signLabel).offset(10);
    }];
}
@end
