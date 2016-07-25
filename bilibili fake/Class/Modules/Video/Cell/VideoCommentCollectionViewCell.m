//
//  VideoCommentCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface VideoCommentCollectionViewCell ()
{
    UIImageView *_faceImageView;
    UIImageView *_levelImageView;
    UILabel *_nicknameLabel;
    UIImageView *_sexImageView;
    UILabel *_lvAndDateLabel;
    UILabel *_msgLabel;
    UIImageView *_replyIconImageView;
    UILabel *_replyCountLabel;
    UIButton *_goodButton;
    UILabel *_goodCountLabel;
}
@end

@implementation VideoCommentCollectionViewCell

- (void)setupCommentInfo:(VideoCommentItemEntity *)comment showReply:(BOOL)showReply {
    [_faceImageView sd_setImageWithURL:[NSURL URLWithString:comment.face]];
    _nicknameLabel.text = comment.nick;
    if ([comment.sex isEqualToString:@"男"]) {
        _sexImageView.image = [UIImage imageNamed:@"misc_sex_male"];
    }
    else if ([comment.sex isEqualToString:@"女"]) {
        _sexImageView.image = [UIImage imageNamed:@"misc_sex_female"];
    }
    else {
        _sexImageView.image = [UIImage imageNamed:@"misc_sex_sox"];
    }
    _lvAndDateLabel.text = [NSString stringWithFormat:@"#%ld\t%@", comment.lv, comment.create_at];
    _msgLabel.text = comment.msg;
    
    CGFloat nicknameWidth = [_nicknameLabel textRectForBounds:CGRectMake(0, 0, 200, 13) limitedToNumberOfLines:1].size.width;
    [_nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset = nicknameWidth;
    }];
    CGFloat msgHeight = [_msgLabel textRectForBounds:CGRectMake(0, 0, SSize.width-10-30-10-15, 999) limitedToNumberOfLines:0].size.height;
    [_msgLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = msgHeight;
    }];
}

+ (CGSize)sizeForComment:(VideoCommentItemEntity *)comment showReply:(BOOL)showReply {
    CGFloat msgHeight = [comment.msg boundingRectWithSize:CGSizeMake(SSize.width-10-30-10-15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(13)} context:NULL].size.height;
    CGSize itemSize = CGSizeMake(SSize.width, 15+13 + 3+11 + 10+msgHeight+15 +10);
//    if (showReply) {
//        int count = (int)(comment.reply.count > 3 ? 3 : comment.reply.count);
//        for (int i = 0; i < count; i++) {
//            CGFloat msgHeight = [comment.reply[i].msg boundingRectWithSize:CGSizeMake(SSize.width-10-30-10-15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(13)} context:NULL].size.height;
//            itemSize.height += 15+13+15+msgHeight+15;
//        }
//        
//    }
//    NSLog(@"Height %lf", itemSize.height);
    return itemSize;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        
        _faceImageView = [[UIImageView alloc] init];
        _faceImageView.layer.cornerRadius = 15;
        _faceImageView.layer.masksToBounds = YES;
        [self addSubview:_faceImageView];
        _levelImageView = [[UIImageView alloc] init];
        [self addSubview:_levelImageView];
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = ColorWhite(186);
        _nicknameLabel.font = Font(12);
        [self addSubview:_nicknameLabel];
        _sexImageView = [[UIImageView alloc] init];
        [self addSubview:_sexImageView];
        _lvAndDateLabel = [[UILabel alloc] init];
        _lvAndDateLabel.textColor = ColorWhite(200);
        _lvAndDateLabel.font = Font(10);
        [self addSubview:_lvAndDateLabel];
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.font = Font(13);
        _msgLabel.textColor = ColorWhite(34);
        _msgLabel.numberOfLines = 0;
        [self addSubview:_msgLabel];
        
        [_faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 15;
            make.width.offset = 30;
            make.height.offset = 30;
        }];
        [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_faceImageView.mas_right).offset = 10;
            make.top.offset = 15;
            make.width.offset = 80;
            make.height.offset = 13;
        }];
        [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nicknameLabel.mas_right).offset = 5;
            make.top.offset = 15;
            make.width.offset = 14;
            make.height.offset = 14;
        }];
        [_lvAndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nicknameLabel);
            make.top.equalTo(_nicknameLabel.mas_bottom).offset = 3;
            make.height.offset = 11;
            make.width.offset = 150;
        }];
        [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lvAndDateLabel);
            make.top.equalTo(_lvAndDateLabel.mas_bottom).offset = 10;
            make.height.offset = 15;
            make.right.offset = -15;
        }];
        
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = ColorWhite(200);
        [self addSubview:_topLine];
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.offset = 0.5;
        }];
        
    }
    return self;
}

@end
