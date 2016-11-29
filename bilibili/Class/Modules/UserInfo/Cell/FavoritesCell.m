//
//  FavoritesCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FavoritesCell.h"
#import <UIImageView+WebCache.h>
#import "GradientView.h"

@implementation FavoritesCell{
    UIImageView* video1ImageView;
    UIImageView* video2ImageView;
    UIImageView* video3ImageView;
    
    UILabel* cur_countLabel;
    UILabel* nameLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0;
        
        video3ImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds = YES;
            [self addSubview:view];
            view;
        });
        
        video2ImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds = YES;
            [self addSubview:view];
            view;
        });
        
        video1ImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds = NO;
            view.layer.masksToBounds = YES;
            [self addSubview:view];
            view;
        });
        
        GradientView*  blankView= ({
            GradientView* view = [[GradientView alloc] initWithFrame:CGRectMake(0, self.height*0.5, self.width, self.height*0.5)];
            view.layer.masksToBounds = YES;
            //view.backgroundColor = ColorWhiteAlpha(0, 0.1);
            [self addSubview:view];
            view;
        });
        [blankView setBackgroundColor:[UIColor clearColor]];
        
        cur_countLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12];
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 5.0;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = ColorWhite(255);
            label.backgroundColor = ColorWhiteAlpha( 0, 0.4);
            [self addSubview:label];
            label;
        });
        
        nameLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(255);
            [self addSubview:label];
            label;
        });
        
        //layout
        [video1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(self.mas_width);
        }];
        [video2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(self);
            make.height.equalTo(self.mas_height).multipliedBy(0.5).offset(-1);
        }];
        [video3ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self);
            make.height.equalTo(self.mas_height).multipliedBy(0.5).offset(-1);
        }];
        
//        [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
        
        [cur_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
            make.height.equalTo(@20);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.bottom.right.equalTo(self).offset(-5);
            make.height.equalTo(@15);
        }];
    }
    return self;
}

-(void)setEntity:(UserInfoFavoritesEntity *)entity{
    if (entity.videos.count == 0) {
    }else if(entity.videos.count == 1){
        [video1ImageView sd_setImageWithURL:[NSURL URLWithString:entity.videos[0].pic]];
        [video1ImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self);
        }];
    }else if(entity.videos.count == 2){
        [video1ImageView sd_setImageWithURL:[NSURL URLWithString:entity.videos[0].pic]];
        [video2ImageView sd_setImageWithURL:[NSURL URLWithString:entity.videos[1].pic]];
        [video1ImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self).multipliedBy(0.5).offset(-1);
        }];
        [video2ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
        }];
    }else{
        [video1ImageView sd_setImageWithURL:[NSURL URLWithString:entity.videos[0].pic]];
        [video2ImageView sd_setImageWithURL:[NSURL URLWithString:entity.videos[1].pic]];
        [video3ImageView sd_setImageWithURL:[NSURL URLWithString:entity.videos[2].pic]];
        [video1ImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self).multipliedBy(0.5).offset(-1);
        }];
        [video2ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width).multipliedBy(0.5).offset(-1);
        }];
        [video3ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width).multipliedBy(0.5).offset(-1);
        }];
    }
    
    cur_countLabel.text = [NSString stringWithFormat:@"%lu",entity.cur_count];
    [cur_countLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([self getLabelWidth:cur_countLabel]));
    }];
    
    nameLabel.text = entity.name;
    [self setNeedsLayout];
}

#pragma 计算titleLabel的宽度
-(CGFloat)getLabelWidth:(UILabel*)label{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width+15;
}
@end
