//
//  RoomAgencyAddProtocolVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAgencyAddProtocolVC.h"

#import "SelectCustomVC.h"
//#import "RoomReportAddVC.h"
#import "SecComAllRoomListVC.h"
#import "MaintainDetailVC.h"
#import "RoomSurveySuccessVC.h"

#import "RoomAgencyAddProtocolCell.h"
#import "RoomAgencyAddProtocolCell2.h"
#import "RoomAgencyAddProtocolCell3.h"
#import "RoomAgencyAddProtocolCell4.h"
#import "RoomAgencyAddProtocolCell5.h"
//#import "RoomAgencyAddProtocolCell6.h"
#import "BlueTitleMoreHeader.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "RoomReportAddVC.h"

#pragma clang diagnostic push
#pragma ide diagnostic ignored "OCDFAInspection"
@interface RoomAgencyAddProtocolVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_houseId;
    NSArray *_titleArr;
    NSMutableArray *_foldArr;

//    NSMutableDictionary *_dataDic;
//    NSMutableDictionary *_roomDic;
    NSMutableDictionary *_tradeDic;
    NSDateFormatter *_formatter;
}

@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) NSMutableDictionary *roomDic;


@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RoomAgencyAddProtocolVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        if (dataArr.count) {
            
            _dataArr = [@[] mutableCopy];
            [dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                
                if ([(NSString *)obj[@"report_type"] containsString:@"权益人"]) {
                    
                    [_dataArr addObject:obj];
                }
            }];
        }else{
            
            _dataArr = [@[] mutableCopy];
//            [self.dataArr addObject:@"1"];
        }
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
    
    _tradeDic = [@{} mutableCopy];
    if (_housedic.count) {
        
        _houseId = _housedic[@"house_id"];
        [self RequestMethod];
    }
    
}

- (void)initDataSource{
    
    _titleArr = @[@"客户信息",@"经办人信息",@"房源信息",@"交易信息"];
    _foldArr = [[NSMutableArray alloc] initWithArray:@[@"1",@"0",@"0",@"0",@"0"]];
    _roomDic = [@{} mutableCopy];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY/MM/dd"];
}

