//
//  VideoCommentTableViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/26.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentTableViewCell.h"
#import <UIImageView+WebCache.h>


@interface VideoCommentReplyView : UIView

{
    UIView *_lineView;
    UILabel *_nicknameAndDateLabel;
    UILabel *_msgLabel;
}

@end

@implementation VideoCommentReplyView

- (void)setupCommentInfo:(VideoCommentItemEntity *)comment {
    _nicknameAndDateLabel.text = [NSString stringWithFormat:@"%@  %@", comment.nick, comment.create_at];
    _msgLabel.text = comment.msg;
    CGFloat msgHeight = [comment.msg boundingRectWithSize:CGSizeMake(SSize.width-10-30-10-15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(13)} context:NULL].size.height + 2;
    [_msgLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = msgHeight;
    }];
    self.height = 15+13+15+msgHeight+15;
}

+ (CGFloat)heightForCommentInfo:(VideoCommentItemEntity *)comment width:(CGFloat)width {
    CGFloat msgHeight = [comment.msg boundingRectWithSize:CGSizeMake(width-15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(13)} context:NULL].size.height + 2;
    return 15+13+15+msgHeight+15;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = ColorWhite(247);
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorWhite(200);
        [self addSubview:_lineView];
        _nicknameAndDateLabel = [[UILabel alloc] init];
        _nicknameAndDateLabel.font = Font(12);
        _nicknameAndDateLabel.textColor = ColorWhite(146);
        [self addSubview:_nicknameAndDateLabel];
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.font = Font(13);
        _msgLabel.textColor = ColorWhite(34);
        _msgLabel.numberOfLines = 0;
        [self addSubview:_msgLabel];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.offset = 0.5;
        }];
        [_nicknameAndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = -15;
            make.top.offset = 15;
            make.height.offset = 13;
        }];
        [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = -15;
            make.height.offset = 30;
            make.top.equalTo(_nicknameAndDateLabel.mas_bottom).offset = 15;
        }];
    }
    return self;
}

@end




@interface VideoCommentTableViewCell ()
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
    
    NSMutableArray<VideoCommentReplyView *> *_replyViews;
    
    UILabel *_moreCountLabel;
}
@end

@implementation VideoCommentTableViewCell


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
    
    
    /**
     *  回复
     */
    NSInteger commentCount = [comment.reply count];
    commentCount = commentCount > 3 ? 3 : commentCount;
    if (!_replyViews) {
        _replyViews = [NSMutableArray arrayWithCapacity:commentCount];
    }
    
    for (NSInteger idx = _replyViews.count; idx < commentCount; idx++) {
        VideoCommentReplyView *replyView = [[VideoCommentReplyView alloc] init];
        [self.contentView addSubview:replyView];
        [_replyViews addObject:replyView];
    }
    for (NSInteger idx=_replyViews.count-1; idx >= commentCount; idx--) {
        [_replyViews[idx] removeFromSuperview];
        [_replyViews removeLastObject];
    }
    
    if (_replyViews.count) {
        __block CGFloat top = 15+13 + 3+11 + 10+msgHeight+15/* +10*/;
        
        [_replyViews enumerateObjectsUsingBlock:^(VideoCommentReplyView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(10+30+10, top, SSize.width-10-30-10, 0);
            [obj setupCommentInfo:comment.reply[idx]];
            top = obj.maxY;
        }];
    }
    
    if (comment.reply.count > 3) {
        if (!_moreCountLabel) {
            _moreCountLabel = [[UILabel alloc] init];
            _moreCountLabel.font = Font(12);
            _moreCountLabel.textColor = ColorWhite(186);
            _moreCountLabel.textAlignment = NSTextAlignmentRight;
        }
        [self.contentView addSubview:_moreCountLabel];
        _moreCountLabel.frame = CGRectMake(0, _replyViews.lastObject.maxY, SSize.width-10, 20);
        _moreCountLabel.text = [NSString stringWithFormat:@"更多%ld条回复", comment.reply.count-3];
    }
    else {
        [_moreCountLabel removeFromSuperview];
    }
    
    
}


+ (CGFloat)heightForComment:(VideoCommentItemEntity *)comment showReply:(BOOL)showReply {
    CGFloat msgHeight = [comment.msg boundingRectWithSize:CGSizeMake(SSize.width-10-30-10-15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(13)} context:NULL].size.height;
    CGFloat itemHeight = 15+13 + 3+11 + 10+msgHeight+15; //CGSizeMake(SSize.width, /* +10*/);
    if (showReply) {
        int count = (int)(comment.reply.count > 3 ? 3 : comment.reply.count);
        for (int i = 0; i < count; i++) {
            itemHeight += [VideoCommentReplyView heightForCommentInfo:comment.reply[i] width:SSize.width-10-30-10];
        }
        if (comment.reply.count > 3) {
            itemHeight += 20;
        }
    }
    itemHeight += 10;
    return itemHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = ColorWhite(247);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _faceImageView = [[UIImageView alloc] init];
        _faceImageView.layer.cornerRadius = 15;
        _faceImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_faceImageView];
        _levelImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_levelImageView];
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = ColorWhite(146);
        _nicknameLabel.font = Font(12);
        [self.contentView addSubview:_nicknameLabel];
        _sexImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_sexImageView];
        _lvAndDateLabel = [[UILabel alloc] init];
        _lvAndDateLabel.textColor = ColorWhite(200);
        _lvAndDateLabel.font = Font(10);
        [self.contentView addSubview:_lvAndDateLabel];
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.font = Font(13);
        _msgLabel.textColor = ColorWhite(34);
        _msgLabel.numberOfLines = 0;
        [self.contentView addSubview:_msgLabel];
        
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
        [self.contentView addSubview:_topLine];
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
