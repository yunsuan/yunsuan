//
//  LDetailViewController.m
//  教育资格证培训
//
//  Created by 赖星果 on 16/7/7.
//  Copyright © 2016年 赖星果. All rights reserved.
//

#import "LDetailViewController.h"
//#import "LCommentTableViewCell.h"
//#import "LRecruitRuleViewController.h"
//分享
//#import "UMSocial.h"
//#import "UMSocialSnsPlatformManager.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialSinaSSOHandler.h"




@interface LDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate> {
    NSArray *_buttonArr;
    NSInteger canComment;
}

@property (nonatomic, strong)UITableView *commentTableView;
@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)UIWebView *detailWebView;
@property (nonatomic, strong)UIView *examDetailView;
@property (nonatomic, strong)UITextView *commentTextView;
@property (nonatomic, strong)UILabel *placeholderLabel;
//@property (nonatomic, strong)BaseAPIManager *APIManager;
@property (nonatomic, strong)UIButton *reloadBtn;
@property (nonatomic, strong)NSString *shareurl;



- (void)initDetailDataSource;
- (void)initDetailInterface;

@end

@implementation LDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [SVProgressHUD show];
    NSDictionary *dic = [[NSDictionary alloc] init];
    switch (_type) {
        case 1:
        {
            //dic = @{@"phone_number":[InfoCenterArchiver unarchive].phone_number, @"type":@(1), @"id":_data[@"r_id"]};
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:@(1),@"type",_data[@"r_id"],@"id",[US] unarchive].phone_number,@"phone_number",nil];
            break;
        }
        case 2:
        {
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:@(2),@"type",_data[@"tg_id"],@"id",[InfoCenterArchiver unarchive].phone_number,@"phone_number",nil];
            break;
        }
        case 3:
        {
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:@(3),@"type",_data[@"g_id"],@"id",[InfoCenterArchiver unarchive].phone_number,@"phone_number",nil];
            break;
        }
        default:
            break;
    }
    [BaseRequest POST:@"getInformationDetail" parameters:dic success:^(id resposeObject) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.cdytjy.com%@",resposeObject[@"data"][@"url"]]]];
        [_detailWebView loadRequest:request];
//        self.praiseButton.selected = [resposeObject[@"data"][@"like"] boolValue];
//        self.collectButton.selected = [resposeObject[@"data"][@"collect"] boolValue];
//
//        canComment = [resposeObject[@"data"][@"canComment"] boolValue];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (canComment) {
//                [_headView addSubview:self.commentTextView];
//                UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(15.5 * SIZE, 596 * SIZE, 35 * SIZE, 35 * SIZE)];
//                head.image = IMAGE_WITH_NAME(@"img_1.04touxiang1@2x.png");
//                [_headView addSubview:head];
//                UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                commitBtn.frame = CGRectMake(249.5 * SIZE, 650.5 * SIZE, 60 * SIZE, 26 * SIZE);
//                [commitBtn setBackgroundImage:IMAGE_WITH_NAME(@"btn_1.04tijiao@2x.png") forState:UIControlStateNormal];
//                [commitBtn addTarget:self action:@selector(action_commitBtn) forControlEvents:UIControlEventTouchUpInside];
//                [_headView addSubview:commitBtn];
//            }else{
//                UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(47 * SIZE, 596 * SIZE, 242 * SIZE, 47 * SIZE)];
//                textview.text = @"评论被关闭，暂时无法评论";
//                textview.font = [UIFont systemFontOfSIZE:18];
//                textview.backgroundColor = [UIColor clearColor];
//                textview.editable = NO;
//                [_headView addSubview:textview];
//            }
//            [self.commentTextView reloadInputViews];
//        });
    
     
//     [SVProgressHUD dismiss];

    } failure:^(NSError *error) {
        
    }   ];