- (void)RequestMethod{
    WS(weakSelf);
    [BaseRequest GET:HouseSubNeedInfo_URL parameters:@{@"house_id":@([_houseId integerValue])} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _roomDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            self.handleDic[@"regist_time"] = [self->_formatter stringFromDate:[NSDate date]];
            [self.handleDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ([key isEqualToString:@"name"]) {
                    
                    self.handleDic[@"agent_name"] = [NSString stringWithFormat:@"%@", obj];
                    [self.handleDic removeObjectForKey:key];
                }else if ([key isEqualToString:@"tel"]){
                    
                    self.handleDic[@"agent_tel"] = [NSString stringWithFormat:@"%@", obj];
                    [self.handleDic removeObjectForKey:key];
                }else if ([key isEqualToString:@"sex"]){
                    
                    [self.handleDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:@"sex"];
                }
            }];
            [self.handleDic setObject:[NSString stringWithFormat:@"%@",_roomDic[@"company_id"]] forKey:@"company_id"];
            [self.handleDic setObject:[NSString stringWithFormat:@"%@",_roomDic[@"store_id"]] forKey:@"store_id"];
            [self.handleDic setObject:[NSString stringWithFormat:@"%@",_roomDic[@"project_id"]] forKey:@"project_id"];
            [weakSelf.table reloadData];
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
//    NSDictionary *dic = @{@"code":@"code"};
//    [_dataArr addObject:dic];
//    [_table reloadData];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    
    [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [tempArr addObject:[obj mutableCopy]];
    }];
    
    [tempArr enumerateObjectsUsingBlock:^(NSMutableDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj setObject:[(NSArray *)obj[@"tel"] componentsJoinedByString:@","] forKey:@"tel"];
        [obj removeObjectForKey:@"contact_id"];
        [obj removeObjectForKey:@"card_type_name"];
    
        if ([self isEmpty:obj[@"name"]]) {
            
            [tempArr removeObjectAtIndex:idx];
        }
    }];
    
    if (!tempArr.count) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写权益人信息"];
        return;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:tempArr
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    if (![self.handleDic[@"agent_name"] length] || ![self.handleDic[@"sex"] length] || ![self.handleDic[@"agent_tel"] length]) {
     
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写经办人信息"];
        return;
    }
    
    RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    
    if ([self isEmpty:cell.priceTF.textfield.text]) {
        
        [_tradeDic setObject:@"" forKey:@"total_price"];
    }else{
        
        [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
    }
    
    if ([self isEmpty:cell.sincerityTF.textfield.text]) {
        
        [_tradeDic setObject:@"" forKey:@"earnest_money"];
    }else{
        
        [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
    }
    
    if ([self isEmpty:cell.breachTF.textfield.text]) {
        
        [_tradeDic setObject:@"" forKey:@"break_money"];
    }else{
        
        [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
    }
    
    if (!cell.payWayBtn->str.length) {
        
        [_tradeDic setObject:@"" forKey:@"pay_way"];
    }else{
        
        [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
    }
    
    if (!cell.signTimeBtn->str.length) {
        
        [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
    }else{
        
        _tradeDic[@"appoint_construct_time"] = cell.signTimeBtn->str;
    }
    
    if (![self isEmpty:cell.eventTV.text]) {
        
        _tradeDic[@"comment"] = cell.eventTV.text;
    }else{
        
        _tradeDic[@"comment"] = @"";
    }
    
    if (![_tradeDic[@"total_price"] length] || ![_tradeDic[@"earnest_money"] length] || ![_tradeDic[@"break_money"] length] || ![_tradeDic[@"pay_way"] length] || ![_tradeDic[@"appoint_construct_time"] length]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写交易信息"];
        return;
    }
    
    
    
    NSDictionary *dic =@{
                         @"house_id":_houseId,
                         @"total_price":_tradeDic[@"total_price"],
                         @"earnest_money":_tradeDic[@"earnest_money"],
                         @"break_money":_tradeDic[@"break_money"],
                         @"broker_ratio":_roomDic[@"broker_ratio"],
                         @"pay_way":_tradeDic[@"pay_way"],
                         @"appoint_construct_time":_tradeDic[@"appoint_construct_time"],
                         @"permit_code":_roomDic[@"permit_code"],
//                         @"land_use_permit_code":_roomDic[@"land_use_permit_code"],
                         @"company_id":self.handleDic[@"company_id"],
                         @"project_id":self.handleDic[@"project_id"],
                         @"store_id":self.handleDic[@"store_id"],
                         @"agent_name":self.handleDic[@"agent_name"],
                         @"agent_tel":self.handleDic[@"agent_tel"],
                         @"regist_time":self.handleDic[@"regist_time"],
                         @"contact_group":string,
                         @"comment":_tradeDic[@"comment"]
                         };
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    if (_roomDic[@"land_use_permit_code"] && [_roomDic[@"land_use_permit_code"] length]) {
        
        [tempDic setObject:_roomDic[@"land_use_permit_code"] forKey:@"land_use_permit_code"];
    }else{
        
        [tempDic setObject:@"" forKey:@"land_use_permit_code"];
    }
    [BaseRequest POST:AddPurchaseContract_URL parameters:tempDic success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            
            [self showContent:resposeObject[@"msg"]];//成功
            
            if (self.roomAgencyAddProtocolVCBlock) {
                
                self.roomAgencyAddProtocolVCBlock();
            }
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[MaintainDetailVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }else if ([vc isKindOfClass:[RoomSurveySuccessVC class]]){
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }else{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
        else
        {
            [self showContent:resposeObject[@"msg"]];
            //失败500网络错误 400逻辑错误
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];

}

//- (void)TextFieldDidChange:(UITextField *)textField{
//    
//    RoomAgencyAddProtocolCell *cell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//}

#pragma mark -- TableView --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    return 5;
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_foldArr[section] integerValue]) {
        
        if (section == 0) {
            
            return _dataArr.count + 1;
        }
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    if (section == 0) {
//
//        return 0 *SIZE;
//    }
    return 50 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([_foldArr[section] integerValue]) {
        
        return 6 *SIZE;
    }
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    if (section == 0) {
//
//        return [[UIView alloc] init];
//    }else{
//
        BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
        if (!header) {
            
            header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
        }
        
        [header.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(header.contentView).offset(10 *SIZE);
            make.top.equalTo(header.contentView).offset(20 *SIZE);
            make.width.mas_equalTo(7 *SIZE);
            make.height.mas_equalTo(13 *SIZE);
        }];
        
        [header.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(header.contentView).offset(28 *SIZE);
            make.top.equalTo(header.contentView).offset(18 *SIZE);
            make.right.equalTo(header.contentView).offset(30 *SIZE);
        }];
        
        [header.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(header.contentView).offset(316 *SIZE);
            make.top.equalTo(header.contentView).offset(15 *SIZE);
            make.width.mas_equalTo(38 *SIZE);
            make.height.mas_equalTo(21 *SIZE);
        }];
        
        [header.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(header.contentView).offset(0 *SIZE);
            make.top.equalTo(header.contentView).offset(49 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.height.mas_equalTo(SIZE);
            make.bottom.equalTo(header.contentView).offset(0 *SIZE);
        }];
        
        header.titleL.text = _titleArr[section];
        //    __weak __typeof(&*header)weakHeader = header;
        header.blueTitleMoreHeaderBlock = ^{
            //做数据保存
            
        
        
            if ([self->_foldArr[section] integerValue]) {
                [self->_foldArr replaceObjectAtIndex:section withObject:@"0"];
                //            [weakHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            }else{
                [self->_foldArr replaceObjectAtIndex:section withObject:@"1"];
                //            [weakHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            }
            [tableView reloadData];
        };
        if ([_foldArr[section] integerValue]==0) {
            [header.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
        }else
        {
        [header.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
        }
        
        return header;
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //440~691
    if (indexPath.section == 0) {

        if (indexPath.row == _dataArr.count) {
            RoomAgencyAddProtocolCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell5"];
                if (!cell) {
                     cell = [[RoomAgencyAddProtocolCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell5"];
                }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
        }
        else{
            RoomAgencyAddProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell"];
            if (!cell) {
                cell = [[RoomAgencyAddProtocolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell"];
            }
            cell.tag = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameL.text = @"主权益人名称：";
            cell.nameL.text = @"附权益人名称：";
            cell.dic = _dataArr[indexPath.row];
                //加号添加客户
            cell.roomAgencyAddProtocolCellBlock = ^(NSInteger index) {
                

//                [cell. resignFirstResponder];
                SelectCustomVC *nextVC = [[SelectCustomVC alloc] init];
                nextVC.selectCustomVCBlock = ^(CustomerTableModel * _Nonnull model) {
                            NSDictionary *dic = @{
                            @"address":model.address,
                            @"card_id":[NSString stringWithFormat:@"%@",model.card_id],
                          @"card_type":[NSString stringWithFormat:@"%@",model.card_type],
                     @"card_type_name":@"",
                         @"contact_id":@"",
                        @"report_type":@"",
                               @"name":model.name,
                                @"sex":[NSString stringWithFormat:@"%@",model.sex],
                                                              @"tel":[model.tel componentsSeparatedByString:@","],
                            };
                        [_dataArr replaceObjectAtIndex:index withObject:dic];
                        cell.dic = _dataArr[indexPath.row];
//                        [tableView reloadData];
                    };
                [self.navigationController pushViewController:nextVC animated:YES];
            };
                //选择男女
            cell.roomAgencyAddProtocolCellSexBlock = ^(NSInteger index) {
                [cell.nameTF.textfield resignFirstResponder];
                [cell.phoneTF.textfield resignFirstResponder];
                [cell.phoneTF2.textfield resignFirstResponder];
                
//                [cell.nameTF resignFirstResponder];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                    [dic setObject:@"1" forKey:@"sex"];
                    [_dataArr replaceObjectAtIndex:index withObject:dic];
                    cell.dic = _dataArr[indexPath.row];
//                    [tableView reloadData];
                }];
                UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                    [dic setObject:@"2" forKey:@"sex"];
                    [_dataArr replaceObjectAtIndex:index withObject:dic];
                    cell.dic = _dataArr[indexPath.row];
//                    [tableView reloadData];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                [alert addAction:male];
                [alert addAction:female];
                [alert addAction:cancel];
                [self.navigationController presentViewController:alert animated:YES completion:^{
                    }];
                    
                };
            cell.RoomAgencyBlock = ^(NSInteger index, NSDictionary *datadic) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                if (datadic[@"name"]) {
                    [dic setObject:datadic[@"name"] forKey:@"name"];
                }
                if (datadic[@"card_id"]) {
                    [dic setObject:datadic[@"card_id"] forKey:@"card_id"];
                }
                if (datadic[@"address"]) {
                    [dic setObject:datadic[@"address"] forKey:@"address"];
                }

                NSMutableArray *telarr = [dic[@"tel"] mutableCopy];
                
                if (datadic[@"tel1"]) {
                   telarr[0] = datadic[@"tel1"];
                }
                
                if (datadic[@"tel2"]) {
                    telarr[1] = datadic[@"tel2"];
                }
                [dic setObject:telarr forKey:@"tel"];
                [_dataArr replaceObjectAtIndex:index withObject:dic];
               
            };

            //选择证件类型
            cell.roomAgencyAddProtocolCellCardBlock = ^(NSInteger index) {
                [cell.nameTF.textfield resignFirstResponder];
                [cell.phoneTF.textfield resignFirstResponder];
                [cell.phoneTF2.textfield resignFirstResponder];
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self     getDetailConfigArrByConfigState:2]];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                        [tempDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"card_type"];
                        [tempDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"card_type_name"];
                        [_dataArr replaceObjectAtIndex:index withObject:tempDic];
                        cell.dic = _dataArr[indexPath.row];
                    };
                    [self.view addSubview:view];
                };
            return cell;
        }
    }
    else if(indexPath.section == 1)
    {
        
        RoomAgencyAddProtocolCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell2"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell2"];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.handleDic.count) {
            [cell setDataByDic:self.handleDic];
            }
        __weak RoomAgencyAddProtocolCell2 *weakcell = cell;
        cell.roomAgencyAddProtocolCell2TimeBlock = ^{
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                weakcell.timeBtn.content.text = [self->_formatter stringFromDate:date];
                weakcell.timeBtn->str = [self->_formatter stringFromDate:date];
                [self.handleDic setObject:[self->_formatter stringFromDate:date] forKey:@"regist_time"];
            };
            [self.view addSubview:view];
        };
        cell.roomAgencyAddProtocolCell2SexBlock = ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakcell.genderTF->str = @"1";
                weakcell.genderTF.content.text = @"男";
                [self.handleDic setObject:@"1" forKey:@"sex"];
            }];
            UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakcell.genderTF->str = @"2";
                weakcell.genderTF.content.text = @"女";
                [self.handleDic setObject:@"2" forKey:@"sex"];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:male];
            [alert addAction:female];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
            }];
        };
        cell.roomAgencyCell2Block = ^{
            if (cell.datadic[@"agent_name"]) {
                [self.handleDic setObject:weakcell.datadic[@"agent_name"] forKey:@"agent_name"];
            }
            if (cell.datadic[@"agent_tel"]) {
                            [self.handleDic setObject:weakcell.datadic[@"agent_tel"] forKey:@"agent_tel"];
            }
        };
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        RoomAgencyAddProtocolCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell3"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([_roomDic count]) {
            [cell setDataByDic:_roomDic];
        }
        WS(weakSelf);
        cell.changeblock = ^{
            if (_housedic.count) {
                SecComAllRoomListVC *nextVC = [[SecComAllRoomListVC alloc] initWithProjectId:_housedic[@"project_id"] city:@""];
                nextVC.status = @"protocol";
                nextVC.secComAllRoomListVCBlock = ^(SecdaryAllTableModel *model) {
                    _houseId = model.house_id;
                    [weakSelf RequestMethod];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                RoomReportAddVC *nextVC = [[RoomReportAddVC alloc] init];
                nextVC.status = @"selectSec";
                nextVC.roomReportAddModelBlock = ^(SecdaryAllTableModel *model) {
                    _houseId = model.house_id;
                    [weakSelf RequestMethod];
                    };
                [self.navigationController pushViewController:nextVC animated:YES];
                }
        };
        cell.roomAgencyCell3Block = ^(NSString *homeland) {
            [_roomDic setObject:homeland forKey:@"land_use_permit_code"];
        };
        
        return cell;

    }
    else
    {
        RoomAgencyAddProtocolCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell4"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell4"];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_roomDic.count) {
            cell.ratio = [_roomDic[@"broker_ratio"] integerValue];
            [_tradeDic setObject:_roomDic[@"broker_ratio"] forKey:@"broker_ratio"];
        }else{
            cell.ratio = 0;
            [_tradeDic setObject:@"0" forKey:@"broker_ratio"];
        }
        cell.tradeDic = _tradeDic;
        cell.roomAgencyAddProtocolCell4TimeBlock = ^{
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            [view.pickerView setMinimumDate:[NSDate date]];
            [view.pickerView setCalendar:[NSCalendar currentCalendar]];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:15];//设置最大时间为：当前时间推后10天
            [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
            view.dateblock = ^(NSDate *date) {
                [_tradeDic setObject:[_formatter stringFromDate:date] forKey:@"appoint_construct_time"];
                cell.signTimeBtn->str = [_formatter stringFromDate:date];
                cell.signTimeBtn.content.text = [_formatter stringFromDate:date];
            };
            [self.view addSubview:view];
        };
        cell.roomAgencyAddProtocolCell4PayBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.payWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.payWayBtn->str = [NSString stringWithFormat:@"%@", ID];
                [_tradeDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"pay_way"];
                [_tradeDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"pay_way_name"];
