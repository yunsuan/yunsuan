//
//  RecommendNewInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/1.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendNewInfoVC.h"

#import <WebKit/WebKit.h>
#import "WaitAnimation.h"

#import "TransmitView.h"

@interface RecommendNewInfoVC ()<WKNavigationDelegate>
{
    
    NSString *_urlStr;
    NSString *_titleStr;
    NSString *_imageUrl;
    NSString *_briefStr;
    NSString *_recommendId;
    NSDictionary *_dataDic;
    NSString *_isFollow;
}
@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *fansL;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation RecommendNewInfoVC

- (instancetype)initWithUrlStr:(NSString *)urlStr titleStr:(nonnull NSString *)titleStr imageUrl:(NSString *)imageUrl briefStr:(NSString *)briefStr recommendId:(NSString *)recommendId
{
    self = [super init];
    if (self) {
        
        _urlStr = urlStr;
        _titleStr = titleStr;
        _imageUrl = imageUrl;
        _briefStr = briefStr;
        _recommendId = recommendId;
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_wkWebView stopLoading];
    [WaitAnimation stopAnimation];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [_wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self RequestMethod];
    [self initUI];
}

- (void)RequestMethod{
    
    [BaseRequest GET:RencommendGetDetails_URL parameters:@{@"recommend_id":_recommendId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = resposeObject[@"data"];
            _isFollow = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"is_follow"]];
            _fansL.text = [NSString stringWithFormat:@"%@",_dataDic[@"browse_number"]];
            if (!_urlStr.length) {
                
                _urlStr = resposeObject[@"data"][@"content_url"];
                //            NSURLRequest *request = ;
                [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_urlStr]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
       
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if (_dataDic.count) {
        
        if (![_isFollow integerValue]) {
            
            [BaseRequest POST:RecommendFollow_URL parameters:@{@"recommend_id":_recommendId} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"关注成功"];
                    _isFollow = @"1";
                    [self RequestMethod];
                    [_attentBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
                
            }];
        }else{
            
            [BaseRequest POST:RecommendFollowCancel_URL parameters:@{@"recommend_id":_recommendId} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"取关成功"];
                    _isFollow = @"0";
                    [self RequestMethod];
                    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
                
            }];
        }
    }
}

- (void)ActionShareBtn:(UIButton *)btn{
    
    [self.view addSubview:self.transmitView];
}

#pragma mark ------ < KVO > ------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    /**  < 法2 >  */
    /**  < loading：防止滚动一直刷新，出现闪屏 >  */
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect webFrame = self.wkWebView.frame;
        webFrame.size.height = self.wkWebView.scrollView.contentSize.height;
        self.wkWebView.frame = webFrame;
        
        _transmitView.frame = CGRectMake(0, webFrame.size.height, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE);
        [_scrollView addSubview:_transmitView];
        [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 167 *SIZE + TAB_BAR_MORE + webFrame.size.height)];
        
        //        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(40 *SIZE, STATUS_BAR_HEIGHT + 2 *SIZE, 40 *SIZE, 40 *SIZE)];
    _headImg.image = [UIImage imageNamed:@"default"];
    [self.navBackgroundView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(85 *SIZE, STATUS_BAR_HEIGHT + 5 *SIZE, 140 *SIZE, 15 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:14 *SIZE];
    _titleL.text = _titleStr;
    [self.navBackgroundView addSubview:_titleL];
    
    _fansL = [[UILabel alloc] initWithFrame:CGRectMake(85 *SIZE, STATUS_BAR_HEIGHT + 26 *SIZE, 140 *SIZE, 14 *SIZE)];
    _fansL.textColor = YJTitleLabColor;
    _fansL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _fansL.text = @"1248粉丝";
    [self.navBackgroundView addSubview:_fansL];
//    self.titleLabel.text = @"推荐详情";
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(240 *SIZE, STATUS_BAR_HEIGHT + 7 *SIZE, 50 *SIZE, 30 *SIZE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    _attentBtn.layer.cornerRadius = 5 *SIZE;
    _attentBtn.clipsToBounds = YES;
    [_attentBtn setBackgroundColor:YJBlueBtnColor];
    [self.navBackgroundView addSubview:_attentBtn];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake(300 *SIZE, STATUS_BAR_HEIGHT + 7 *SIZE, 50 *SIZE, 30 *SIZE);
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_shareBtn addTarget:self action:@selector(ActionShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    _shareBtn.layer.cornerRadius = 5 *SIZE;
    _shareBtn.clipsToBounds = YES;
    _shareBtn.layer.borderColor = YJTitleLabColor.CGColor;
    _shareBtn.layer.borderWidth = SIZE;
//    [_shareBtn setBackgroundColor:YJBlueBtnColor];
    [self.navBackgroundView addSubview:_shareBtn];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _wkWebView.navigationDelegate = self;
    _wkWebView.userInteractionEnabled = NO;
    //    _wkWebView.
    
    [_scrollView addSubview:_wkWebView];
    
    [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 1){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 2){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }else{
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }
        };
    }
    return _transmitView;
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
    //    __block CGFloat webViewHeight;
    //    self.height = webView.frame.size.height;
    //    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    //    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
    //        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以，但如果是和我一样直接加载原站内容使用前者更合适
    //        //获取页面高度，并重置webview的frame
    //        webViewHeight = [result doubleValue];
    //        NSLog(@"%f",webViewHeight);
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            if (webViewHeight != self.height) {
    //                webView.frame = CGRectMake(0, 0, self.view.frame.size.width, webViewHeight);
    //
    //                _tranView.frame = CGRectMake(0, webViewHeight, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE);
    //                [_scrollView addSubview:_tranView];
    //                [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 167 *SIZE + TAB_BAR_MORE + webViewHeight)];
    //                [_wkWebView setNeedsLayout];
    //
    //            }else{
    //
    //                _tranView.frame = CGRectMake(0, self.height, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE);
    //                [_scrollView addSubview:_tranView];
    //                [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 167 *SIZE + TAB_BAR_MORE + self.height)];
    //                [_wkWebView setNeedsLayout];
    //            }
    //        });
    //    }];
    //    [_wkWebView setNeedsLayout];
    
    NSLog(@"结束加载");
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

//    if (navigationAction.navigationType == WKNavigationTypeOther) {
////        if ([[[navigationAction.request URL] scheme] isEqualToString:@"ready"]) {
//            float contentHeight = [[[navigationAction.request URL] host] floatValue];
//            CGRect webFrame = self.wkWebView.frame;
//            webFrame.size.height = contentHeight;
//            webView.frame = webFrame;
//
//            NSLog(@"onload = %f",contentHeight);
//
//            _tranView.frame = CGRectMake(0, contentHeight, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE);
//            [_scrollView addSubview:_tranView];
//            [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 167 *SIZE + TAB_BAR_MORE + contentHeight)];
//
//
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
////        }
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}

// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    [self showContent:@"网络错误"];
//}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self showContent:@"网络错误"];
    
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_titleStr descr:_briefStr thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imageUrl]]]]];
    //设置网页地址
    
    
    //创建网页内容对象
    //        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:@"房产渠道专业平台" thumImage:[UIImage imageNamed:@"shareimg"]];
    //    设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"%@%@",TestBase_Net,_urlStr];
    //            shareObject.webpageUrl = resposeObject[@"data"];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
            [self alertControllerWithNsstring:@"分享失败" And:nil];
        }else{
            
            [self showContent:@"分享成功"];
            //            [self.transmitView removeFromSuperview];
        }
    }];
}

@end