//    [self.APIManager startRequestURL:@"getInformationDetail" parameters:dic success:^(id responds) {
//        if ([responds[@"msg"] isEqualToString:@"success"]) {
//
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.cdytjy.com%@",responds[@"data"][@"url"]]]];
//        [_detailWebView loadRequest:request];
//        self.praiseButton.selected = [responds[@"data"][@"like"] boolValue];
//        self.collectButton.selected = [responds[@"data"][@"collect"] boolValue];
//
//        canComment = [responds[@"data"][@"canComment"] boolValue];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (canComment) {
//                [_headView addSubview:self.commentTextView];
//                UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(15.5 * SIZE, 596 * SIZE, 35 * SIZE, 35 * SIZE)];
//                head.image = IMAGE_WITH_NAME(@"img_1.04touxiang1@2x.png");
//                [_headView addSubview:head];
//                UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                commitBtn.frame = CGRectMake(249.5 * SIZE, 650.5 * SIZE, 60 * SIZE, 26 * SIZE);
//                [commitBtn setBackgroundImage:IMAGE_WITH_NAME(@"btn_1.04tijiao@2x.png") forState:UIControlStateNormal];
//                [commitBtn addTarget:self action:@selector(action_commitBtn) forControlEvents:UIControlEventTouchUpInside];
//                [_headView addSubview:commitBtn];
//            }else{
//                UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(47 * SIZE, 596 * SIZE, 242 * SIZE, 47 * SIZE)];
//                textview.text = @"评论被关闭，暂时无法评论";
//                textview.font = [UIFont systemFontOfSIZE:18];
//                textview.backgroundColor = [UIColor clearColor];
//                textview.editable = NO;
//                [_headView addSubview:textview];
//            }
//            [self.commentTextView reloadInputViews];
//            
//        });
//        }
//        
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        
//    } timeout:5];
//    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(243, 243, 243, 1);
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = self.titleStr;
    [self.leftButton setImage:[UIImage imageNamed:@"btn_fanhui@2x.png"] forState:UIControlStateNormal];
//    [self.leftButton setImage:IMAGE_WITH_NAME(@"btn_fanhui@2x.png") forState:UIControlStateNormal];
    [self.maskButton addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
//    [self.praiseButton addTarget:self action:@selector(action_praiseButton:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.collectButton addTarget:self action:@selector(action_collectButton:) forControlEvents:UIControlEventTouchUpInside];
 
    [self initDetailDataSource];
    [self initDetailInterface];
}

#pragma mark - init

- (void)initDetailDataSource {
    _buttonArr = [NSArray array];
    _buttonArr = @[@"btn_1.04QQ@2x.png", @"btn_1.04weixin@2x.png", @"btn_1.04pengyouquan@2x.png", @"btn_1.04weibo@2x.png"];
    NSDictionary *dic = [[NSDictionary alloc]init];
    switch (_type) {
        case 1:
        {
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:@(1),@"type",_data[@"r_id"],@"id",[InfoCenterArchiver unarchive].phone_number,@"phone_number",nil];
            break;
        }
            case 2:
        {
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:@(2),@"type",_data[@"tg_id"],@"id",[InfoCenterArchiver unarchive].phone_number,@"phone_number",nil];
            break;
        }
            case 3:
        {
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:@(3),@"type",_data[@"g_id"],@"id",[InfoCenterArchiver unarchive].phone_number,@"phone_number",nil];
            break;
        }
        default:
            break;
    }
    if (_data.count != 0) {
//        [SVProgressHUD show];
//        [self.APIManager startRequestURL:@"getInformationDetail" parameters:dic success:^(id responds) {
//
//            NSLog(@"%@",responds[@"msg"]);
//            if ([responds[@"msg"] isEqualToString:@"success"]) {
//
//
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.cdytjy.com%@",responds[@"data"][@"url"]]]];
//                _shareurl = [NSString stringWithFormat:@"http://www.cdytjy.com%@",responds[@"data"][@"url"]];
//            [_detailWebView loadRequest:request];
//            self.praiseButton.selected = [responds[@"data"][@"like"] boolValue];
//            self.collectButton.selected = [responds[@"data"][@"collect"] boolValue];
       
//            canComment = [responds[@"data"][@"canComment"] boolValue];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (canComment) {
//                    [_headView addSubview:self.commentTextView];
//                    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(15.5 * SIZE, 596 * SIZE, 35 * SIZE, 35 * SIZE)];
//                    head.image = IMAGE_WITH_NAME(@"img_1.04touxiang1@2x.png");
//                    [_headView addSubview:head];
//                    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    commitBtn.frame = CGRectMake(249.5 * SIZE, 650.5 * SIZE, 60 * SIZE, 26 * SIZE);
//                    [commitBtn setBackgroundImage:IMAGE_WITH_NAME(@"btn_1.04tijiao@2x.png") forState:UIControlStateNormal];
//                    [commitBtn addTarget:self action:@selector(action_commitBtn) forControlEvents:UIControlEventTouchUpInside];
//                    [_headView addSubview:commitBtn];
//                }else{
//                    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(47 * SIZE, 596 * SIZE, 242 * SIZE, 47 * SIZE)];
//                    textview.text = @"评论被关闭，暂时无法评论";
//                    textview.font = [UIFont systemFontOfSIZE:18];
//                    textview.backgroundColor = [UIColor clearColor];
//                    textview.editable = NO;
//                    [_headView addSubview:textview];
//                }
//                [self.commentTextView reloadInputViews];
                
//            });
//            }
//            else
//            {
//                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 200*SIZE+64, 160*SIZE, 40*SIZE)];
//                lab.text = @"该内容已经被删除";
//                lab.textAlignment = NSTextAlignmentCenter;
//                lab.font = [UIFont boldSystemFontOfSIZE:17*SIZE];
//                [self.view addSubview:lab];
            
//            }
        
//            [SVProgressHUD dismiss];
//        } failure:^(NSError *error) {
//
//        } timeout:5];

    }else{
        
    }
    
}