//                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        cell.roomAgencylCell4Block = ^(NSMutableDictionary *data) {

            if (data[@"total_price"]) {
                _tradeDic[@"total_price"] = data[@"total_price"];
            }
            if (data[@"earnest_money"]) {
                _tradeDic[@"earnest_money"] = data[@"earnest_money"];
            }
            if (data[@"break_money"]) {
                _tradeDic[@"break_money"] = data[@"break_money"];
            }
            if (data[@"comment"]) {
                _tradeDic[@"comment"] = data[@"comment"];
            }
        };
        
    return cell;
    }
}
//  693~2144
//
////    if (indexPath.section == 0) {
////
////        RoomAgencyAddProtocolCell6 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell6"];
////        if (!cell) {
////
////            cell = [[RoomAgencyAddProtocolCell6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell6"];
////        }
////        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////
//////        if (_roomDic.count) {
//////
//////            cell.codeTF.textfield.text = _roomDic[@"permit_code"];
//////        }
////
////        return cell;
////    }else if (indexPath.section == 1) {
//
//    if (indexPath.section == 0) {
//
//        if (indexPath.row == _dataArr.count) {
//
//            RoomAgencyAddProtocolCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell5"];
//            if (!cell) {
//
//                cell = [[RoomAgencyAddProtocolCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell5"];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            return cell;
//        }else{
//
//            RoomAgencyAddProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell"];
//            if (!cell) {
//
//                cell = [[RoomAgencyAddProtocolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell"];
//            }
//            cell.tag = indexPath.row;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            if (indexPath.row == 0) {
//
//                cell.nameL.text = @"主权益人名称：";
//            }else{
//
//                cell.nameL.text = @"副权益人名称：";
//            }
//
//            cell.dic = _dataArr[indexPath.row];
//


