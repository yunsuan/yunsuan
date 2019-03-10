//
//  TypeOneVC.m
//  云渠道
//
//  Created by xiaoq on 2018/5/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TypeOneVC.h"
#import "CompleteCustomVC1.h"

#import "BaseHeader.h"
#import "CountDownCell.h"
#import "InfoDetailCell.h"

#import "InvalidView.h"

@interface TypeOneVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL _sign;
    NSArray *_signArr;
    NSArray *_arrArr;
    NSArray *_checkArr;
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_endtime;
    NSString *_name;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *Maintableview;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic, strong) InvalidView *invalidView;

@end

@implementation TypeOneVC



-(void)post{
    [BaseRequest GET:WaitConfirminfo_URL parameters:@{
                                                        @"client_id":_client_id,
                                                        @"message_id":_message_id
                                                        }
             success:^(id resposeObject) {

                 if ([resposeObject[@"code"] integerValue]==200) {
                     
                     _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                     
                     [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                         
                         if ([obj isKindOfClass:[NSNull class]]) {
                             
                             [_dataDic setObject:@"" forKey:key];
                         }
                     }];
                     
                     NSString *sex = @"客户性别：";
                     if ([_dataDic[@"sex"] integerValue] == 1) {
                         sex = @"客户性别：男";
                     }
                     if([_dataDic[@"sex"] integerValue] == 2)
                     {
                         sex =@"客户性别：女";
                     }
                     _name = _dataDic[@"name"];
                     NSString *tel = _dataDic[@"tel"];
                     NSArray *arr = [tel componentsSeparatedByString:@","];
                     if (arr.count>0) {
                         tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
                     }
                     else{
                         tel = @"联系方式：";
                     }
                     NSString *adress = _dataDic[@"absolute_address"];
                     adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"],adress];
                     
                     if ([_dataDic[@"tel_check_info"] isKindOfClass:[NSDictionary class]] && [_dataDic[@"tel_check_info"] count]) {
                         
                         if ([_dataDic[@"disabled_reason"] isEqualToString:@"号码重复"]) {
                             
                             _checkArr = @[[NSString stringWithFormat:@"确认人：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",_dataDic[@"tel_check_info"][@"confirmed_time"]],@"判重结果:不可带看"];
                         }else{
                             
                             _checkArr = @[[NSString stringWithFormat:@"确认人：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",_dataDic[@"tel_check_info"][@"confirmed_time"]],@"判重结果:可带看"];
                         }

                     }
                     
                     if (_dataDic[@"sign"]) {
                         
                         _sign = YES;
                         _signArr = _dataDic[@"sign"];
                         _arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],[NSString stringWithFormat:@"%@",tel],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],_signArr.count?[_signArr[0][@"state"] integerValue] == 1?[NSString stringWithFormat:@"到访时间：%@",_signArr[0][@"create_time"]]:@"到访时间：":[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]],_signArr.count?[NSString stringWithFormat:@"置业顾问：%@",_signArr[0][@"sign_agent_name"]]:@"置业顾问：",_signArr.count?[NSString stringWithFormat:@"确认状态：%@",_signArr[_signArr.count - 1][@"state_name"]]:@"确认状态："];
                     }else{
                         
                         _arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"process"][1][@"time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]];
                     }
                     
                     if ([_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]]];
                     }else{
                         
                         _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]]];
                     }
                     
                     _endtime = _dataDic[@"timeLimit"];
                     
                     if ([resposeObject[@"data"][@"is_deal"] integerValue] == 1) {
                         
                         _confirmBtn.hidden = YES;
                         _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
                     }else{
                         
                         _confirmBtn.hidden = NO;
                         _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE);
                     }
                     _endtime = resposeObject[@"data"][@"timeLimit"];
                     [_Maintableview reloadData];
                     
                 }else{
                     
                     _confirmBtn.hidden = YES;
                     _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
                 }
             }
             failure:^(NSError *error) {
                 
                 [self showContent:@"网络错误"];
                 _confirmBtn.hidden = YES;
                 _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
             }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"recommendReload" object:nil];
    [self initDataSouce];
    [self initUI];
    [self post];
    
}


-(void)initDataSouce
{
    _titleArr = @[@"推荐信息",@"判重信息"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"有效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CompleteCustomVC1 *nextVC = [[CompleteCustomVC1 alloc] initWithClientID:_client_id name:_name dataDic:_dataDic];
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"无效到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.invalidView.client_id = _client_id;
        [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
    }];
    
    [alert addAction:valid];
    [alert addAction:invalid];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        NSArray *arr = _data[section];
        return arr.count? arr.count + 1:0;
    }else{
        
        if (section == 1) {
            
            if (_checkArr.count) {
                
                return _checkArr.count;
            }else{
                
                return _arrArr.count;
            }
        }else{
            
            return _arrArr.count;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    header.lineView.hidden = YES;
    header.titleL.text = _titleArr[section];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 *SIZE;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_checkArr.count) {
        
        if (_sign) {
            
            return _data.count + 2;
        }
        return _data.count + 1;
    }else{
        
        if (_sign) {
            
            return _data.count + 1;
        }
        return _data.count;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        if (indexPath.section == 1) {
            
            if (_checkArr.count) {
                
                static NSString *CellIdentifier = @"InfoDetailCell";
                InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell SetCellContentbystring:_checkArr[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                
                static NSString *CellIdentifier = @"InfoDetailCell";
                InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell SetCellContentbystring:_arrArr[indexPath.row]];
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:_client_id];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }else{
                    
                    cell.infoDetailCellBlock = ^{
                        
                        SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:_signArr];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }else{
            
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_arrArr[indexPath.row]];
            if (indexPath.row == 0) {
                
                if (_sign) {
                    
                    cell.moreBtn.hidden = NO;
                    [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                    cell.infoDetailCellBlock = ^{
                        
                        SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:_client_id];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                }
            }else{
                
                cell.infoDetailCellBlock = ^{
                    
                    SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:_signArr];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"CountDownCell";
            CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell setcountdownbyendtime:_endtime];
            cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
            cell.countdownblock = ^{
                [self refresh];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row - 1]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text =_titleinfo;

    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.rowHeight = UITableViewAutomaticDimension;
    _Maintableview.estimatedRowHeight = 150 *SIZE;
    _Maintableview.backgroundColor = YJBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }
    [self.view addSubview:_Maintableview];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.hidden = YES;
    if ([[UserModel defaultModel].agent_identity integerValue] == 2) {
        
        [self.view addSubview:_confirmBtn];
    }
    
    
}

- (InvalidView *)invalidView{
    
    if (!_invalidView) {
        
        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _invalidView.invalidViewBlock = ^(NSDictionary *dic) {
            
            [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [weakSelf alertControllerWithNsstring:@"失效确认成功" And:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                    
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
            }];
        };
        
        _invalidView.invalidViewBlockFail = ^(NSString *str) {
            
            [weakSelf alertControllerWithNsstring:@"温馨提示" And:str];
        };
    }
    return _invalidView;
}

-(void)refresh{
    
    _confirmBtn.hidden = YES;
    _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
}
@end