- (void)initDetailInterface {
    
        [self.view addSubview:self.commentTableView];
    
}

#pragma mark - action
- (void)action_back {
//    if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//        [InfoCenter defaultsInfoCenter].newMessage = ![InfoCenter defaultsInfoCenter].newMessage;
//    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

////点赞
//- (void)action_praiseButton:(UIButton *)sender {
//      if ([self goToLogin]) {
//    sender.selected = !sender.selected;
//    switch (_type) {
//        case 1:{
//            if (sender.selected == YES) {
//                NSDictionary *dic =@{
//                                     @"id":_data[@"r_id"],
//                                     @"phone_number":[InfoCenterArchiver unarchive].phone_number,
//                                     @"type":@"1",
//                                     @"like":@"1"
//                                     };
////                [SVProgressHUD show];
//                [BaseNetRequest POST:@"doLikeMod" parameters:dic success:^(id resposeObject) {
//
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }else {
//                NSDictionary *dic =@{
//                                     @"id":_data[@"r_id"],
//                                     @"phone_number":[InfoCenterArchiver unarchive].phone_number,
//                                     @"type":@"1",
//                                     @"like":@"0"
//                                     };
//                [BaseNetRequest POST:@"doLikeMod" parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }
//            break;
//
//        }
//            case 2:
//        {
//
//            if (sender.selected == YES) {
//                NSDictionary *dic =@{
//                                     @"id":_data[@"tg_id"],
//                                     @"phone_number":[InfoCenterArchiver unarchive].phone_number,
//                                     @"type":@"2",
//                                     @"like":@"1"
//                                     };
////                [SVProgressHUD show];
//                [BaseNetRequest POST:@"doLikeMod" parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }else {
////                [SVProgressHUD show];
//                NSDictionary *dic =@{
//                                     @"id":_data[@"tg_id"],
//                                     @"phone_number":[InfoCenterArchiver unarchive].phone_number,
//                                     @"type":@"2",
//                                     @"like":@"0"
//                                     };
//                [BaseNetRequest POST:@"doLikeMod" parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }
//            break;
//        }
//            case 3:
//        {
//            if (sender.selected == YES) {
//                NSDictionary *dic =@{
//                                     @"id":_data[@"g_id"],
//                                     @"phone_number":[InfoCenterArchiver unarchive].phone_number,
//                                     @"type":@"3",
//                                     @"like":@"1"
//                                     };
////                [SVProgressHUD show];
//                [BaseNetRequest POST:@"doLikeMod" parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }else {
////                [SVProgressHUD show];
//                NSDictionary *dic =@{
//                                     @"id":_data[@"g_id"],
//                                     @"phone_number":[InfoCenterArchiver unarchive].phone_number,
//                                     @"type":@"3",
//                                     @"like":@"0"
//                                     };
//                [BaseNetRequest POST:@"doLikeMod" parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }
//            break;
//        }
//        default:
//            break;
//    }
//      }
//
//}
//
////收藏
//- (void)action_collectButton:(UIButton *)sender {
//      if ([self goToLogin]) {
//    sender.selected = !sender.selected;
//    switch (_type) {
//        case 1:{
//            NSDictionary *dic =@{
//                                 @"r_id":_data[@"r_id"],
//                                 @"phone_number":[InfoCenterArchiver unarchive].phone_number
//                                 };
//            if (sender.selected == YES) {
////                [SVProgressHUD show];
//                [BaseNetRequest POST:Student_Collect_URL parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//            }else {
////                [SVProgressHUD show];
//                [BaseNetRequest POST:Cance_Collect_URL parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }
//            break;
//        }
//        case 2:
//        {
//            NSDictionary *dic =@{
//                                 @"tg_id":_data[@"tg_id"],
//                                 @"phone_number":[InfoCenterArchiver unarchive].phone_number
//                                 };
//            if (sender.selected == YES) {
////                [SVProgressHUD show];
//                [BaseNetRequest POST:Student_Collect_URL parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }else {
////                [SVProgressHUD show];
//                [BaseNetRequest POST:Cance_Collect_URL parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }
//            break;
//        }
//            case 3:
//        {
//            NSDictionary *dic =@{
//                                 @"g_id":_data[@"g_id"],
//                                 @"phone_number":[InfoCenterArchiver unarchive].phone_number
//                                 };
//            if (sender.selected == YES) {
////                [SVProgressHUD show];
//                [BaseNetRequest POST:Student_Collect_URL parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//
//            }else {
////                [SVProgressHUD show];
//                [BaseNetRequest POST:Cance_Collect_URL parameters:dic success:^(id resposeObject) {
//                    if ([resposeObject[@"status"] integerValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:resposeObject[@"msg"]];
//                    }
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [SVProgressHUD dismiss];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//            }
//        }
//        default:
//            break;
//    }
//      }
//}


////分享按钮
//- (void)action_shareBtn:(UIButton *)sender {
//    NSString *str;
//    if (_type == 1) {
//        str = _data[@"real_title"];
//    }
//    if (_type == 2) {
//        str = _data[@"g_title"];
//    }
//    if (_type == 3) {
//        str = _data[@"gen_title"];
//    }
//    switch (sender.tag) {
//
//        case 100:
//        {
//
//            //QQ
//            //分享到QQ
//            [UMSocialQQHandler setQQWithAppId:QQAPP_ID appKey:QQAPP_KEY url:_shareurl];
//            //分享QQ
//            [UMSocialData defaultData].extConfig.qqData.url = _shareurl;
//            [UMSocialData defaultData].extConfig.qqData.title = @"教师资格证";
//
//            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:str image:[UIImage imageNamed:@"shareicon"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//
//                    NSLog(@"分享成功！");
//                }else{
//                    NSLog(@"分享失败！");
//                }
//            }];
//
//
//        }
//            break;
//        case 101:
//        {
//
//            //微信好友
//            [UMSocialWechatHandler setWXAppId:WXAPP_ID appSecret:WXAPP_SECRET url:_shareurl];
//            [UMSocialData defaultData].extConfig.wechatSessionData.url = _shareurl;
//            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"教师资格证";
//            [[UMSocialDataService  defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:str image:[UIImage imageNamed:@"shareicon"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
//
//            }];
//
//        }
//            break;
//        case 102:
//        {
//
//            //朋友圈
//            [UMSocialWechatHandler setWXAppId:WXAPP_ID appSecret:WXAPP_SECRET url:_shareurl];
//            [UMSocialData defaultData].extConfig.wechatTimelineData.url = _shareurl;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.title = [ NSString stringWithFormat:@"教师资格证-%@",str];;
//            [[UMSocialDataService  defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:str image:[UIImage imageNamed:@"shareicon"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
//            }];
//
//        }
//            break;
//        case 103:
//        {
//
//            //微博
//            [UMSocialData defaultData].extConfig.sinaData.urlResource.url = _shareurl;
//            [UMSocialData defaultData].extConfig.sinaData.snsName = @"教师资格证";
//            [[UMSocialControllerService defaultControllerService] setShareText:_shareurl shareImage:[UIImage imageNamed:@"shareicon"] socialUIDelegate:nil];
//
//            //设置分享内容和回调对象
//            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//                NSLog(@"response is %@",response);
//            }];
//
//        }
//            break;
//
//        default:
//            break;
//    }
//}

////提交评论
//- (void)action_commitBtn {
//      if ([self goToLogin]) {
//          NSString *temp = [self.commentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    if (self.commentTextView.text.length != 0 && temp.length != 0) {
//        switch (_type) {
//            case 1:
//            {
//                NSDictionary *dic = @{
//                                      @"content" : self.commentTextView.text,
//                                      @"phone_number": [InfoCenterArchiver unarchive].phone_number,
//                                      @"id" : _data[@"r_id"],
//                                      @"type":@"1"
//                                      };
//                [SVProgressHUD showWithStatus:@"评论中"];
//                _headView.userInteractionEnabled = NO;
//                [BaseNetRequest POST:@"doCommentMod" parameters:dic success:^(id resposeObject) {
//
//                    [SVProgressHUD showSuccessWithStatus:@"评论成功"];
//                     _headView.userInteractionEnabled = YES;
//                } failure:^(NSError *error) {
//                     [SVProgressHUD showErrorWithStatus:@"评论失败"];
//                     _headView.userInteractionEnabled = YES;
//                }];
//                break;
//            }
//
//                case 2:
//            {
//                {
//                    NSDictionary *dic = @{
//                                          @"content" : self.commentTextView.text,
//                                          @"phone_number": [InfoCenterArchiver unarchive].phone_number,
//                                          @"id" : _data[@"tg_id"],
//                                          @"type":@"2"
//                                          };
//                    [SVProgressHUD showWithStatus:@"评论中"];
//                    _headView.userInteractionEnabled = NO;
//                    [BaseNetRequest POST:@"doCommentMod" parameters:dic success:^(id resposeObject) {
//
//                        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
//                        _headView.userInteractionEnabled = YES;
//                    } failure:^(NSError *error) {
//                         [SVProgressHUD showErrorWithStatus:@"评论失败"];
//                        _headView.userInteractionEnabled = YES;
//                    }];
//                }
//                break;
//            }
//                case 3:
//            {
//                NSDictionary *dic = @{
//                                      @"id" : _data[@"g_id"],
//                                        @"phone_number": [InfoCenterArchiver unarchive].phone_number,
//                                      @"content" : self.commentTextView.text,
//                                      @"type":@"3"
//                                    };
//                [SVProgressHUD showWithStatus:@"评论中"];
//                _headView.userInteractionEnabled = NO;
//                [self.APIManager startRequestURL:@"doCommentMod" parameters:dic success:^(id responds) {
//
//                    [SVProgressHUD showSuccessWithStatus:@"评论成功"];
//                    _headView.userInteractionEnabled = YES;
//                } failure:^(NSError *error) {
//                    [SVProgressHUD showErrorWithStatus:@"评论失败"];
//                    _headView.userInteractionEnabled = YES;
//                } timeout:5];
//
//            }
//            default:
//                break;
//        }
//        NSDictionary *dic = @{
//                              @"c_content" : self.commentTextView.text,
//                              @"phone_number": [InfoCenterArchiver unarchive].phone_number
//                              };
//
//        NSMutableArray *arr =  [_contentdata mutableCopy];
//        [arr addObject:dic];
//        _contentdata = arr;
//        if (_reloadBtn) {
//            [_reloadBtn removeFromSuperview];
//        }
//
//        [_commentTableView reloadData];
//        _commentTextView.text = @"";
//
//
//    }
//    else{
//        [self alertControllerWithNsstring:@"温馨提示" And:@"输入框不能为空"];
//    }
//         }
//
//}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentdata.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:self.commentTableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"commentCell";
////    NSString *CellIdentifier = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
//    LCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[LCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
////    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
////    for (UIView *subview in subviews) {
////        [subview removeFromSuperview];
////    }
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i < _contentdata.count; i++) {
//        [arr addObject:_contentdata[_contentdata.count - i - 1]];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell setSubjectLabelText:arr[indexPath.row][@"c_content"]];
//    cell.nameLabel.text = arr[indexPath.row][@"phone_number"];
//    return cell;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"commentCell";
//    LCommentTableViewCell *cell ;
//
//    if (cell == nil) {
//        cell = [[LCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    else
//    {
//        cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//    }
//
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell setSubjectLabelText:_contentdata[_contentdata.count-indexPath.row-1][@"c_content"]];
//    NSString *str = _contentdata[_contentdata.count-indexPath.row-1][@"phone_number"];
//    cell.nameLabel.text =[NSString stringWithFormat:@"%@*********",[str substringWithRange:NSMakeRange(0, 3)]];
//
//    return cell;
//}

