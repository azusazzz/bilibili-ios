//
//  WebViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "WebViewController.h"
#import "UIViewController+HeaderView.h"

@interface WebViewController ()
<UIWebViewDelegate>

@property (strong, nonatomic) NSString *URL;

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation WebViewController

- (instancetype)initWithURL:(NSString *)URL {
    if (self = [super init]) {
        _URL = URL;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CRed;
    
    if (!_URL) {
        return;
    }
    
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.top.equalTo(self.navigationBar.mas_bottom).offset = -20;
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    [_webView loadRequest:request];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_webView addGestureRecognizer:tap];
    
    _webView.scrollView.contentInset = UIEdgeInsetsZero;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)tap {
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request.URL.absoluteString);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationBar.topItem.title = title;
}


@end
