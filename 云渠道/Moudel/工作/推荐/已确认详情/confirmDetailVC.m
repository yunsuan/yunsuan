//
//  confirmDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "confirmDetailVC.h"

#import "BaseHeader.h"
#import "InfoDetailCell.h"
#import "CountDownCell.h"

@interface confirmDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _sign;
    NSArray *_signArr;
    NSArray *_arrArr;
    NSArray *_checkArr;
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientId;
    NSMutableDictionary *_dataDic;
    NSString *_name;
}

@property (nonatomic , strong) UITableView *confirmTable;

@end

@implementation confirmDetailVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
}

-(void)initDateSouce
{
    
    _dataDic = [@{} mutableCopy];
    [self WaitConfirmRequest];
}

- (void)WaitConfirmRequest{
    
    [BaseRequest GET:ProjectWaitConfirmDetail_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setObject:@"" forKey:key];
                }
            }];
            
            NSString *sex = @"客户性别：";
            if ([resposeObject[@"data"][@"sex"] integerValue] == 1) {
                sex = @"客户性别：男";
            }
            if([resposeObject[@"data"][@"sex"] integerValue] == 2)
            {
                sex =@"客户性别：女";
            }
            _name = resposeObject[@"data"][@"name"];
            NSString *tel = resposeObject[@"data"][@"tel"];
            NSArray *arr = [tel componentsSeparatedByString:@","];
            if (arr.count>0) {
                tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
            }
            else{
                tel = @"联系方式：";
            }
            NSString *adress = resposeObject[@"data"][@"absolute_address"];
            adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",resposeObject[@"data"][@"province_name"],resposeObject[@"data"][@"city_name"],resposeObject[@"data"][@"district_name"],adress];
            
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
                
                if (_checkArr.count) {
                    
            
                    _titleArr = @[@"推荐信息",@"判重信息",@"到访信息"];
                    _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_checkArr,_arrArr];
                }else{
                    
                    _titleArr = @[@"推荐信息",@"到访信息"];
                    _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_arrArr];
                }
                
            }else{
                
                if (_checkArr.count) {
                    
                    _titleArr = @[@"推荐信息",@"判重信息",@"到访信息"];
                    _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_checkArr,_arrArr];
                }else{
                    
                    _titleArr = @[@"推荐信息",@"到访信息"];
                    _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_arrArr];
                }
            }
            [_confirmTable reloadData];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        NSArray *arr = _data[section];
        return arr.count? arr.count + 1:0;
    }else{
        
        NSArray *arr = _data[section];
        return arr.count;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 5 *SIZE)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
//                [cell setcountdownbyday:0 hours:0 min:0 sec:30];
        [cell setcountdownbyendtime:_dataDic[@"timeLimit"]];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row - 1]];
        }else{
                
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
        }
        
        if (_checkArr.count) {
            
            if (indexPath.section == 2) {
                
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:_clientId];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }
            }
        }else{
            
            if (indexPath.section == 1) {
                
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:_clientId];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }
            }
        }
        
        cell.infoDetailCellBlock = ^{
            
            SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:_signArr];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }
}

-(void)initUI
{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"待确认详情";
    
    
    
     if ([[UserModelArchiver unarchive].agent_identity integerValue]==2) {
    _confirmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
     }
     else{
         _confirmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
     }
    _confirmTable.rowHeight = UITableViewAutomaticDimension;
    _confirmTable.estimatedRowHeight = 200 *SIZE;
    _confirmTable.backgroundColor = YJBackColor;
    _confirmTable.delegate = self;
    _confirmTable.dataSource = self;
    [_confirmTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_confirmTable];
  
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