//            cell.roomAgencyAddProtocolCellBlock = ^(NSInteger index) {
//

//                SelectCustomVC *nextVC = [[SelectCustomVC alloc] init];
//                nextVC.selectCustomVCBlock = ^(CustomerTableModel * _Nonnull model) {
//
//                    NSDictionary *dic = @{@"address":model.address,
//                                          @"card_id":[NSString stringWithFormat:@"%@",model.card_id],
//                                          @"card_type":[NSString stringWithFormat:@"%@",model.card_type],
//                                          @"card_type_name":@"",
//                                          @"contact_id":@"",
//                                          @"report_type":@"",
//                                          @"name":model.name,
//                                          @"sex":[NSString stringWithFormat:@"%@",model.sex],
//                                          @"tel":[model.tel componentsSeparatedByString:@","],
//                                          };
//                    [_dataArr replaceObjectAtIndex:index withObject:dic];
//                    [tableView reloadData];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            };
//


//            cell.roomAgencyAddProtocolCellSexBlock = ^(NSInteger index) {
//
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//                UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
////                    cell.genderBtn.str = @"1";
////                    cell.genderBtn.content.text = @"男";
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//                    [dic setObject:@"1" forKey:@"sex"];
//                    [_dataArr replaceObjectAtIndex:index withObject:dic];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            self.handleDic[@"agent_tel"] = cell.phoneTF.textfield.text;
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//
//                    }
//
//                    if (indexPath.section == 2) {
//
//                        RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                        if (cell.homelandTF.textfield.text.length) {
//
//                            [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                        }else{
//
//                            [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                        }
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [self->_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [self->_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//
//                    [tableView reloadData];
//                }];
//
//                UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
////                    cell.genderBtn.str = @"2";
////                    cell.genderBtn.content.text = @"女";
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//                    [dic setObject:@"2" forKey:@"sex"];
//                    [_dataArr replaceObjectAtIndex:index withObject:dic];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        cell.commisionTF.textfield.text = [NSString stringWithFormat:@"%@%@",_roomDic[@"broker_ratio"],@"%"];
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//
//                    [tableView reloadData];
//                }];
//
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//
//                [alert addAction:male];
//                [alert addAction:female];
//                [alert addAction:cancel];
//                [self.navigationController presentViewController:alert animated:YES completion:^{
//
//                }];
//            };
//

#pragma mark ============
//            cell.roomAgencyAddProtocolCellCardBlock = ^(NSInteger index) {
//
//                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self     getDetailConfigArrByConfigState:2]];
//                view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
////                    cell.certTypeBtn.str = [NSString stringWithFormat:@"%@",ID];
////                    cell.certTypeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
//                    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//                    [tempDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"card_type"];
//                    [tempDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"card_type_name"];
//                    [_dataArr replaceObjectAtIndex:index withObject:tempDic];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//
//                    [tableView reloadData];
//                };
//                [self.view addSubview:view];
//            };
//
//            return cell;
//        }
//    }else{
//
#pragma mark -- Section 2 经办人
//        if (indexPath.section == 1) {
//
//            RoomAgencyAddProtocolCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell2"];
//            if (!cell) {
//
//                cell = [[RoomAgencyAddProtocolCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell2"];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            if (self.handleDic.count) {
//
//                [cell setDataByDic:self.handleDic];
//            }
//            __weak RoomAgencyAddProtocolCell2 *weakcell = cell;
////            WS(weakSelf);
//            cell.roomAgencyAddProtocolCell2TimeBlock = ^(NSInteger index) {
//
//                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
////                [view.pickerView setMinimumDate:[NSDate date]];
////                [view.pickerView setCalendar:[NSCalendar currentCalendar]];
////                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
////                NSDateComponents *comps = [[NSDateComponents alloc] init];
////                [comps setDay:15];//设置最大时间为：当前时间推后10天
////                [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
//                view.dateblock = ^(NSDate *date) {
//
//                    weakcell.timeBtn.content.text = [self->_formatter stringFromDate:date];
//                    weakcell.timeBtn->str = [self->_formatter stringFromDate:date];
//                    [self.handleDic setObject:[self->_formatter stringFromDate:date] forKey:@"regist_time"];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[i][@"sex"] length]?_dataArr[i][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//
//                    }
//
//                    if (indexPath.section == 2) {
//
//                        RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                        if (cell.homelandTF.textfield.text.length) {
//
//                            [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                        }else{
//
//                            [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                        }
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//
//                    [tableView reloadData];
//                };
//
//                [self.view addSubview:view];
//            };
//
//
//            cell.roomAgencyAddProtocolCell2SexBlock = ^(NSInteger index) {
//
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//                UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                    cell.genderTF->str = @"1";
//                    cell.genderTF.content.text = @"男";
//                    [self.handleDic setObject:@"1" forKey:@"sex"];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[i][@"sex"] length]?_dataArr[i][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//                    }
//
//                    if (indexPath.section == 2) {
//
//                        RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                        if (cell.homelandTF.textfield.text.length) {
//
//                            [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                        }else{
//
//                            [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                        }
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//
//                    [tableView reloadData];
//                }];
//
//                UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                    cell.genderTF->str = @"2";
//                    cell.genderTF.content.text = @"女";
//                    [self.handleDic setObject:@"2" forKey:@"sex"];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[i][@"sex"] length]?_dataArr[i][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//                    }
//
//                    if (indexPath.section == 2) {
//
//                        RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                        if (cell.homelandTF.textfield.text.length) {
//
//                            [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                        }else{
//
//                            [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                        }
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//                    [tableView reloadData];
//                }];
//
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//
//                [alert addAction:male];
//                [alert addAction:female];
//                [alert addAction:cancel];
//                [self.navigationController presentViewController:alert animated:YES completion:^{
//
//                }];
//            };
//            return cell;
//        }else if (indexPath.section == 2){
//
#pragma mark -- Section 3 房源
//            RoomAgencyAddProtocolCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell3"];
//            if (!cell) {
//
//                cell = [[RoomAgencyAddProtocolCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell3"];
//            }
//
//            if ([_roomDic count]) {
//
//                [cell setDataByDic:_roomDic];
//            }
////            if (_housedic.count>0) {
////                 [cell setDataByDic:_housedic];
////            }
//            WS(weakSelf);
//            cell.changeblock = ^{
//
//                if (_housedic.count) {
//
//                    SecComAllRoomListVC *nextVC = [[SecComAllRoomListVC alloc] initWithProjectId:_housedic[@"project_id"] city:@""];
//                    nextVC.status = @"protocol";
//                    nextVC.secComAllRoomListVCBlock = ^(SecdaryAllTableModel *model) {
//
//                        _houseId = model.house_id;
//                        if (indexPath.section == 0) {
//
//                            for (int i = 0; i < _dataArr.count; i++) {
//
//                                RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                                NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                      @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                      @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                      @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                      @"contact_id":@"",
//                                                      @"report_type":@"",
//                                                      @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                      @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                                      @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                      };
//                                [_dataArr replaceObjectAtIndex:i withObject:dic];
//                            }
//                        }
//
//                        if (indexPath.section == 1) {
//
//                            RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                            if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                                [self.handleDic setObject:@"" forKey:@"agent_name"];
//                            }else{
//
//                                [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                            }
//
//                            if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                                [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                            }else{
//
//                                [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                            }
//
//                            if (cell.genderTF->str.length) {
//
//                                [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                            }else{
//
//                                [self.handleDic setObject:@"" forKey:@"sex"];
//                            }
//                        }
//
//                        if (indexPath.section == 2) {
//
//                            RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                            if (cell.homelandTF.textfield.text.length) {
//
//                                [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                            }else{
//
//                                [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                            }
//
//                        }
//
//                        if (indexPath.section == 3) {
//
//                            RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                            if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                                [_tradeDic setObject:@"" forKey:@"total_price"];
//                            }else{
//
//                                [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                            }
//
//                            if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                                [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                            }else{
//
//                                [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                            }
//
//                            if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                                [_tradeDic setObject:@"" forKey:@"break_money"];
//                            }else{
//
//                                [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                            }
//
//                            if (!cell.payWayBtn->str.length) {
//
//                                [_tradeDic setObject:@"" forKey:@"pay_way"];
//                            }else{
//
//                                [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                            }
//
//                            if (!cell.signTimeBtn->str.length) {
//
//                                [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                            }else{
//
//                                [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                            }
//
//                            if (![self isEmpty:cell.eventTV.text]) {
//
//                                [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                            }else{
//
//                                [_tradeDic setObject:@"" forKey:@"comment"];
//                            }
//                        }
//                        [weakSelf RequestMethod];
//                    };
//                    [self.navigationController pushViewController:nextVC animated:YES];
//                }else{
//
//                    RoomReportAddVC *nextVC = [[RoomReportAddVC alloc] init];
//                    nextVC.status = @"selectSec";
//                    nextVC.roomReportAddModelBlock = ^(SecdaryAllTableModel *model) {
//
//                        _houseId = model.house_id;
//                        if (indexPath.section == 0) {
//
//                            for (int i = 0; i < _dataArr.count; i++) {
//
//                                RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                                NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                      @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                      @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                      @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                      @"contact_id":@"",
//                                                      @"report_type":@"",
//                                                      @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                      @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                                      @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                      };
//                                [_dataArr replaceObjectAtIndex:i withObject:dic];
//                            }
//                        }
//
//                        if (indexPath.section == 1) {
//
//                            RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                            if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                                [self.handleDic setObject:@"" forKey:@"agent_name"];
//                            }else{
//
//                                [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                            }
//
//                            if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                                [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                            }else{
//
//                                [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                            }
//
//                            if (cell.genderTF->str.length) {
//
//                                [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                            }else{
//
//                                self.handleDic[@"sex"] = @"";
//                            }
//                        }
//
//                        if (indexPath.section == 2) {
//
//                            RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                            if (cell.homelandTF.textfield.text.length) {
//
//                                [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                            }else{
//
//                                [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                            }
//                        }
//
//                        if (indexPath.section == 3) {
//
//                            RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                            if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                                [_tradeDic setObject:@"" forKey:@"total_price"];
//                            }else{
//
//                                [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                            }
//
//                            if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                                [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                            }else{
//
//                                [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                            }
//
//                            if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                                [_tradeDic setObject:@"" forKey:@"break_money"];
//                            }else{
//
//                                [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                            }
//
//                            if (!cell.payWayBtn->str.length) {
//
//                                [_tradeDic setObject:@"" forKey:@"pay_way"];
//                            }else{
//
//                                [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                            }
//
//                            if (!cell.signTimeBtn->str.length) {
//
//                                [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                            }else{
//
//                                [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                            }
//
//                            if (![self isEmpty:cell.eventTV.text]) {
//
//                                [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                            }else{
//
//                                [_tradeDic setObject:@"" forKey:@"comment"];
//                            }
//                        }
//                        [weakSelf RequestMethod];
//                    };
//                    [self.navigationController pushViewController:nextVC animated:YES];
//                }
//            };
//
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            return cell;
//        }else{
#pragma mark  ----- 交易信息 ------
//            RoomAgencyAddProtocolCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell4"];
//            if (!cell) {
//
//                cell = [[RoomAgencyAddProtocolCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell4"];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            if (_roomDic.count) {
//
//                cell.ratio = [_roomDic[@"broker_ratio"] integerValue];
//                [_tradeDic setObject:_roomDic[@"broker_ratio"] forKey:@"broker_ratio"];
//            }else{
//
//                cell.ratio = 0;
//                [_tradeDic setObject:@"0" forKey:@"broker_ratio"];
//            }
//
//            cell.tradeDic = _tradeDic;
//
//            cell.roomAgencyAddProtocolCell4TimeBlock = ^{
//
//                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
//                [view.pickerView setMinimumDate:[NSDate date]];
//                [view.pickerView setCalendar:[NSCalendar currentCalendar]];
//                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//                NSDateComponents *comps = [[NSDateComponents alloc] init];
//                [comps setDay:15];//设置最大时间为：当前时间推后10天
//                [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
//                view.dateblock = ^(NSDate *date) {
//
//                    [_tradeDic setObject:[_formatter stringFromDate:date] forKey:@"appoint_construct_time"];
//                    cell.signTimeBtn->str = [_formatter stringFromDate:date];
//                    cell.signTimeBtn.content.text = [_formatter stringFromDate:date];
//                };
//                [self.view addSubview:view];
//            };
//
//            cell.roomAgencyAddProtocolCell4PayBlock = ^{
//
//                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
//                view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                    cell.payWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
//                    cell.payWayBtn->str = [NSString stringWithFormat:@"%@", ID];
//                    [_tradeDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"pay_way"];
//                    [_tradeDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"pay_way_name"];
//
//                    if (indexPath.section == 0) {
//
//                        for (int i = 0; i < _dataArr.count; i++) {
//
//                            RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//
//
//                            NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                                  @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                                  @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                                  @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                                  @"contact_id":@"",
//                                                  @"report_type":@"",
//                                                  @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                                  @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                                  @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                                  };
//                            [_dataArr replaceObjectAtIndex:i withObject:dic];
//                        }
//                    }
//
//                    if (indexPath.section == 1) {
//
//                        RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_name"];
//                        }else{
//
//                            [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//                        }
//
//                        if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                            [self.handleDic setObject:@"" forKey:@"agent_tel"];
//                        }else{
//
//                            [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//                        }
//
//                        if (cell.genderTF->str.length) {
//
//                            [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//                        }else{
//
//                            [self.handleDic setObject:@"" forKey:@"sex"];
//                        }
//                    }
//
//                    if (indexPath.section == 2) {
//
//                        RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                        if (cell.homelandTF.textfield.text.length) {
//
//                            [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//                        }else{
//
//                            [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//                        }
//                    }
//
//                    if (indexPath.section == 3) {
//
//                        RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//                        if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"total_price"];
//                        }else{
//
//                            [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//                        }
//
//                        if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"earnest_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//                        }
//
//                        if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                            [_tradeDic setObject:@"" forKey:@"break_money"];
//                        }else{
//
//                            [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//                        }
//
//                        if (!cell.payWayBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"pay_way"];
//                        }else{
//
//                            [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//                        }
//
//                        if (!cell.signTimeBtn->str.length) {
//
//                            [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//                        }else{
//
//                            [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//                        }
//
//                        if (![self isEmpty:cell.eventTV.text]) {
//
//                            [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//                        }else{
//
//                            [_tradeDic setObject:@"" forKey:@"comment"];
//                        }
//                    }
//
//                    [tableView reloadData];
//                };
//                [self.view addSubview:view];
//            };
//
//            return cell;
//        }
//    }
//}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.section == 0) {
//
//        for (int i = 0; i < _dataArr.count; i++) {
//
//            if ([cell isKindOfClass:[RoomAgencyAddProtocolCell class]]) {
//
//                RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//                NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                      @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                      @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                      @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                      @"contact_id":@"",
//                                      @"report_type":@"",
//                                      @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                      @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                      @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                      };
//                [_dataArr replaceObjectAtIndex:i withObject:dic];
//            }
//        }
//    }
//
//    if (indexPath.section == 1) {
//
//        if ([cell isKindOfClass:[RoomAgencyAddProtocolCell2 class]]) {
//
//            RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//            if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                [self.handleDic setObject:@"" forKey:@"agent_name"];
//            }else{
//
//                [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//            }
//
//            if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                [self.handleDic setObject:@"" forKey:@"agent_tel"];
//            }else{
//
//                [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//            }
//
//            if (cell.genderTF->str.length) {
//
//                [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//            }else{
//
//                [self.handleDic setObject:@"" forKey:@"sex"];
//            }
//        }
//    }
//
//    if (indexPath.section == 2) {
//
//        if ([cell isKindOfClass:[RoomAgencyAddProtocolCell3 class]]) {
//
//             RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//
//            if (cell.homelandTF.textfield.text.length) {
//
//                [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//            }else{
//
//                [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//            }
//        }
//    }
//
//    if (indexPath.section == 3) {
//
//        if ([cell isKindOfClass:[RoomAgencyAddProtocolCell4 class]]) {
//
//            RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//            if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                [_tradeDic setObject:@"" forKey:@"total_price"];
//            }else{
//
//                [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//            }
//
//            if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                [_tradeDic setObject:@"" forKey:@"earnest_money"];
//            }else{
//
//                [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//            }
//
//            if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                [_tradeDic setObject:@"" forKey:@"break_money"];
//            }else{
//
//                [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//            }
//
//            if (!cell.payWayBtn->str.length) {
//
//                [_tradeDic setObject:@"" forKey:@"pay_way"];
//            }else{
//
//                [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//            }
//
//            if (!cell.signTimeBtn->str.length) {
//
//                [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//            }else{
//
//                [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//            }
//
//            if (![self isEmpty:cell.eventTV.text]) {
//
//                [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//            }else{
//
//                [_tradeDic setObject:@"" forKey:@"comment"];
//            }
//        }
//    }
//}

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.section == 0) {
//
//        for (int i = 0; i < _dataArr.count; i++) {
//
//            if ([cell isKindOfClass:[RoomAgencyAddProtocolCell class]]) {
//
//                RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//                NSDictionary *dic = @{@"address":cell.addressTF.textfield.text.length?cell.addressTF.textfield.text:@"",
//                                      @"card_id":cell.certNumTF.textfield.text.length?cell.certNumTF.textfield.text:@"",
//                                      @"card_type":_dataArr[i][@"card_type"]?_dataArr[i][@"card_type"]:@"",
//                                      @"card_type_name":_dataArr[i][@"card_type_name"]?_dataArr[i][@"card_type_name"]:@"",
//                                      @"contact_id":@"",
//                                      @"report_type":@"",
//                                      @"name":cell.nameTF.textfield.text.length?cell.nameTF.textfield.text:@"",
//                                      @"sex":[_dataArr[indexPath.row][@"sex"] length]?_dataArr[indexPath.row][@"sex"]:@"",
//                                      @"tel":cell.phoneTF.textfield.text.length?@[cell.phoneTF.textfield.text]:@[],
//                                      };
//                [_dataArr replaceObjectAtIndex:i withObject:dic];
//            }
//        }
//    }
//
//    if (indexPath.section == 1) {
//
//        if ([cell isKindOfClass:[RoomAgencyAddProtocolCell2 class]]) {
//
//            RoomAgencyAddProtocolCell2 *cell = (RoomAgencyAddProtocolCell2 *)[tableView cellForRowAtIndexPath:indexPath];
//            if ([self isEmpty:cell.nameTF.textfield.text]) {
//
//                [self.handleDic setObject:@"" forKey:@"agent_name"];
//            }else{
//
//                [self.handleDic setObject:cell.nameTF.textfield.text forKey:@"agent_name"];
//            }
//
//            if ([self isEmpty:cell.phoneTF.textfield.text]) {
//
//                [self.handleDic setObject:@"" forKey:@"agent_tel"];
//            }else{
//
//                [self.handleDic setObject:cell.phoneTF.textfield.text forKey:@"agent_tel"];
//            }
//
//            if (cell.genderTF->str.length) {
//
//                [self.handleDic setObject:cell.genderTF->str forKey:@"sex"];
//            }else{
//
//                [self.handleDic setObject:@"" forKey:@"sex"];
//            }
//        }
//    }
//
//    if (indexPath.section == 2) {
//
//        if ([cell isKindOfClass:[RoomAgencyAddProtocolCell3 class]]) {
//
//            RoomAgencyAddProtocolCell3 *cell = (RoomAgencyAddProtocolCell3 *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//
//            if (cell.homelandTF.textfield.text.length) {
//
//                [_roomDic setObject:cell.homelandTF.textfield.text forKey:@"land_use_permit_code"];
//            }else{
//
//                [_roomDic setObject:@"" forKey:@"land_use_permit_code"];
//            }
//        }
//    }
//
//    if (indexPath.section == 3) {
//
//
//        if ([cell isKindOfClass:[RoomAgencyAddProtocolCell4 class]]) {
//
//            RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
//
//            if ([self isEmpty:cell.priceTF.textfield.text]) {
//
//                [_tradeDic setObject:@"" forKey:@"total_price"];
//            }else{
//
//                [_tradeDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
//            }
//
//            if ([self isEmpty:cell.sincerityTF.textfield.text]) {
//
//                [_tradeDic setObject:@"" forKey:@"earnest_money"];
//            }else{
//
//                [_tradeDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
//            }
//
//            if ([self isEmpty:cell.breachTF.textfield.text]) {
//
//                [_tradeDic setObject:@"" forKey:@"break_money"];
//            }else{
//
//                [_tradeDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
//            }
//
//            if (!cell.payWayBtn->str.length) {
//
//                [_tradeDic setObject:@"" forKey:@"pay_way"];
//            }else{
//
//                [_tradeDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
//            }
//
//            if (!cell.signTimeBtn->str.length) {
//
//                [_tradeDic setObject:@"" forKey:@"appoint_construct_time"];
//            }else{
//
//                [_tradeDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
//            }
//
//            if (![self isEmpty:cell.eventTV.text]) {
//
//                [_tradeDic setObject:cell.eventTV.text forKey:@"comment"];
//            }else{
//
//                [_tradeDic setObject:@"" forKey:@"comment"];
//            }
//        }
//    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        if (indexPath.row == _dataArr.count) {

            for (int i = 0; i < _dataArr.count; i++) {
                
                RoomAgencyAddProtocolCell *cell = (RoomAgencyAddProtocolCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                if ([self isEmpty:cell.addressTF.textfield.text] || [self isEmpty:cell.certNumTF.textfield.text] || [self isEmpty:cell.nameTF.textfield.text] || [self isEmpty:cell.phoneTF.textfield.text] || ![_dataArr[i][@"card_type"] length]|| ![_dataArr[i][@"sex"] length]) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请填写完整权益人信息"];
                    return;
                }
            }
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       @"address":@"",
                                                                                       @"card_id":@"",
                                                                                       @"card_type":@"",
                                                                                       @"card_type_name":@"",
                                                                                       @"contact_id":@"",
                                                                                       @"name":@"",
                                                                                       @"report_type":@"",
                                                                                       @"sex":@"",
                                                                                       @"tel":[@[] mutableCopy]
                }];
            [_dataArr addObject:dic];
            [_table reloadData];
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加代购合同";
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 423 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 360 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:_nextBtn];
}

@end

#pragma clang diagnostic pop
