//
//  ReadRQCodeVC.m
//  bilibili fake
//
//  Created by cxh on 16/7/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ReadRQCodeVC.h"
#import "Masonry.h"

@implementation ReadRQ_CodeVC
-(id)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"扫码";
      
        [self loadSubviews];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
  
    
    
//      self.navigationController.interactivePopGestureRecognizer.delegate =  self;
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [_captureSession addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [_captureSession addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.bounds];
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    // 开始会话
    [_captureSession startRunning];
}


#pragma mark - ActionDealt
-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
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
        }
        //得到结果
        NSLog(@"扫描结果:%@",result);
        [_captureSession stopRunning];
        _captureSession = nil;
        [self goBackAction];
    }
}


#pragma mark loadSubviews
//加载视图
-(void)loadSubviews{
    //标题颜色和字体
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: ColorRGB(200, 200, 200),
      NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    UIButton *cancel_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [cancel_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancel_btn setTitleColor:ColorRGB(230, 140, 150) forState:UIControlStateNormal];
    [cancel_btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:cancel_btn];
    
    self.navigationItem.leftBarButtonItem=back;
    //加萌版
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
    float height = self.view.frame.size.height;
    float width = self.view.frame.size.width;
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRect:CGRectMake(20, 150, width-40, height*0.5)];
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
    UILabel* label = [[UILabel alloc] init];
    label.text = @"将二维码放入扫描框内";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
   
    // Layout
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(@(height*0.85));
    }];
}

@end
