//
//  RecommendNewInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/1.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendNewInfoVC.h"

#import "RecommendMoreInfoVC.h"
#import "RoomDetailVC1.h"

#import <WebKit/WebKit.h>
#import "WaitAnimation.h"

#import "TransmitView.h"
#import "SinglePickView.h"

@interface RecommendNewInfoVC ()<WKNavigationDelegate>
{
    
    NSString *_urlStr;
    NSString *_titleStr;
    NSString *_companyStr;
    NSArray *_imageUrl;
    NSString *_briefStr;
    NSString *_recommendId;
    NSDictionary *_dataDic;
//    NSString *_isFollow;
    NSString *_isApplyFollow;
    NSMutableArray *_dataArr;
    NSMutableArray *_buildingArr;
}
@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *fansL;

@property (nonatomic, strong) UIButton *headBtn;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation RecommendNewInfoVC

- (instancetype)initWithUrlStr:(NSString *)urlStr titleStr:(NSString *)titleStr imageUrl:(NSArray *)imageUrl briefStr:(NSString *)briefStr recommendId:(NSString *)recommendId companyStr:(NSString *)companyStr
{
    self = [super init];
    if (self) {
        
        _urlStr = urlStr;
        _titleStr = titleStr;
        _imageUrl = imageUrl;
        _briefStr = briefStr;
        _recommendId = recommendId;
        _dataArr = [@[] mutableCopy];
        _buildingArr = [@[] mutableCopy];
        _companyStr = companyStr;
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [_wkWebView stopLoading];
    [WaitAnimation stopAnimation];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
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
            _titleL.text = _dataDic[@"nick_name"];
            [_dataArr removeAllObjects];
            for (int i = 0; i < [_dataDic[@"project_arr"] count]; i++) {
                
                RoomListModel *model = [[RoomListModel alloc] initWithDictionary:_dataDic[@"project_arr"][i]];
                
                [_dataArr addObject:model];
            }
//            _dataArr = [NSMutableArray arrayWithArray:_dataDic[@"project_arr"]];
            _isApplyFollow = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"is_apply_follow"]];
            if ([_isApplyFollow integerValue] == 1) {
                
                [_attentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [_attentBtn setBackgroundColor:[UIColor whiteColor]];
                _attentBtn.layer.borderWidth = SIZE;
                [_attentBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
            }else{
                
                [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
                [_attentBtn setBackgroundColor:YJBlueBtnColor];
                _attentBtn.layer.borderWidth = 0;
            }
            _fansL.text = [NSString stringWithFormat:@"粉丝数：%@",_dataDic[@"follow_number"]];
            if ([_dataDic[@"logo"] length]) {
                
                [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataDic[@"logo"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

                    if (error) {

                        _headImg.image = [UIImage imageNamed:@"default_3"];
                    }
                }];
            }else{
                
                _headImg.image = [UIImage imageNamed:@"default_3"];
            }
            if (!_urlStr.length) {
                
                _urlStr = resposeObject[@"data"][@"content_url"];
                //            NSURLRequest *request = ;
                [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_urlStr]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
            }
            
            if (_dataArr.count) {
                
                _scrollView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE);
                [self.view addSubview:_moreBtn];
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
        
        if (![_isApplyFollow integerValue]) {
            
            [BaseRequest POST:ApplyFollow_URL parameters:@{@"apply_id":_dataDic[@"apply_id"]} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"关注成功"];
                    _isApplyFollow = @"1";
                    [self RequestMethod];
                    [_attentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [_attentBtn setBackgroundColor:[UIColor whiteColor]];
                    [_attentBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
                    _attentBtn.layer.borderWidth = SIZE;
                    if (self.recommendNewInfoVCBlock) {
                        
                        self.recommendNewInfoVCBlock(@"1");
                    }
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
                
            }];
        }else{
            
            [BaseRequest POST:ApplyFollowCancel_URL parameters:@{@"apply_id":_dataDic[@"apply_id"]} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"取关成功"];
                    _isApplyFollow = @"0";
                    [self RequestMethod];
                    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
                    [_attentBtn setBackgroundColor:YJBlueBtnColor];
                    [_attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    _attentBtn.layer.borderWidth = 0;
                    if (self.recommendNewInfoVCBlock) {
                        
                        self.recommendNewInfoVCBlock(@"0");
                    }
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

- (void)ActionHeadBtn:(UIButton *)btn{
    
    if (_dataDic.count) {
        
        RecommendMoreInfoVC *nextVC = [[RecommendMoreInfoVC alloc] initWithApplyFocusId:_dataDic[@"company_id"] titleStr:_dataDic[@"nick_name"] applyId:_dataDic[@"apply_id"]];
        nextVC.recommendMoreInfoVCBlock = ^(NSString * attent) {
            
            if ([attent integerValue] == 1) {
                
                _isApplyFollow = @"1";
                [self RequestMethod];
                [_attentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [_attentBtn setBackgroundColor:[UIColor whiteColor]];
                [_attentBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
                _attentBtn.layer.borderWidth = SIZE;
                if (self.recommendNewInfoVCBlock) {
                    
                    self.recommendNewInfoVCBlock(@"1");
                }
            }else{
                
                _isApplyFollow = @"0";
                [self RequestMethod];
                [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
                [_attentBtn setBackgroundColor:YJBlueBtnColor];
                [_attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _attentBtn.layer.borderWidth = 0;
                if (self.recommendNewInfoVCBlock) {
                    
                    self.recommendNewInfoVCBlock(@"0");
                }
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (_dataArr.count) {
        
        if (_dataArr.count == 1) {
            
            RoomListModel *model = _dataArr[0];
            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
            if ([model.guarantee_brokerage integerValue] == 2) {
                
                nextVC.brokerage = @"no";
            }else{
                
//                if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
//
//                }else{
//
//                    nextVC.isRecommend = @"NO";
//                }
                nextVC.brokerage = @"yes";
            }
            
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [_buildingArr removeAllObjects];
            [_dataArr enumerateObjectsUsingBlock:^(RoomListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *dic = @{@"id":model.info_id,
                                      @"param":model.project_name
                                      };
                [_buildingArr addObject:dic];
            }];
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:_buildingArr];
            view.selectNumblook = ^(NSInteger idx) {
                
                RoomListModel *model = _dataArr[idx];
                RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
                if ([model.guarantee_brokerage integerValue] == 2) {
                    
                    nextVC.brokerage = @"no";
                }else{
                    
//                    if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
//                        
//                    }else{
//                        
//                        nextVC.isRecommend = @"NO";
//                    }
                    nextVC.brokerage = @"yes";
                }
                
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            [self.view addSubview:view];
        }
    }
}

#pragma mark ------ < KVO > ------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    /**  < 法2 >  */
    /**  < loading：防止滚动一直刷新，出现闪屏 >  */
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect webFrame = self.wkWebView.frame;
        webFrame.size.height = self.wkWebView.scrollView.contentSize.height;
        self.wkWebView.frame = webFrame;
    
//        _transmitView.frame = CGRectMake(0, webFrame.size.height, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE);
//        [_scrollView addSubview:_transmitView];
        [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 167 *SIZE + TAB_BAR_MORE + webFrame.size.height)];
        
        //        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(40 *SIZE, STATUS_BAR_HEIGHT + 4 *SIZE, 36 *SIZE, 36 *SIZE)];
    _headImg.image = [UIImage imageNamed:@"default_3"];
    _headImg.contentMode = UIViewContentModeScaleAspectFit;
//    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 18 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.navBackgroundView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(85 *SIZE, STATUS_BAR_HEIGHT + 5 *SIZE, 140 *SIZE, 15 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:14 *SIZE];
    _titleL.text = _companyStr;
    [self.navBackgroundView addSubview:_titleL];
    
    _fansL = [[UILabel alloc] initWithFrame:CGRectMake(85 *SIZE, STATUS_BAR_HEIGHT + 26 *SIZE, 140 *SIZE, 14 *SIZE)];
    _fansL.textColor = YJTitleLabColor;
    _fansL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _fansL.text = @"1248粉丝";
    [self.navBackgroundView addSubview:_fansL];
//    self.titleLabel.text = @"推荐详情";
    
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake(40 *SIZE, STATUS_BAR_HEIGHT, 230 *SIZE, 40 *SIZE);
    [_headBtn addTarget:self action:@selector(ActionHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackgroundView addSubview:_headBtn];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentBtn.frame = CGRectMake(240 *SIZE, STATUS_BAR_HEIGHT + 7 *SIZE, 50 *SIZE, 30 *SIZE);
    _attentBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    _attentBtn.layer.cornerRadius = 5 *SIZE;
    _attentBtn.clipsToBounds = YES;
    [_attentBtn setBackgroundColor:YJBlueBtnColor];
    _attentBtn.layer.borderColor = YJTitleLabColor.CGColor;
//    _attentBtn.layer.borderWidth = SIZE;
//    _attentBtn.layer.borderWidth =
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
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_moreBtn setBackgroundColor:YJBlueBtnColor];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"进入楼盘详情" forState:UIControlStateNormal];

    
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
    
        __block CGFloat webViewHeight;
        self.height = webView.frame.size.height;
        //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
        [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
            // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以，但如果是和我一样直接加载原站内容使用前者更合适
            //获取页面高度，并重置webview的frame
            webViewHeight = [result doubleValue];
            NSLog(@"%f",webViewHeight);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (webViewHeight != self.height) {
                    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, webViewHeight);
                        [_scrollView setContentSize:CGSizeMake(SCREEN_Width, webViewHeight)];
                    [_wkWebView setNeedsLayout];
    
                }else{
    
//                    _tranView.frame = CGRectMake(0, self.height, SCREEN_Width, 167 *SIZE + TAB_BAR_MORE);
//                    [_scrollView addSubview:_tranView];
//                    [_scrollView setContentSize:CGSizeMake(SCREEN_Width, 167 *SIZE + TAB_BAR_MORE + self.height)];
                    [_scrollView setContentSize:CGSizeMake(SCREEN_Width, webViewHeight)];
                    [_wkWebView setNeedsLayout];
                }
            });
        }];
        [_wkWebView setNeedsLayout];
    
    NSLog(@"结束加载");
}


// 页面加载失败时调用

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self showContent:@"网络错误"];
    
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject;
    if (_imageUrl.count) {
        
        shareObject = [UMShareWebpageObject shareObjectWithTitle:_titleStr descr:_briefStr thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imageUrl[0]]]]]];
    }else{
        
        shareObject = [UMShareWebpageObject shareObjectWithTitle:_titleStr descr:_briefStr thumImage:[UIImage imageNamed:@"shareimg"]];
    }
    
    //设置网页地址
    
    
    //创建网页内容对象
    //        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:@"房产渠道专业平台" thumImage:[UIImage imageNamed:@"shareimg"]];
    
    [BaseRequest GET:GetShare parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if([resposeObject[@"code"] integerValue]==200)
        {
            //    设置网页地址
            shareObject.webpageUrl = [NSString stringWithFormat:@"%@%@",resposeObject[@"data"],_urlStr];
            //            shareObject.webpageUrl = resposeObject[@"data"];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    
                    [self alertControllerWithNsstring:@"分享失败" And:nil];
                }else{
                    
                    [self showContent:@"分享成功"];
                }
            }];
        }else
        {
            [self showContent:@"网络错误"];
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
    
  
}

@end
