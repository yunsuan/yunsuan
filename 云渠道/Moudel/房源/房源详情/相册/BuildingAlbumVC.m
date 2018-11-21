//
//  BuildingAlbumVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildingAlbumVC.h"
#import <WebKit/WebKit.h>

@interface BuildingAlbumVC ()<WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *webwivw;
@end

@implementation BuildingAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = YES;
    
//    self.titleLabel.text = @"操作指南";
    //2.创建URL
    //    NSURL *URL = [NSURL URLWithString:@"http://120.27.21.136:2798/360/index.html"];
    NSURL *URL = [NSURL URLWithString:_weburl];
    
    //3.创建Request
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //4.加载Request
    [self.webwivw loadRequest:request];
    [self.view addSubview:self.webwivw];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.maskButton];
}


- (void)ActionMaskBtn:(UIButton *)btn{
    
    if (self.buildBackBlock) {
        
        self.buildBackBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
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
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self showContent:@"网络错误"];
}


-(WKWebView *)webwivw
{
    if (!_webwivw) {
        _webwivw = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _webwivw.navigationDelegate = self;
        if (@available(iOS 11.0, *)) {
            _webwivw.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
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
