//
//  DealValidVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/16.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DealValidVC.h"
#import "InfoDetailCell.h"
#import "BrokerageDetailTableCell3.h"

@interface DealValidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL _sign;
    NSArray *_signArr;
    NSArray *_arrArr;
    NSArray *_checkArr;
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientid;
    NSString *_messageId;
    NSMutableDictionary *_dataDic;
    NSString *_name;
    NSArray *_Pace;
}
@property (nonatomic , strong) UITableView *dealTable;

@property (nonatomic , strong) UIButton *printBtn;

@end

@implementation DealValidVC

- (instancetype)initWithClientId:(NSString *)ClientID messageId:(NSString *)messageId
{
    self =[super init];
    if (self) {
        
        _clientid = ClientID;
        _messageId = messageId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self post];
    [self initDataSouce];
    [self initUI];
}

-(void)post{
    [BaseRequest GET:MessageProjectDealDetail_URL
          parameters:@{
                       @"client_id":_clientid,
                       @"message_id":_messageId
                       }
             success:^(id resposeObject) {
                 
                 if ([resposeObject[@"code"] integerValue] ==200) {
                     
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
                     NSString *adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"]];
                     
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
                         _arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],[NSString stringWithFormat:@"%@",tel],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],_signArr.count?[_signArr[0][@"state"] integerValue] == 1?[NSString stringWithFormat:@"到访时间：%@",_signArr[0][@"create_time"]]:@"到访时间：":[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"visit_time"]],_signArr.count?[NSString stringWithFormat:@"置业顾问：%@",_signArr[0][@"sign_agent_name"]]:@"置业顾问：",_signArr.count?[NSString stringWithFormat:@"确认状态：%@",_signArr[0][@"state_name"]]:@"确认状态："];
                     }else{
                         
                         _arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",_dataDic[@"process"][1][@"time"]],[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",_dataDic[@"butter_tel"]]];
                     }
                     
                     if ([_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {
                         
                         if (_checkArr.count) {
                             
                             _titleArr = @[@"推荐信息",@"判重信息",@"到访信息",@"成交信息"];
                             
                             _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_checkArr,_arrArr,@[[NSString stringWithFormat:@"房号：%@",_dataDic[@"house_info"]],[NSString stringWithFormat:@"成交总价：%@元",_dataDic[@"total_money"]],[NSString stringWithFormat:@"套内面积：%@㎡",_dataDic[@"inner_area"]],[NSString stringWithFormat:@"成交状态：%@",_dataDic[@"current_state"]],[NSString stringWithFormat:@"成交时间：%@",_dataDic[@"update_time"]]]];
                         }else{
                             
                             _titleArr = @[@"推荐信息",@"到访信息",@"成交信息"];
                             
                             _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_arrArr,@[[NSString stringWithFormat:@"房号：%@",_dataDic[@"house_info"]],[NSString stringWithFormat:@"成交总价：%@元",_dataDic[@"total_money"]],[NSString stringWithFormat:@"套内面积：%@㎡",_dataDic[@"inner_area"]],[NSString stringWithFormat:@"成交状态：%@",_dataDic[@"current_state"]],[NSString stringWithFormat:@"成交时间：%@",_dataDic[@"update_time"]]]];
                         }
                         
                     }else{
                         
                         if (_checkArr.count) {
                             
                             _titleArr = @[@"推荐信息",@"判重信息",@"到访信息",@"成交信息"];
                             
                             _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_checkArr,_arrArr,@[[NSString stringWithFormat:@"房号：%@",_dataDic[@"house_info"]],[NSString stringWithFormat:@"成交总价：%@元",_dataDic[@"total_money"]],[NSString stringWithFormat:@"套内面积：%@㎡",_dataDic[@"inner_area"]],[NSString stringWithFormat:@"成交状态：%@",_dataDic[@"current_state"]],[NSString stringWithFormat:@"成交时间：%@",_dataDic[@"update_time"]]]];
                         }else{
                             
                             _titleArr = @[@"推荐信息",@"到访信息",@"成交信息"];
                             
                             _data = @[@[[NSString stringWithFormat:@"推荐编号：%@",_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",_dataDic[@"client_comment"]]],_arrArr,@[[NSString stringWithFormat:@"房号：%@",_dataDic[@"house_info"]],[NSString stringWithFormat:@"成交总价：%@元",_dataDic[@"total_money"]],[NSString stringWithFormat:@"套内面积：%@㎡",_dataDic[@"inner_area"]],[NSString stringWithFormat:@"成交状态：%@",_dataDic[@"current_state"]],[NSString stringWithFormat:@"成交时间：%@",_dataDic[@"update_time"]]]];
                         }
                         
                     }
                     _Pace = _dataDic[@"process"];
                     [_dealTable reloadData];
                 }
             }
             failure:^(NSError *error) {
                 
                 [self showContent:@"网络错误"];
             }];
}


-(void)initDataSouce
{
    
    _dataDic = [@{} mutableCopy];
    
}


#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_checkArr.count) {
        
        if (section < 4) {
            
            NSArray *arr = _data[section];
            return arr.count;
        }else{
            
            return _Pace.count;
        }
    }else{
        
        if (section < 3) {
            
            NSArray *arr = _data[section];
            return arr.count;
        }else{
            
            return _Pace.count;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    [backview addSubview:header];
    title.text = _titleArr[section];
    [backview addSubview:title];
    
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_checkArr.count) {
        
        if (section < 4) {
            
            return 53*SIZE;
        }
        return 0;
    }else{
        
        if (section < 3) {
            
            return 53*SIZE;
        }
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count ? _Pace.count?_data.count + 1:_data.count:0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_checkArr.count) {
        
        if(indexPath.section == 4){
            
            BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
            if (!cell) {
                cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
            if (indexPath.row == 0) {
                
                cell.upLine.hidden = YES;
            }else{
                
                cell.upLine.hidden = NO;
            }
            if (indexPath.row == _Pace.count - 1) {
                
                cell.downLine.hidden = YES;
            }else{
                
                cell.downLine.hidden = NO;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.infoDetailCellBlock = ^{
                
                SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:_signArr];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            if (indexPath.section == 2) {
                
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:_clientid];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }
            }
            return cell;
        }
    }else{
        
        if(indexPath.section == 3){
            
            BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
            if (!cell) {
                cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
            if (indexPath.row == 0) {
                
                cell.upLine.hidden = YES;
            }else{
                
                cell.upLine.hidden = NO;
            }
            if (indexPath.row == _Pace.count - 1) {
                
                cell.downLine.hidden = YES;
            }else{
                
                cell.downLine.hidden = NO;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.infoDetailCellBlock = ^{
                
                SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:_signArr];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            if (indexPath.section == 1) {
                
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:_clientid];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }
            }
            return cell;
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"成交详情";
    
    _dealTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _dealTable.rowHeight = UITableViewAutomaticDimension;
    _dealTable.estimatedRowHeight = 150 *SIZE;
    _dealTable.backgroundColor = YJBackColor;
    _dealTable.delegate = self;
    _dealTable.dataSource = self;
    [_dealTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_dealTable];
    
}

@end