#pragma mark - <UITextViewDelegate>
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

#pragma mark - getter
- (UIWebView *)detailWebView {
    if (!_detailWebView) {
        _detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 392 * SIZE)];
        _detailWebView.backgroundColor = COLOR(243, 243, 243, 1);
        //_detailWebView.scrollView.scrollEnabled = NO;
        //_detailWebView.delegate = self;
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com"]];
//        [_detailWebView loadRequest:request];
    }
    return _detailWebView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 692 * SIZE)];
        _headView.backgroundColor = COLOR(243, 243, 243, 1);
        [_headView addSubview:self.detailWebView];
//        if ([InfoCenter defaultsInfoCenter].arr.count != 0) {
//            [_headView addSubview:self.examDetailView];
//        }else{
            UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 402 * SIZE, SCREEN_Width, 80 * SIZE)];
            textview.text = @"暂无推荐";
            textview.editable = NO;
            textview.textAlignment = 1;
            textview.font = [UIFont systemFontOfSize:18 * SIZE];
            [_headView addSubview:textview];
//        }
        
        
        for (int i = 0; i < 2; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((40 + 146 * i) * SIZE, 496 * SIZE, 94 * SIZE, 0.5)];
            line.backgroundColor = COLOR(200, 200, 200, 1);
            [_headView addSubview:line];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(134 * SIZE, 490 * SIZE, 52 * SIZE, 14 * SIZE)];
        label.text = @"分享到";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10 * SIZE];
        label.textColor = COLOR(184, 184, 184, 1);
        [_headView addSubview:label];
        
        for (int i = 0; i < 4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((39 + 60.5 * i) * SIZE, 502 * SIZE, 60.5 * SIZE, 60.5 * SIZE);
//            [button setBackgroundImage:IMAGE_WITH_NAME(_buttonArr[i]) forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:_buttonArr[i]] forState:UIControlStateNormal];
            button.tag = 100 + i;
//            [button addTarget:self action:@selector(action_shareBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:button];
        }
        for (int i = 0; i < 3; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((99.5 + 60.5 * i) * SIZE, 522 * SIZE, 0.5, 20 * SIZE)];
            line.backgroundColor = COLOR(200, 200, 200, 1);
            [_headView addSubview:line];
        }
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(9 * SIZE, 567.5 * SIZE, 54 * SIZE, 18.5 * SIZE)];
        label2.text = @"我要评论";
        label2.font = [UIFont systemFontOfSize:13 * SIZE];
        label2.textColor = COLOR(52, 52, 52, 1);
        [_headView addSubview:label2];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(70.5 * SIZE, 576.5 * SIZE, 249.5 * SIZE, 0.5 * SIZE)];
        line.backgroundColor = COLOR(153, 153, 153, 1);
        [_headView addSubview:line];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(9 * SIZE, 673.5 * SIZE, 54 * SIZE, 18.5 * SIZE)];
        label3.text = @"其他评论";
        label3.font = [UIFont systemFontOfSize:13 * SIZE];
        label3.textColor = COLOR(52, 52, 52, 1);
        [_headView addSubview:label3];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(70.5 * SIZE, 683.5 * SIZE, 249.5 * SIZE, 0.5 * SIZE)];
        line2.backgroundColor = COLOR(153, 153, 153, 1);
        [_headView addSubview:line2];
    }
    return _headView;
}

