//
//  RecommendInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/28.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RecommendInfoVC.h"

#import <WebKit/WebKit.h>
#import "WaitAnimation.h"

@interface RecommendInfoVC ()<WKNavigationDelegate>
{
    
    NSString *_urlStr;
    NSString *_titleStr;
}

@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation RecommendInfoVC

- (instancetype)initWithUrlStr:(NSString *)urlStr titleStr:(nonnull NSString *)titleStr
{
    self = [super init];
    if (self) {
        
        _urlStr = urlStr;
        _titleStr = titleStr;
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_wkWebView stopLoading];
    [WaitAnimation stopAnimation];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = _titleStr;
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _wkWebView.navigationDelegate = self;
    //    _wkWebView.
    
    [self.view addSubview:_wkWebView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [_wkWebView loadRequest:request];
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
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    [self showContent:@"网络错误"];
//}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self showContent:@"网络错误"];
    
}


@end
