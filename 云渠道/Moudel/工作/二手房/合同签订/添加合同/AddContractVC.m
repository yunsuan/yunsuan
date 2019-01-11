//
//  AddContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractVC.h"

#import "SelectCustomVC.h"

#import "BlueTitleMoreHeader.h"
#import "RoomAgencyAddProtocolCell.h"
#import "RoomAgencyAddProtocolCell2.h"
#import "RoomAgencyAddProtocolCell3.h"
#import "AddContractCell.h"
#import "AddContractCell2.h"

#import "SinglePickView.h"
#import "DateChooseView.h"


@interface AddContractVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSDateFormatter *_formatter;
    NSArray *_titleArr;
    NSMutableArray *_foldArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddContractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
}

- (void)initDataSource{
    
    _titleArr = @[@"买方信息",@"经办人信息",@"房源信息",@"卖方信息",@"合同信息",@"付款信息",@"买卖方支付"];
    _foldArr = [[NSMutableArray alloc] initWithArray:@[@"1",@"0",@"0",@"0",@"0",@"0",@"0"]];
//    _roomDic = [@{} mutableCopy];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY/MM/dd"];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    
}

#pragma mark -- TableView --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    return 5;
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_foldArr[section] integerValue]) {
        
        if (section == 0) {
            
            return 1;
        }
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([_foldArr[section] integerValue]) {
        
        return 6 *SIZE;
    }
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
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
    __weak __typeof(&*header)weakHeader = header;
    header.blueTitleMoreHeaderBlock = ^{
        //做数据保存
        
        if ([self->_foldArr[section] integerValue]) {
            
            [self->_foldArr replaceObjectAtIndex:section withObject:@"0"];
            [weakHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
        }else{
            
            [self->_foldArr replaceObjectAtIndex:section withObject:@"1"];
            [weakHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
        }
        [tableView reloadData];
    };
    if ([_foldArr[section] integerValue]==0) {
        
        [header.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    }else{
        
        [header.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        RoomAgencyAddProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell"];
        }
        cell.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameL.text = @"权益人：";
//        cell.dic = _dataArr[indexPath.row];
        //加号添加客户
        __weak __typeof(&*cell)weakCell = cell;
        cell.roomAgencyAddProtocolCellBlock = ^(NSInteger index) {
            
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
//                [_dataArr replaceObjectAtIndex:index withObject:dic];
//                cell.dic = _dataArr[indexPath.row];
                //                        [tableView reloadData];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        //选择男女
        cell.roomAgencyAddProtocolCellSexBlock = ^(NSInteger index) {
            [weakCell.nameTF.textfield resignFirstResponder];
            [weakCell.phoneTF.textfield resignFirstResponder];
            [weakCell.phoneTF2.textfield resignFirstResponder];

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                //                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//                [dic setObject:@"1" forKey:@"sex"];
//                [_dataArr replaceObjectAtIndex:index withObject:dic];
//                cell.dic = _dataArr[indexPath.row];

            }];
            UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
//                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//                [dic setObject:@"2" forKey:@"sex"];
//                [_dataArr replaceObjectAtIndex:index withObject:dic];
//                cell.dic = _dataArr[indexPath.row];
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
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//            if (datadic[@"name"]) {
//                [dic setObject:datadic[@"name"] forKey:@"name"];
//            }
//            if (datadic[@"card_id"]) {
//                [dic setObject:datadic[@"card_id"] forKey:@"card_id"];
//            }
//            if (datadic[@"address"]) {
//                [dic setObject:datadic[@"address"] forKey:@"address"];
//            }
//
//            NSMutableArray *telarr = [dic[@"tel"] mutableCopy];
//
//            if (datadic[@"tel1"]) {
//                telarr[0] = datadic[@"tel1"];
//            }
//
//            if (datadic[@"tel2"]) {
//                telarr[1] = datadic[@"tel2"];
//            }
//            [dic setObject:telarr forKey:@"tel"];
//            [_dataArr replaceObjectAtIndex:index withObject:dic];
        };
        
        //选择证件类型
        cell.roomAgencyAddProtocolCellCardBlock = ^(NSInteger index) {
            
            [weakCell.nameTF.textfield resignFirstResponder];
            [weakCell.phoneTF.textfield resignFirstResponder];
            [weakCell.phoneTF2.textfield resignFirstResponder];
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self     getDetailConfigArrByConfigState:2]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {

                //                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
//                [tempDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"card_type"];
//                [tempDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"card_type_name"];
//                [_dataArr replaceObjectAtIndex:index withObject:tempDic];
//                cell.dic = _dataArr[indexPath.row];
            };
            [self.view addSubview:view];
        };
        return cell;
    }else if(indexPath.section == 1){
        
        RoomAgencyAddProtocolCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell2"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        if (self.handleDic.count) {
//            [cell setDataByDic:self.handleDic];
//        }
        __weak RoomAgencyAddProtocolCell2 *weakcell = cell;
        cell.roomAgencyAddProtocolCell2TimeBlock = ^{
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                weakcell.timeBtn.content.text = [self->_formatter stringFromDate:date];
                weakcell.timeBtn->str = [self->_formatter stringFromDate:date];
//                [self.handleDic setObject:[self->_formatter stringFromDate:date] forKey:@"regist_time"];
            };
            [self.view addSubview:view];
        };
        cell.roomAgencyAddProtocolCell2SexBlock = ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakcell.genderTF->str = @"1";
                weakcell.genderTF.content.text = @"男";
//                [self.handleDic setObject:@"1" forKey:@"sex"];
            }];
            UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakcell.genderTF->str = @"2";
                weakcell.genderTF.content.text = @"女";