- (UITextView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(66 * SIZE, 596 * SIZE, 242 * SIZE, 47 * SIZE)];
        _commentTextView.delegate = self;
        _commentTextView.layer.cornerRadius = 5 * SIZE;
        _commentTextView.clipsToBounds = YES;
        _commentTextView.font = [UIFont systemFontOfSize:14 * SIZE];
        _commentTextView.textColor = COLOR(79, 79, 79, 1);
        _commentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
      
        [_commentTextView addSubview:self.placeholderLabel];
    }
    return _commentTextView;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.5 * SIZE, 3 * SIZE, 150 * SIZE, 18.5 * SIZE)];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:13 * SIZE];
        _placeholderLabel.textColor = COLOR(205, 205, 205, 1);
        _placeholderLabel.text = @"忍不了了，我来说两句～";
    }
    return _placeholderLabel;
}

- (UIView *)examDetailView {
    if (!_examDetailView) {
            _examDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 402 * SIZE, SCREEN_Width, 80 * SIZE)];
            _examDetailView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *informationImg = [[UIImageView alloc] initWithFrame:CGRectMake(13 * SIZE, 10 * SIZE, 90 * SIZE, 60 * SIZE)];
//            informationImg.image = IMAGE_WITH_NAME(@"img_1.01tu@2x.png");
        informationImg.image = [UIImage imageNamed:@"img_1.01tu@2x.png"];
