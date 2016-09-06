//
//  QRCodeViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "QRCodeViewController.h"
#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "Macro.h"
#import "UIViewController+HeaderView.h"

@interface QRCodeViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *qrCodeView;

@end

@implementation QRCodeViewController
{
    UIButton* backBtn;
    UILabel* label;
}

-(id)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"扫码";
    }
    return self;
}



- (void)viewDidLoad {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    [self loadSubviews];
    
    // 开始会话
    [_captureSession startRunning];
    
    
    [self navigationBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
        } else {
            NSLog(@"不是二维码");
            return;
        }
        //得到结果
        NSLog(@"扫描结果:%@", result);
        [_captureSession stopRunning];
        _captureSession = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark loadSubviews
//加载视图
-(void)loadSubviews{
    
    self.view.backgroundColor = CRed;
    
    // 创建会话
    _captureSession = ({
        // 获取 AVCaptureDevice 实例
        NSError * error;
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 初始化输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        if (!input) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        // 添加输入流
        [session addInput:input];
        
        // 初始化输出流
        AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
        // 添加输出流
        [session addOutput:captureMetadataOutput];
        [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        
        session;
    });
    
    if (!_captureSession) {
        return;
    }
    
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-44)];
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    
    
    //加萌版
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_videoPreviewLayer.frame];
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRect:CGRectMake(20, 150, SSize.width-40, SSize.height*0.5)];
    [path appendPath:path2];
    path.usesEvenOddFillRule = YES;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor= [UIColor blackColor].CGColor;  //其他颜色都可以，只要不是透明的
    shapeLayer.fillRule=kCAFillRuleEvenOdd;
    
    UIView *translucentView = [UIView new];
    translucentView.frame = self.view.bounds;
    translucentView.backgroundColor = [UIColor blackColor];
    translucentView.alpha = 0.5;
    translucentView.layer.mask = shapeLayer;
    
    [self.view addSubview:translucentView];
    
    
    
    //加标签
    label = ({
        UILabel* l = [[UILabel alloc] init];
        l.text = @"将二维码放入扫描框内";
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        [self.view addSubview:l];
        l;
    });
    // Layout
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(@(SSize.height*0.85));
    }];
    
    
    
}
@end
