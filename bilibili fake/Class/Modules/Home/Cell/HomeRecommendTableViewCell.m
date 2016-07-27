//
//  HomeRecommendTableViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendTableViewCell.h"

@interface HomeRecommendTableViewCell ()

{
    UILabel *_leftTitleLabel;
    UILabel *_rightTitleLabel;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
}

@end

@implementation HomeRecommendTableViewCell

- (void)setRecommend:(HomeRecommendEntity *)recommend {
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
