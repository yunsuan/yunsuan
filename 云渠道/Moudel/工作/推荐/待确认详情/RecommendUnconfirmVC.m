//
//  RecommendUnconfirmVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/18.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendUnconfirmVC.h"

#import "UnconfirmDetailVC.h"
#import "CompleteCustomVC1.h"
#import "SignFailVC.h"

#import "RecommendCell.h"

#import "InvalidView.h"
#import "SignSelectWorkerView.h"
#import "SignFailView.h"

#import "CodeView.h"

@interface RecommendUnconfirmVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
    UIImage *_image;
}

@property (nonatomic , strong) UITableView *MainTableView;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation RecommendUnconfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    [self RequestMethod];
}

-(void)initDateSouce
{
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
    
        [BaseRequest GET:BrokerWaitConfirm_URL parameters:dic success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_dataArr removeAllObjects];
                [_MainTableView reloadData];
                if ([resposeObject[@"data"][@"data"] count]) {
                    
                    [_MainTableView.mj_footer endRefreshing];
                    [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                }else{
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
            else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [_MainTableView.mj_header endRefreshing];
            [self showContent:@"网络错误"];
        }];
    }else{
    
        [BaseRequest GET:ButterWaitConfirm_URL parameters:dic success:^(id resposeObject) {
            
            [_MainTableView.mj_header endRefreshing];
        
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_dataArr removeAllObjects];
                [_MainTableView reloadData];
                if ([resposeObject[@"data"] count]) {
                    
                    [self SetUnComfirmArr:resposeObject[@"data"]];
                    _MainTableView.mj_footer.state = MJRefreshStateIdle;
                }else{
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
            else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [_MainTableView.mj_header endRefreshing];
            [self showContent:@"网络错误"];
        }];
    }
}