//                [self.handleDic setObject:@"2" forKey:@"sex"];
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
            
//            if (cell.datadic[@"agent_name"]) {
//                [self.handleDic setObject:weakcell.datadic[@"agent_name"] forKey:@"agent_name"];
//            }
//            if (cell.datadic[@"agent_tel"]) {
//                [self.handleDic setObject:weakcell.datadic[@"agent_tel"] forKey:@"agent_tel"];
//            }
        };
        
        return cell;
    }
    else if (indexPath.section == 2){
        
        RoomAgencyAddProtocolCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell3"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if ([_roomDic count]) {
//            [cell setDataByDic:_roomDic];
//        }
        
        WS(weakSelf);
        cell.changeblock = ^{
//            if (_housedic.count) {
//                SecComAllRoomListVC *nextVC = [[SecComAllRoomListVC alloc] initWithProjectId:_housedic[@"project_id"] city:@""];
//                nextVC.status = @"protocol";
//                nextVC.secComAllRoomListVCBlock = ^(SecdaryAllTableModel *model) {
//                    _houseId = model.house_id;
//                    [weakSelf RequestMethod];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }else{
//                RoomReportAddVC *nextVC = [[RoomReportAddVC alloc] init];
//                nextVC.status = @"selectSec";
//                nextVC.roomReportAddModelBlock = ^(SecdaryAllTableModel *model) {
//                    _houseId = model.house_id;
//                    [weakSelf RequestMethod];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }
        };
        cell.roomAgencyCell3Block = ^(NSString *homeland) {
            
//            [_roomDic setObject:homeland forKey:@"land_use_permit_code"];
        };
        
        return cell;
        
    }else if(indexPath.section == 3){
        
        RoomAgencyAddProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell"];
        if (!cell) {
            cell = [[RoomAgencyAddProtocolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell"];
        }
        cell.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameL.text = @"权益人：";
        //        cell.dic = _dataArr[indexPath.row];
        //加号添加客户
        __weak __typeof(&*cell)weakCell = cell;
        cell.roomAgencyAddProtocolCellBlock = ^(NSInteger index) {
            
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
                //                [_dataArr replaceObjectAtIndex:index withObject:dic];
                //                cell.dic = _dataArr[indexPath.row];
                //                        [tableView reloadData];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        //选择男女
        cell.roomAgencyAddProtocolCellSexBlock = ^(NSInteger index) {
            [weakCell.nameTF.textfield resignFirstResponder];
            [weakCell.phoneTF.textfield resignFirstResponder];
            [weakCell.phoneTF2.textfield resignFirstResponder];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                //                [dic setObject:@"1" forKey:@"sex"];
                //                [_dataArr replaceObjectAtIndex:index withObject:dic];
                //                cell.dic = _dataArr[indexPath.row];
                
            }];
            UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                //                [dic setObject:@"2" forKey:@"sex"];
                //                [_dataArr replaceObjectAtIndex:index withObject:dic];
                //                cell.dic = _dataArr[indexPath.row];
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
            //            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
            //            if (datadic[@"name"]) {
            //                [dic setObject:datadic[@"name"] forKey:@"name"];
            //            }
            //            if (datadic[@"card_id"]) {
            //                [dic setObject:datadic[@"card_id"] forKey:@"card_id"];
            //            }
            //            if (datadic[@"address"]) {
            //                [dic setObject:datadic[@"address"] forKey:@"address"];
            //            }
            //
            //            NSMutableArray *telarr = [dic[@"tel"] mutableCopy];
            //
            //            if (datadic[@"tel1"]) {
            //                telarr[0] = datadic[@"tel1"];
            //            }
            //
            //            if (datadic[@"tel2"]) {
            //                telarr[1] = datadic[@"tel2"];
            //            }
            //            [dic setObject:telarr forKey:@"tel"];
            //            [_dataArr replaceObjectAtIndex:index withObject:dic];
        };
        
        //选择证件类型
        cell.roomAgencyAddProtocolCellCardBlock = ^(NSInteger index) {
            
            [weakCell.nameTF.textfield resignFirstResponder];
            [weakCell.phoneTF.textfield resignFirstResponder];
            [weakCell.phoneTF2.textfield resignFirstResponder];
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self     getDetailConfigArrByConfigState:2]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                //                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[index]];
                //                [tempDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"card_type"];
                //                [tempDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"card_type_name"];
                //                [_dataArr replaceObjectAtIndex:index withObject:tempDic];
                //                cell.dic = _dataArr[indexPath.row];
            };
            [self.view addSubview:view];
        };
        return cell;
    }else if (indexPath.section == 4){
        
        AddContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell"];
        if (!cell) {
            
            cell = [[AddContractCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section == 5){
        
        AddContractCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell2"];
        if (!cell) {
            
            cell = [[AddContractCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        return [[UITableViewCell alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加合同";
    
    
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