//            switch (_type) {
//                case 1:
//                    [informationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BasePhoto_URL,_data[@"real_img"]]]];
//                    break;
//                case 2:
//                    //                    [informationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BasePhoto_URL,_data[@"photo"]]]];
//                    break;
//                case 3:
//                    [informationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BasePhoto_URL,_data[@"gen_img"]]]];
//                    break;
//                default:
//                    break;
//            }
//        if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//            if (![InfoCenter defaultsInfoCenter].newMessage) {
//                [informationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BasePhoto_URL,[InfoCenter defaultsInfoCenter].arr[0][@"gen_img"]]]];
//            }
//            else{
//                [informationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BasePhoto_URL,[InfoCenter defaultsInfoCenter].arr[1][@"gen_img"]]]];
//            }
//        }else{
//            [informationImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BasePhoto_URL,[InfoCenter defaultsInfoCenter].arr[0][@"gen_img"]]]];
//        }
        
        
            [_examDetailView addSubview:informationImg];
            
            UILabel *informationLabel = [[UILabel alloc] initWithFrame:CGRectMake(115 * SIZE, 7.5 * SIZE, 191 * SIZE, 42 * SIZE)];
            informationLabel.font = [UIFont systemFontOfSize:15 * SIZE];
            informationLabel.textColor = COLOR(60, 67, 80, 1);
            informationLabel.numberOfLines = 0;