- (void)RequestAddMethod{
    
    _page += 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        [BaseRequest GET:BrokerWaitConfirm_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"][@"data"] count]) {
                    
                    [_MainTableView.mj_footer endRefreshing];
                    [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                }else{
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
            else{
                
                _page -= 1;
                [_MainTableView.mj_footer endRefreshing];
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            _page -= 1;
            [_MainTableView.mj_footer endRefreshing];
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [BaseRequest GET:ButterWaitConfirm_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if ([resposeObject[@"data"] count]) {
                    
                    [self SetUnComfirmArr:resposeObject[@"data"]];
                    _MainTableView.mj_footer.state = MJRefreshStateIdle;
                }else{
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
            }
            else{
                
                _page -= 1;
                [_MainTableView.mj_footer endRefreshing];
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            _page -= 1;
            [_MainTableView.mj_footer endRefreshing];
            [self showContent:@"网络错误"];
        }];
    }
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"RecommendCell";
    
    RecommendCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.tag = indexPath.row;

    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        cell.QRCodeBtn.hidden = NO;
    }else{
        
        cell.QRCodeBtn.hidden = YES;
    }
    
    
    cell.recommendCellQRBlock = ^(NSInteger index) {
      
        CodeView *view = [[CodeView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        view.customL.text = [NSString stringWithFormat:@"推荐客户：%@",_dataArr[indexPath.row][@"name"]];
        view.recommendL.text = [NSString stringWithFormat:@"报备人员：%@/%@",[UserInfoModel defaultModel].name,[UserInfoModel defaultModel].tel];
        view.projectL.text = [NSString stringWithFormat:@"推荐项目：%@",_dataArr[indexPath.row][@"project_name"]];
        [view setErWeiMaWithUrl:[self base64EncodeString:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"client_id"]]] AndView:view];
//        _image = view.codeImg.image;
        // 设置绘制图片的大小
        UIGraphicsBeginImageContextWithOptions(view.whiteView.bounds.size, NO, 0.0);
        // 绘制图片
        [view.whiteView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _image = image;
        view.codeViewSaveBlock = ^{
            
            UIImageWriteToSavedPhotosAlbum(self->_image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        };
        
        view.codeViewShareBlock = ^{
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    };
    
    cell.confirmBtnBlock = ^(NSInteger index) {
        
        if ([_dataArr[index][@"need_confirm"] integerValue] == 1) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":_dataArr[index][@"client_id"]} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        if ([resposeObject[@"data"][@"agentGroup"] count]) {
                            
                            SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                            __strong __typeof(&*view)strongView = view;
                            view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                            view.signSelectWorkerViewBlock = ^{
                                
                                NSMutableDictionary *dic;
                                if (![self isEmpty:strongView.markTV.text]) {
                                    
                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":_dataArr[index][@"client_id"],@"agent_id":view.agentId,@"comment":view.markTV.text}];
                                }else{
                                    
                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":_dataArr[index][@"client_id"],@"agent_id":view.agentId}];
                                }
                                [BaseRequest GET:AgentSignValue_URL parameters:dic success:^(id resposeObject) {
                                    
                                    NSLog(@"%@",resposeObject);
                                    if ([resposeObject[@"code"] integerValue] == 200) {
                                        
                                        [self showContent:resposeObject[@"msg"]];
                                        [self RequestMethod];
                                    }else{
                                        
                                        [self showContent:resposeObject[@"msg"]];
                                    }
                                } failure:^(NSError *error) {
                                    
                                    [self showContent:@"网络错误"];
                                }];
                            };
                            [[UIApplication sharedApplication].keyWindow addSubview:view];
                        }else{
                            
                            [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":_dataArr[index][@"client_id"]} success:^(id resposeObject) {
                                
                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                    [self RequestMethod];
                                }else{
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                               
                                [self showContent:@"网络错误"];
                            }];
                        }
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }];
            
            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"客户无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                SignFailView *view = [[SignFailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                
                __strong __typeof(&*view)strongView = view;
                view.signFailViewBlock = ^{
                    
                    NSMutableDictionary *dic;
                    if (![self isEmpty:strongView.markTV.text]) {
                        
                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":_dataArr[index][@"client_id"],@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                    }else{
                        
                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":_dataArr[index][@"client_id"],@"disabled_state":view.agentId}];
                    }
                    [BaseRequest GET:AgentSignDisabled_URL parameters:dic success:^(id resposeObject) {
                        
                        NSLog(@"%@",resposeObject);
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self showContent:resposeObject[@"msg"]];
                            [self RequestMethod];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:view];
            }];
            
            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSDictionary *dic = _dataArr[index];
                CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] initWithClientID:dic[@"client_id"] name:dic[@"name"] dataDic:dic];
                [self.navigationController pushViewController:nextVC animated:YES];
            }];
            
            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                InvalidView * invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                invalidView.client_id = _dataArr[indexPath.row][@"client_id"];
                invalidView.invalidViewBlock = ^(NSDictionary *dic) {
                    
                    [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self alertControllerWithNsstring:@"失效确认成功" And:nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                            
                        }else{
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self alertControllerWithNsstring:@"温馨提示" And:@"操作失败" WithDefaultBlack:^{
                            
                        }];
                    }];
                };
                
                invalidView.invalidViewBlockFail = ^(NSString *str) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:str];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:invalidView];
            }];
            
            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
        }
        
    };
    
    return cell;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error  contextInfo:(void *)contextInfo{
    
    if (error) {
        
        [self showContent:@"二维码保存失败"];
        
    }else{
        
        
        [self showContent:@"二维码保存成功"];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UnconfirmDetailVC *nextVC = [[UnconfirmDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
    if (_dataArr[indexPath.row][@"need_confirm"]) {
        
        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
    }else{
        
        nextVC.needConfirm = @"1";
    }
    nextVC.recommend_check = _dataArr[indexPath.row][@"recommend_check"];
    
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)initUI
{
    
    if ([[UserModel defaultModel].agent_identity integerValue] ==1) {
        self.rightBtn.hidden = NO;
    }else{
        self.rightBtn.hidden = YES;
    }
    
    [self.view addSubview:self.MainTableView];
}


-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = YJBackColor;
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 130 *SIZE;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
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

//
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //    //创建网页内容对象
    //    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_nameL.text descr:@"" thumImage:[NSString stringWithFormat:@"%@%@",Base_Net,[UserInfoModel defaultModel].head_img]];
    //    //设置网页地址
    //创建网页内容对象
    UMShareImageObject *shareObject;
    shareObject = [UMShareImageObject shareObjectWithTitle:@"云渠道" descr:@"" thumImage:_image];
    //    if ([UserInfoModel defaultModel].head_img.length) {
    //
    //        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"%@的名片",[UserInfoModel defaultModel].name] thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]]]]];
    //    }else{
    //
    //        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"%@的名片",[UserInfoModel defaultModel].name] thumImage:[UIImage imageNamed:@"shareimg"]];
    //    }
    //设置网页地址
    shareObject.shareImage = _image;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //    if (platformType == UMSocialPlatformType_WechatTimeLine) {
    //        shareObject.title = [NSString stringWithFormat:@"【云渠道】%@的名片",[UserInfoModel defaultModel].name];
    //    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            [self alertControllerWithNsstring:@"分享失败" And:nil];
        }else{
            NSLog(@"response data is %@",data);
            [self showContent:@"分享成功"];
            [self.transmitView removeFromSuperview];
        }
    }];
}

@end
