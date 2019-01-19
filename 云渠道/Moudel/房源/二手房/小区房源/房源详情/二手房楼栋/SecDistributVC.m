//
//  SecDistributVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/26.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SecDistributVC.h"

#import "HousedistributVC.h"
#import "ReleaseSenceVC.h"

#import <WebKit/WebKit.h>
#import "WaitAnimation.h"

#import "SelectView.h"

@interface SecDistributVC ()<WKNavigationDelegate>
{
    NSArray *_dylist;
    NSDictionary *_lddic;
}
@property (nonatomic , strong) WKWebView *webwivw;
@property (nonatomic , strong) UIImageView *backimg;
@property (nonatomic , strong) UIButton *leftbutton;
@property (nonatomic , strong) UIButton *openbtn;
@property (nonatomic , strong) UIView * drawerview;
@property (nonatomic , strong) UIButton *closebtn;
@property (nonatomic , strong) UIScrollView *choosebuildingview;
@property (nonatomic , strong)SelectView *selectView;
@property ( nonatomic , strong )UIView *maskView;

-(void)initUI;
-(void)initDataSouce;
@end

@implementation SecDistributVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackgroundView.hidden = NO;
    [self initDataSouce];
    [self initUI];
    [self post];
    
}
-(void)post{
    
    [BaseRequest GET:GetAllBuilding_URL parameters:@{
                                                     @"project_id":_projiect_id
                                                     
                                                     }
             success:^(id resposeObject) {
                 
                 if ([resposeObject[@"code"] integerValue] ==200) {
                     _dylist = resposeObject[@"data"][0][@"rows"];
                     [self setItemforchoosebuildingviewbyarr:_dylist];
                 }
             }
             failure:^(NSError *error) {
                 
                 NSLog(@"%@",error.localizedDescription);
             }];
}

-(void)initUI
{
    if (_urlfor3d.length>0) {
        //    //2.创建URL
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_urlfor3d]];
        //    NSURL *URL = [NSURL URLWithString:@"http://www.ccsoft.com.cn"];
        
        //3.创建Request
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        //4.加载Request
        
        
        [self.webwivw loadRequest:request];
        [self.view addSubview:self.webwivw];
        
    }else{
        [self.view addSubview:self.backimg];
    }
    [self.view addSubview:self.leftbutton];
    [self.view addSubview:self.openbtn];
    [self.view addSubview:self.drawerview];
    [self.drawerview addSubview:self.closebtn];
    [self.drawerview addSubview:self.choosebuildingview];
    UISwipeGestureRecognizer * right=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_close)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right];
    
    UISwipeGestureRecognizer * left=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_open)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
    
}

-(void)initDataSouce
{
    
}

