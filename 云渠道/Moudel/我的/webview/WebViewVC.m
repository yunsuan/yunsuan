//
//  WebViewVC.m
//  云渠道
//
//  Created by xiaoq on 2018/5/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WebViewVC.h"
#import <WebKit/WebKit.h>
#import "WaitAnimation.h"

@interface WebViewVC ()<WKNavigationDelegate>
@property (nonatomic , strong) WKWebView *webwivw;
@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"操作指南";
    //2.创建URL
    NSURL *URL = [NSURL URLWithString:_weburl];
    //3.创建Request
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //4.加载Request
    [self.webwivw loadRequest:request];
    [self.view addSubview:self.webwivw];
    
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [WaitAnimation startAnimation];
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [WaitAnimation stopAnimation];
}
//// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    [self showContent:@"网络错误"];
//}

// 页面加载失败时调用
- (void)webView {
    [self showContent:@"网络错误"];
}



-(WKWebView *)webwivw
{
    if (!_webwivw) {
        _webwivw = [[WKWebView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT)];
        _webwivw.navigationDelegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return _webwivw;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_webwivw stopLoading];
    [WaitAnimation stopAnimation];
}
@end
