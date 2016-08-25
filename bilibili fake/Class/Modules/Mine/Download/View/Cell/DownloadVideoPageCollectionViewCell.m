//
//  DownloadVideoPageCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoPageCollectionViewCell.h"
#import <ReactiveCocoa.h>

@interface DownloadVideoPageCollectionViewCell ()
{
    UILabel *pageLabel;
    
    
    
    
    
    
//    RACDisposable *progressDisposable;
//    RACDisposable *statusDisposable;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *leftInfoLabel;
@property (strong, nonatomic) UILabel *rightInfoLabel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIImageView *statusImageView;

@end

@implementation DownloadVideoPageCollectionViewCell

+ (CGFloat)height {
    return 16+10+14+5+4;
}

- (void)setVideoPage:(DownloadVideoPageEntity *)videoPage {
    
    pageLabel.text = @(videoPage.page).stringValue;
    _titleLabel.text = videoPage.part;
    
    
    if ([videoPage.fileName length] > 0) {
        _statusImageView.image = [UIImage imageNamed:@"download_complete"];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:videoPage.filePath error:NULL];
        NSUInteger size = [[attributes valueForKey:NSFileSize] integerValue];
        _leftInfoLabel.text = [NSString stringWithFormat:@"大小: %.1lfMB", size / 1024.0 / 1024.0];
        _progressView.hidden = YES;
        _rightInfoLabel.hidden = YES;
    }
    else {
        __weak typeof(self) weakself = self;
        
        _videoPage.operation.progressChanged = NULL;
        _videoPage.operation.statusChanged = NULL;
        
        _videoPage = videoPage;
        
        [_videoPage.operation setProgressChanged:^(DownloadOperation * _Nonnull operation) {
            if (operation.status == DownloadOperationStatusRuning) {
                NSUInteger received = operation.countOfBytesReceived;
                NSUInteger expectedToReceive = operation.countOfBytesExpectedToReceive;
                weakself.rightInfoLabel.text = [NSString stringWithFormat:@"缓存中 %.2lf/%.2lfMB", received / 1024.0 / 1024.0, expectedToReceive / 1024.0 / 1024.0];
                weakself.progressView.progress = received / (CGFloat)expectedToReceive;
            }
        }];
        
        [_videoPage.operation setStatusChanged:^(DownloadOperation * _Nonnull operation) {
            DownloadOperationStatus status = operation.status;
            NSLog(@"Status:%ld", status);
            if (status == DownloadOperationStatusWaiting) {
                weakself.rightInfoLabel.text = @"等待中";
                weakself.statusImageView.image = [UIImage imageNamed:@"download_start"];
            }
            else if (status == DownloadOperationStatusGetURLing) {
                weakself.statusImageView.image = [UIImage imageNamed:@"download_stop"];
                weakself.rightInfoLabel.text = @"正在解析下载地址";
            }
            else if (status == DownloadOperationStatusRuning) {
                weakself.statusImageView.image = [UIImage imageNamed:@"download_stop"];
                weakself.rightInfoLabel.text = @"缓存中";
            }
            else if (status == DownloadOperationStatusPause ||
                     status ==  DownloadOperationStatusNone) {
                weakself.rightInfoLabel.text = @"已暂停";
                weakself.statusImageView.image = [UIImage imageNamed:@"download_start"];
            }
            else if (status == DownloadOperationStatusSuccess) {
                weakself.rightInfoLabel.text = @"下载成功";
                weakself.statusImageView.image = [UIImage imageNamed:@"download_complete"];
            }
            else if (status == DownloadOperationStatusFailure) {
                weakself.rightInfoLabel.text = @"下载失败";
                weakself.statusImageView.image = [UIImage imageNamed:@"download_complete"];
            }
        }];
        
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return NULL;
    }
    
    self.backgroundColor = ColorWhite(247);
    
    
    pageLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = Font(14);
        label.textColor = CRed;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        label;
    });
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = Font(14);
    [self.contentView addSubview:_titleLabel];
    
    _leftInfoLabel = [[UILabel alloc] init];
    _leftInfoLabel.font = Font(12);
    _leftInfoLabel.textColor = ColorWhite(146);
    [self.contentView addSubview:_leftInfoLabel];
    
    _rightInfoLabel = [[UILabel alloc] init];
    _rightInfoLabel.font = Font(12);
    _rightInfoLabel.textColor = ColorWhite(146);
    _rightInfoLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightInfoLabel];
    
    _progressView = [[UIProgressView alloc] init];
    _progressView.trackTintColor = [UIColor whiteColor];
    _progressView.progressTintColor = ColorWhite(146);
    [self.contentView addSubview:_progressView];
    
    _statusImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_statusImageView];
    
    
    [pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 20;
        make.height.offset = 14;
        make.centerY.offset = 0;
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pageLabel.mas_right).offset = 10;
        make.top.offset = 10;
        make.right.equalTo(_statusImageView.mas_left).offset = -15;
        make.height.offset = 16;
    }];
    [_leftInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset = 10;
        make.right.equalTo(_titleLabel);
        make.height.offset = 14;
    }];
    [_rightInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_leftInfoLabel);
    }];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(_titleLabel);
        make.top.equalTo(_leftInfoLabel.mas_bottom).offset = 5;
        make.height.offset = 4;
    }];
    [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = -10;
        make.width.offset = 15;
        make.height.offset = 15;
    }];
    
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
//    [statusDisposable dispose];
//    [progressDisposable dispose];
}

@end
