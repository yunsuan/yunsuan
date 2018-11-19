//
//  DynamicDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DynamicDetailVC.h"
#import <WebKit/WebKit.h>

@interface DynamicDetailVC ()<WKNavigationDelegate>
{

    NSString *_urlStr;
    NSString *_titleStr;
}
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation DynamicDetailVC

- (instancetype)initWithStr:(NSString *)str titleStr:(NSString *)titleStr
{
    self = [super init];
    if (self) {
        
        _urlStr = str;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YJBackColor;
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = _titleStr;
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _wkWebView.navigationDelegate = self;
//    _wkWebView.
    
    [self.view addSubview:_wkWebView];
    
    NSURL *url;
    if ([_titleStr isEqualToString:@"消息详情"]) {
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlStr]];
        
    }else{
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_urlStr]];
    }

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
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self showContent:@"网络错误"];
}



@end