//            switch (_type) {
//                case 1:
//                    informationLabel.text = _data[@"gen_title"];
//                    break;
//                case 2:
//                    informationLabel.text = _data[@"gen_title"];
//                    break;
//                case 3:
//                    informationLabel.text = _data[@"gen_title"];
//                    break;
//                default:
//                    break;
//            }
//        if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//            if (![InfoCenter defaultsInfoCenter].newMessage) {
//                informationLabel.text = [InfoCenter defaultsInfoCenter].arr[0][@"gen_title"];
//            }else{
//                informationLabel.text = [InfoCenter defaultsInfoCenter].arr[1][@"gen_title"];
//            }
//        }else{
//           informationLabel.text = [InfoCenter defaultsInfoCenter].arr[0][@"gen_title"];
//        }
            [_examDetailView addSubview:informationLabel];
            
            UIButton *praise = [UIButton buttonWithType:UIButtonTypeCustom];
            praise.frame = CGRectMake(115.8 * SIZE, 56.6 * SIZE, 9.3 * SIZE, 7.9 * SIZE);
//            [praise setBackgroundImage:IMAGE_WITH_NAME(@"icon_1.01weizan@2x.png") forState:UIControlStateNormal];
//            [praise setBackgroundImage:IMAGE_WITH_NAME(@"icon_1.01zan@2x.png") forState:UIControlStateSelected];
            [_examDetailView addSubview:praise];
            
            UILabel *praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(129.7 * SIZE, 51.5 * SIZE, 40* SIZE, 19 * SIZE)];
            praiseLabel.font = [UIFont systemFontOfSize:12 * SIZE];
            praiseLabel.textColor = COLOR(157, 161, 167, 1);
//            switch (_type) {
//                case 1:
//                    praiseLabel.text = _data[@"real_upnum"];
//                    break;
//                case 2:
//                    praiseLabel.text = _data[@"gup_num"];
//                    break;
//                case 3:
//                    praiseLabel.text = _data[@"up_num"];
//                    
//                    
//                default:
//                    break;
//            }
        
//        if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//            if (![InfoCenter defaultsInfoCenter].newMessage) {
//                praiseLabel.text = [InfoCenter defaultsInfoCenter].arr[0][@"up_num"];
//            }else{
//                praiseLabel.text = [InfoCenter defaultsInfoCenter].arr[1][@"up_num"];
//            }
//        }else{
//            praiseLabel.text = [InfoCenter defaultsInfoCenter].arr[0][@"up_num"];
//        }
        
        
            
            [_examDetailView addSubview:praiseLabel];
            
            UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
            collect.frame = CGRectMake(170 * SIZE, 56.6 * SIZE, 9.3 * SIZE, 7.9 * SIZE);
