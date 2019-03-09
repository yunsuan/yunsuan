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

@interface RecommendUnconfirmVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

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
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                if ([resposeObject[@"data"][@"data"] count] < 15) {
                    
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
                [self SetUnComfirmArr:resposeObject[@"data"]];
                if ([resposeObject[@"data"] count] < 15) {
                    
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
                if ([resposeObject[@"data"][@"data"] count] < 15) {
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    
                    [_MainTableView.mj_footer endRefreshing];
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
                
                [self SetUnComfirmArr:resposeObject[@"data"]];
                if ([resposeObject[@"data"] count] < 15) {
                    
                    _MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    
                    [_MainTableView.mj_footer endRefreshing];
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
                                if ([self isEmpty:strongView.markTV.text]) {
                                    
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
                    if ([self isEmpty:strongView.markTV.text]) {
                        
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UnconfirmDetailVC *nextVC = [[UnconfirmDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
    nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
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

@end