-(void)action_buildingchoose:(UIButton *)sender
{
    
    NSArray *arr=_dylist[sender.tag-1000][@"DYLIST"];
    _lddic =_dylist[sender.tag-1000];
    if (arr.count>0) {
        [self.selectView SetNumberOfItem:arr.count];
        self.selectView.frame = CGRectMake(75*SIZE, 174*SIZE, 212*SIZE, 49*SIZE*arr.count+49*SIZE);
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0,0 , 212*SIZE, 49*SIZE)];
        lab.text = [NSString stringWithFormat:@"%@单元选择",_dylist[sender.tag-1000][@"LDMC"]];
        lab.font = [UIFont systemFontOfSize:20*SIZE];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = COLOR(68, 68, 68, 1);
        [self.selectView addSubview:lab];
        for (int i = 0; i<arr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[NSString stringWithFormat:@"%@",arr[i][@"DYMC"]] forState:UIControlStateNormal];
            btn.titleLabel.font =[UIFont systemFontOfSize:17*SIZE];
            btn.tag = 100+i;
            btn.frame = CGRectMake(0, 49*SIZE+i*49*SIZE, 212*SIZE, 49*SIZE);
            [btn addTarget:self action:@selector(action_btn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:COLOR(68, 68, 68, 1) forState:UIControlStateNormal];
            [self.selectView addSubview:btn];
            UIView * lane = [[UIView alloc]initWithFrame:CGRectMake(0, 49*SIZE*i+48.5*SIZE, 212*SIZE, 1*SIZE)];
            lane.backgroundColor = COLOR(200, 200, 200, 1);
            [self.selectView addSubview:lane];
        }
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.selectView];
    }
    else{
        if ([self.status isEqualToString:@"release"] || [self.status isEqualToString:@"挂牌信息编辑"] || [self.status isEqualToString:@"protocol"] || [self.status isEqualToString:@"complete"] || [self.status isEqualToString:@"completeRent"] || [self.status isEqualToString:@"rent"]) {
            
            ReleaseSenceVC *next_vc = [[ReleaseSenceVC alloc]init];
            next_vc.project_id = _projiect_id;
            next_vc.build_id = _dylist[sender.tag-1000][@"LDID"];
            next_vc.unit_id = @"0";
            next_vc.LDdic = _lddic;
            next_vc.status = self.status;
            next_vc.comName = self.comName;
            next_vc.titleinfo = [NSString stringWithFormat:@"%@详情",_lddic[@"LDMC"]];
            [self.navigationController pushViewController:next_vc animated:YES];
        }else{
            
            HousedistributVC *next_vc = [[HousedistributVC alloc]init];
            next_vc.project_id = _projiect_id;
            next_vc.build_id = _dylist[sender.tag-1000][@"LDID"];
            next_vc.unit_id = @"0";
//            next_vc.titleStr = self.tit
            [self.navigationController pushViewController:next_vc animated:YES];
        }
    }
    
}

-(void)action_btn:(UIButton *)sender

{
    [self maskViewTap];
    if ([self.status isEqualToString:@"release"] || [self.status isEqualToString:@"protocol"] || [self.status isEqualToString:@"complete"] || [self.status isEqualToString:@"completeRent"] || [self.status isEqualToString:@"rent"]) {
        
        ReleaseSenceVC *next_vc = [[ReleaseSenceVC alloc]init];
        next_vc.project_id = _projiect_id;
        next_vc.status = self.status;
        next_vc.build_id = _lddic[@"LDID"];
        next_vc.unit_id =_lddic[@"DYLIST"][sender.tag-100][@"DYID"];
        next_vc.LDdic = _lddic;
        next_vc.titleinfo = [NSString stringWithFormat:@"%@%@详情",self.comName,_lddic[@"DYLIST"][sender.tag-100][@"DYMC"]];
        next_vc.comName = self.comName;
        next_vc.releaseSenceAddHouseBlock = ^(NSDictionary *dic) {
            
            if (self.secDistributAddHouseBlock) {
                
                self.secDistributAddHouseBlock(dic);
            }
        };
        [self.navigationController pushViewController:next_vc animated:YES];
    }else{
        
        HousedistributVC *next_vc = [[HousedistributVC alloc]init];
        next_vc.status = self.status;
        next_vc.project_id = _projiect_id;
        next_vc.build_id = _lddic[@"LDID"];
        next_vc.unit_id =_lddic[@"DYLIST"][sender.tag-100][@"DYID"];
        next_vc.LDdic = _lddic;
        next_vc.titleinfo = [NSString stringWithFormat:@"%@%@详情",self.comName,_lddic[@"DYLIST"][sender.tag-100][@"DYMC"]];
        [self.navigationController pushViewController:next_vc animated:YES];
    }
}

-(void)action_open
{
    [UIView animateWithDuration:0.4 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1 // 类似弹簧振动效果 0~1
          initialSpringVelocity:1 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         
                         _openbtn.alpha = 0;
                         _drawerview.frame = CGRectMake(247*SIZE, 0, 113*SIZE, SCREEN_Height);
                         
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         
                     }];
}

-(void)action_close
{
    [UIView animateWithDuration:0.4 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1 // 类似弹簧振动效果 0~1
          initialSpringVelocity:1 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         _openbtn.alpha = 1;
                         _drawerview.frame = CGRectMake(360*SIZE, 0, 113*SIZE, SCREEN_Height);
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         
                     }];
}