//            [collect setBackgroundImage:IMAGE_WITH_NAME(@"icon_1.01pinglun@2x.png") forState:UIControlStateNormal];
            [_examDetailView addSubview:collect];
            
            UILabel *collectLabel = [[UILabel alloc] initWithFrame:CGRectMake(182 * SIZE, 51.5 * SIZE, 40* SIZE, 19 * SIZE)];
            collectLabel.font = [UIFont systemFontOfSize:12 * SIZE];
            collectLabel.textColor = COLOR(157, 161, 167, 1);
//            switch (_type) {
//                case 1:
//                    collectLabel.text = _data[@"real_review"];
//                    break;
//                case 2:
//                    collectLabel.text = _data[@"g_review"];
//                    break;
//                case 3:
//                    collectLabel.text = _data[@"gen_review"];
//                    break;
//                    
//                default:
//                    break;
//            }
//        if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//            if (![InfoCenter defaultsInfoCenter].newMessage) {
//                collectLabel.text = [InfoCenter defaultsInfoCenter].arr[0][@"gen_review"];
//            }else{
//                collectLabel.text = [InfoCenter defaultsInfoCenter].arr[1][@"gen_review"];
//            }
//        }else{
//            collectLabel.text = [InfoCenter defaultsInfoCenter].arr[0][@"gen_review"];
//        }
            [_examDetailView addSubview:collectLabel];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        [_examDetailView addGestureRecognizer:tapGesture];
        }
    return _examDetailView;
}
- (UIButton *)reloadBtn
{
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_reloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_reloadBtn setTitle:@"暂时没有评论 点击刷新" forState:UIControlStateNormal];
        _reloadBtn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60*SIZE);
   
    }
    return _reloadBtn;
}

- (UITableView *)commentTableView {
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_Width, SCREEN_Height - 64) style:UITableViewStylePlain];
        _commentTableView.backgroundColor = COLOR(243, 243, 243, 1);
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.tableHeaderView = self.headView;
        if (_contentdata.count == 0) {
            _commentTableView.tableFooterView =self.reloadBtn;
        }
        [_commentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _commentTableView;
}
//- (BaseAPIManager *)APIManager{
//    if (!_APIManager) {
//        _APIManager = [[BaseAPIManager alloc]init];
//    }
//    return _APIManager;
//}

//- (void)Actiondo:(id)sender{
//    if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//        [InfoCenter defaultsInfoCenter].newMessage = ![InfoCenter defaultsInfoCenter].newMessage;
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    });
//    NSDictionary *dic ;
//    if (![InfoCenter defaultsInfoCenter].newMessage) {
//        dic = @{
//                @"g_id": [InfoCenter defaultsInfoCenter].arr[1][@"g_id"]
//                };
//        
//    }else{
//        dic =@{
//               @"g_id": [InfoCenter defaultsInfoCenter].arr[0][@"g_id"]
//               };
//    }
//    [SVProgressHUD show];
//    
//    [BaseNetRequest POST:Get_Gen_URL parameters:dic success:^(id resposeObject) {
//        NSLog(@"%@",resposeObject);
//        LDetailViewController *detail_vc = [[LDetailViewController alloc] init];
//        if ([InfoCenter defaultsInfoCenter].arr.count > 1) {
//            if (![InfoCenter defaultsInfoCenter].newMessage){
//                detail_vc.data = [InfoCenter defaultsInfoCenter].arr[1];
//                detail_vc.titleStr = [InfoCenter defaultsInfoCenter].arr[1][@"gen_title"];
//            }else{
//                detail_vc.data = [InfoCenter defaultsInfoCenter].arr[0];
//                detail_vc.titleStr = [InfoCenter defaultsInfoCenter].arr[0][@"gen_title"];
//            }
//        }else{
//            detail_vc.data = [InfoCenter defaultsInfoCenter].arr[1];
//            detail_vc.titleStr = [InfoCenter defaultsInfoCenter].arr[1][@"gen_title"];
//        }
//        detail_vc.contentdata = resposeObject[@"data"];
//        detail_vc.type = 3;
//        [self.navigationController pushViewController:detail_vc animated:YES];
//        [SVProgressHUD dismiss];
//    } failure:^(NSError *error) {
//        
//    }];
//}


@end
