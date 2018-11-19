//
//  BrokerageDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageDetailVC.h"
#import "BrokerageDetailTableCell.h"
#import "BrokerageDetailTableCell2.h"
#import "BrokerageDetailTableCell3.h"
//#import "BrokerageDetailTableCell4.h"
#import "BrokerDetailHeader.h"
#import "RoomDetailVC1.h"
//#import "RoomListModel.h"

@interface BrokerageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
//    BOOL _drop;
    NSDictionary *_data;
    NSArray *_Pace;
}

@property (nonatomic, strong) UITableView *brokerTable;
@property (nonatomic , strong) UIButton *moneybtn;

@end

@implementation BrokerageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self post];
    
}

-(void)post{
    [BaseRequest GET:PayDetail_URL
          parameters:@{
             @"broker_id":_broker_id
                        }
             success:^(id resposeObject) {
                 if ([resposeObject[@"code"] integerValue] == 200) {
                     _data = resposeObject[@"data"];
                     _Pace = resposeObject[@"data"][@"process"];
                     [_brokerTable reloadData];
                 }
                 
                        }
             failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
                                                }];
    
}


#pragma mark -- Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
            return _Pace.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 50 *SIZE;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        BrokerDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BrokerDetailHeader"];
        if (!header) {
            
            header = [[BrokerDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 50 *SIZE)];
        }
        header.titleL.text = @"当前项目进度";
//        header.dropBtnBlock = ^{
//
//        };
        
        return header;
    }
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        BrokerageDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell"];
        if (!cell) {
            
            cell = [[BrokerageDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleL.text = @"推荐信息";
        cell.numL.text = [NSString stringWithFormat:@"推荐编号：%@",_data[@"client_id"]];
        cell.pushtimeL.text = [NSString stringWithFormat:@"推荐时间：%@",_data[@"create_time"]];;
        cell.projectnameL.text = [NSString stringWithFormat:@"项目名称：%@",_data[@"project_name"]];
        cell.adressL.text = [NSString stringWithFormat:@"项目地址：%@",_data[@"absolute_address"]];
        cell.nameL.text = [NSString stringWithFormat:@"姓名：%@",_data[@"name"]];
        NSString *sex = @"性别：";
        if ([_data[@"sex"] integerValue] == 1) {
            sex = @"性别：男";
        }
        if([_data[@"sex"]  integerValue] == 2)
        {
            sex =@"性别：女";
        }
        cell.genderL.text =sex;
        cell.phoneL.text = [NSString stringWithFormat:@"电话：%@",_data[@"tel"]];
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            BrokerageDetailTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell2"];
            if (!cell) {
                
                cell = [[BrokerageDetailTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"佣金信息";
            
            cell.typeL.text = [NSString stringWithFormat:@"佣金类型：%@",_data[@"broker_type"]];
            if ([self.iscompany integerValue] ==1) {
                cell.moneyL.text = @"";
            }
            else{
            cell.moneyL.text = [NSString stringWithFormat:@"佣金金额：%@",_data[@"broker_num"]];
            }
            if ([_data[@"broker_type"] isEqualToString:@"成交佣金"]) {
                cell.propertyL.text =[NSString stringWithFormat:@"物业类型：%@",_data[@"deal_info"][@"property"]];
                cell.numL.text = [NSString stringWithFormat:@"房号：%@",_data[@"deal_info"][@"house_info"]];
                cell.tmoneyL.text = [NSString stringWithFormat:@"成交总价：%@",_data[@"deal_info"][@"total_money"]];
                cell.areaL.text = [NSString stringWithFormat:@"套内面积：%@",_data[@"deal_info"][@"inner_area"]];
                cell.statuL.text = [NSString stringWithFormat:@"成交状态：%@",_data[@"current_state"]];
                cell.timeL.text = [NSString stringWithFormat:@"成交时间：%@",_data[@"deal_info"][@"update_time"]];
            }
            else if ([_data[@"broker_type"] isEqualToString:@"到访佣金"]){
                cell.propertyL.text = [NSString stringWithFormat:@"到访时间：%@",_data[@"allot_time"]];;
            }
            else{
                
                cell.propertyL.text = [NSString stringWithFormat:@"确认有效时间：%@",_data[@"visit_time"]];;;
            }

            [cell.ruleBtn addTarget:self action:@selector(action_rule) forControlEvents:UIControlEventTouchUpInside];
            
            if ([_type isEqualToString:@"1"]) {
       
                cell.statusImg.image = [UIImage imageNamed:@"seal_knot"];
            }
            else
            {
               
                cell.statusImg.image = [UIImage imageNamed:@"nocommission"];
            }
            
            
            return cell;
        }else{
            
//            if (indexPath.row == _Pace.count) {
//
//                BrokerageDetailTableCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell4"];
//                if (!cell) {
//
//                    cell = [[BrokerageDetailTableCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell4"];
//                }
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                return cell;
//            }else{
            
                BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
                if (!cell) {
                    
                    cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@", _Pace[(NSUInteger) indexPath.row][@"process_name"], _Pace[(NSUInteger)indexPath.row][@"time"]];
            cell.upLine.hidden = indexPath.row == 0;
            cell.downLine.hidden = indexPath.row == _Pace.count-1;
                return cell;
//            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 6 *SIZE)];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    if ([_type isEqualToString:@"1"]) {
        self.titleLabel.text = @"已结佣金详情";
    }
    else
    {
        self.titleLabel.text = @"未结佣金详情";
    }
    

    
    if ([_type isEqualToString:@"1"]) {
            _brokerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    }else{
        _brokerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
        if ([_is_urge integerValue] ==1) {
            [_moneybtn setTitle:@"已结佣" forState:UIControlStateNormal];
            _moneybtn.userInteractionEnabled = YES;
        }
        [self.view addSubview:self.moneybtn];
    }
    _brokerTable.rowHeight = UITableViewAutomaticDimension;
    _brokerTable.estimatedRowHeight = 397 *SIZE;
    _brokerTable.backgroundColor = self.view.backgroundColor;
    _brokerTable.delegate = self;
    _brokerTable.dataSource = self;
    _brokerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerTable];
}

-(UIButton *)moneybtn
{
    if (!_moneybtn) {
        _moneybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moneybtn.frame = CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT);
        [_moneybtn setTitle:@"催佣" forState:UIControlStateNormal];
        _moneybtn.titleLabel.font = [UIFont systemFontOfSize:15*SIZE];
        [_moneybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_moneybtn addTarget:self action:@selector(action_urge) forControlEvents:UIControlEventTouchUpInside];
        _moneybtn.backgroundColor = YJBlueBtnColor;
    }
    return _moneybtn;
}

-(void)action_urge
{
    [BaseRequest POST:Urge_URL parameters:@{
                                            @"broker_id":_broker_id
                                            }
              success:^(id resposeObject) {
//                  NSLog(@"%@",resposeObject);
                  if ([resposeObject[@"code"] integerValue]==200) {
                      [_moneybtn setTitle:@"已催佣" forState:UIControlStateNormal];
                      _moneybtn.userInteractionEnabled = NO;
                  }
                  else
                  {
                      [self showContent:resposeObject[@"msg"]];
                  }
              }
              failure:^(NSError *error) {
//                  NSLog(@"%@",error.description);
              }];
}

-(void)action_rule
{
    RoomListModel *model = [[RoomListModel alloc]init];
    model.project_id = _data[@"project_id"];
    RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