-(void)action_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImageView *)backimg
{
    if (!_backimg) {
        _backimg = [[UIImageView alloc]init];
        _backimg.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
        if (_img_name.length>0) {
            [_backimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_img_name]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                   _backimg.image = [UIImage imageNamed:@"banner_default_2"];
                }
            }];
        }
        else{
             _backimg.image = [UIImage imageNamed:@"banner_default_2"];
        }
        
    }
    return _backimg;
}

- (UIButton *)leftbutton {
    if (!_leftbutton) {
        _leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftbutton.center = CGPointMake(25 * SIZE, 20 + 22);
        _leftbutton.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        _leftbutton.center = CGPointMake(25 * SIZE, STATUS_BAR_HEIGHT+20);
        _leftbutton.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        [_leftbutton setImage:[UIImage imageNamed:@"leftarrow_white.png"] forState:UIControlStateNormal];
        [_leftbutton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftbutton;
}

-(UIButton *)openbtn
{
    if (!_openbtn) {
        _openbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openbtn.frame  = CGRectMake(305*SIZE, 303*SIZE, 60*SIZE, 33*SIZE);
        [_openbtn setImage:[UIImage imageNamed:@"an"] forState:UIControlStateNormal];
        [_openbtn addTarget:self action:@selector(action_open) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openbtn;
}
-(UIView *)drawerview
{
    if (!_drawerview) {
        _drawerview = [[UIView alloc]initWithFrame:CGRectMake(360*SIZE, 0, 113*SIZE, SCREEN_Height)];
        _drawerview.backgroundColor =[UIColor clearColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 113*SIZE, SCREEN_Height)];
        view.backgroundColor = COLOR(0, 0, 0, 0.5);
        [_drawerview addSubview:view];
    }
    return _drawerview;
}

-(UIButton *)closebtn
{
    if (!_closebtn) {
        _closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closebtn.frame = CGRectMake(13*SIZE, 314*SIZE, 9*SIZE, 15*SIZE);
        [_closebtn addTarget:self action:@selector(action_close) forControlEvents:UIControlEventTouchUpInside];
        [_closebtn setImage:[UIImage imageNamed:@"rightarrow_white"] forState:UIControlStateNormal];
    }
    return _closebtn;
}

-(UIScrollView *)choosebuildingview
{
    if (!_choosebuildingview) {
        _choosebuildingview = [[UIScrollView alloc]initWithFrame:CGRectMake(36*SIZE, 100*SIZE, 67*SIZE, SCREEN_Height-110*SIZE)];
        _choosebuildingview.backgroundColor = [UIColor clearColor];
    }
    return _choosebuildingview;
}

-(void)setItemforchoosebuildingviewbyarr:(NSArray *)arr
{
    _choosebuildingview.contentSize = CGSizeMake(67*SIZE, 35*SIZE+57*SIZE*arr.count);
    for (int i= 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = COLOR(240, 240, 240, 1);
        btn.frame = CGRectMake(0, i*57*SIZE, 67*SIZE, 33*SIZE);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2*SIZE;
        [btn setTitle:arr[i][@"LDMC"] forState:UIControlStateNormal];
        [btn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13*SIZE];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(action_buildingchoose:) forControlEvents:UIControlEventTouchUpInside];
        [_choosebuildingview addSubview:btn];
    }
}

-(SelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[SelectView alloc]init];
        _selectView.backgroundColor = [UIColor whiteColor];
        _selectView.layer.masksToBounds = YES;
        _selectView.layer.cornerRadius = 4*SIZE;
    }
    return _selectView;
}


- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (void)maskViewTap {
    for(UIView *view in [self.selectView subviews])
    {
        [view removeFromSuperview];
    }
    [self.selectView removeFromSuperview];
    [self.maskView removeFromSuperview];
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
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
//    [self showContent:@"网络错误"];
//
//}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
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
    
    if (_webwivw) {
        [_webwivw stopLoading];
        
    }
    [WaitAnimation stopAnimation];
}

@end
