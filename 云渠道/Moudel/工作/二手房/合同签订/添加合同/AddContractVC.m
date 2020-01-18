//
//  AddContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractVC.h"
#import "AddPeopleVC.h"
#import "ChooseHouseVC.h"
#import "ChooseCustomerVC.h"

#import "LookMaintainVC.h"
#import "RoomMaintainVC.h"
#import "ContractSignVC.h"
#import "SelectCustomVC.h"

#import "BlueTitleMoreHeader.h"
#import "AddContractCell.h"
#import "AddContractCell2.h"
#import "AddContractCell3.h"
#import "AddContractCell4.h"
#import "AddContractCell5.h"
#import "AddContractCell6.h"
#import "AddContractCell7.h"
#import "SinglePickView.h"
#import "DateChooseView.h"


@interface AddContractVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titleArr;
    NSMutableArray *_foldArr;
    NSDateFormatter *_formatter;
    BOOL _ischoose;
//    BOOL _isadd;
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
    
    _titleArr = @[@"交易信息",@"买方信息",@"卖方信息"];
    _foldArr = [[NSMutableArray alloc] initWithArray:@[@"1",@"0",@"0"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddhhmmss"];
    NSString *str = [formatter stringFromDate:[NSDate date]];
    _tradedic =[NSMutableDictionary dictionaryWithDictionary:@{@"deal_code":str,
                                                               @"deal_money":@"",
                                                               @"buy_breach":@"",
                                                               @"sale_breach":@"",
                                                               @"buy_brokerage":@"",
                                                               @"sale_brokerage":@"",
                                                               @"certificate_time":@"",
                                                               @"mortgage_cancel_time":@"",
                                                               @"pay_way":@"",
                                                               @"sale_reason":@"",
                                                               @"buy_reason":@"",
                                                               @"comment":@""
                                                               }];
    if (!_buyarr) {
//        _buyarr =[NSMutableArray arrayWithArray:@[@""]];
        _buyarr = [@[] mutableCopy];
    }
    if (!_sellarr) {
         _sellarr =[NSMutableArray arrayWithArray:@[@""]];
    }
   
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
//    _ischoose = NO;
//    _isadd = NO;
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([_buyarr[0] isEqual:@""]) {
        [self showContent:@"请选择或添加买方信息"];
        return;
    }
    if ([_sellarr[0] isEqual:@""]) {
        [self showContent:@"请选择卖方信息"];
        return;
    }
    if ([_tradedic[@"deal_code"] isEqual:@""]) {
        [self showContent:@"请填写合同编号"];
        return;
    }
    if ([_tradedic[@"deal_money"] isEqual:@""]) {
        [self showContent:@"请填成交总价"];
        return;
    }
    if ([_tradedic[@"buy_breach"] isEqual:@""]) {
        [self showContent:@"请填写买方违约金"];
        return;
    }
    if ([_tradedic[@"sale_breach"] isEqual:@""]) {
        [self showContent:@"请填写卖房违约金"];
        return;
    }
    if ([_tradedic[@"buy_brokerage"] isEqual:@""]) {
        [self showContent:@"请填写买方支付佣金"];
        return;
    }
    if ([_tradedic[@"sale_brokerage"] isEqual:@""]) {
        [self showContent:@"请填写卖房支付佣金"];
        return;
    }
    if ([_tradedic[@"certificate_time"] isEqual:@""]) {
        [self showContent:@"请选择办证时间"];
        return;
    }
    if ([_tradedic[@"mortgage_cancel_time"] isEqual:@""]) {
        [self showContent:@"请选择注销抵押时间"];
        return;
    }
    if ([_tradedic[@"pay_way"] isEqual:@""]) {
        [self showContent:@"请选择付款方式"];
        return;
    }
    if ([_tradedic[@"buy_reason"] isEqual:@""]) {
        [self showContent:@"请选择买房原因"];
        return;
    }
    if ([_tradedic[@"sale_reason"] isEqual:@""]) {
        [self showContent:@"请选择卖房原因"];
        return;
    }
    if ([_tradedic[@"comment"] isEqual:@""]) {
        [self showContent:@"请填写约定事项"];
        return;
    }
    
    NSMutableArray *sellpeopel =[NSMutableArray array];
    for (int i = 1; i < _sellarr.count; i++) {
        NSDictionary *dic = @{
                              @"name":_sellarr[i][@"name"],
                              @"tel":_sellarr[i][@"tel"],
                              @"report_type":i==1?@"1":@"2",
                              @"card_type":_sellarr[i][@"card_type"],
                              @"card_id":_sellarr[i][@"card_id"],
                              @"address":_sellarr[i][@"address"],
                              @"sex":_sellarr[i][@"sex"],
                              @"sort":[NSString stringWithFormat:@"%d",i-1]
                              };
        [sellpeopel addObject:dic];
    }
    NSData *sellData = [NSJSONSerialization dataWithJSONObject:sellpeopel options:NSJSONWritingPrettyPrinted error:nil];
    NSString *selljson = [[NSString alloc] initWithData:sellData encoding:NSUTF8StringEncoding];
    NSMutableArray *buypeopel =[NSMutableArray array];
    NSDictionary *adddic = [NSDictionary dictionary];
    if (_buyarr[0][@"butter_tel"]) {
        
        for (int i = 1; i < _buyarr.count; i++) {
            NSDictionary *dic = @{
                                  @"name":_buyarr[i][@"name"],
                                  @"tel":_buyarr[i][@"tel"],
                                  @"report_type":i == 1?@"1":@"2",
                                  @"card_type":_buyarr[i][@"card_type"],
                                  @"card_id":_buyarr[i][@"card_id"],
                                  @"address":_buyarr[i][@"address"],
                                  @"sex":_buyarr[i][@"sex"],
                                  @"sort":[NSString stringWithFormat:@"%d",i - 1],
                                  @"property":_buyarr[i][@"property"]
                                  };
            [buypeopel addObject:dic];
        }
        
        NSData *buyData = [NSJSONSerialization dataWithJSONObject:buypeopel options:NSJSONWritingPrettyPrinted error:nil];
        NSString *buyjson = [[NSString alloc] initWithData:buyData encoding:NSUTF8StringEncoding];
        adddic = @{
                                 @"deal_code":_tradedic[@"deal_code"],
                                 @"deal_money":_tradedic[@"deal_money"],
                                 @"buy_breach":_tradedic[@"buy_breach"],
                                 @"sale_breach":_tradedic[@"sale_breach"],
                                 @"buy_brokerage":_tradedic[@"buy_brokerage"],
                                 @"sale_brokerage":_tradedic[@"sale_brokerage"],
                                 @"certificate_time":_tradedic[@"certificate_time"],
                             @"mortgage_cancel_time":_tradedic[@"mortgage_cancel_time"],
                                 @"pay_way":_tradedic[@"pay_way"],
                                 @"sale_reason":_tradedic[@"sale_reason"],
                                 @"buy_reason":_tradedic[@"buy_reason"],
                                 @"comment":_tradedic[@"comment"],
                                 @"house_id":_sellarr[0][@"house_id"],
                                 @"take_id":_buyarr[0][@"take_id"],
                                 @"sale_contact_group":selljson,
                                 @"buy_contact_group":buyjson,
                                 @"type":@"1"
                                 };
    }
    else{
        
        for (int i = 0; i < _buyarr.count; i++) {
            NSDictionary *dic = @{
                                  @"name":_buyarr[i][@"name"],
                                  @"tel":_buyarr[i][@"tel"],
                                  @"report_type": i == 0?@"1":@"2",
                                  @"card_type":_buyarr[i][@"card_type"],
                                  @"card_id":_buyarr[i][@"card_id"],
                                  @"address":_buyarr[i][@"address"],
                                  @"sex":_buyarr[i][@"sex"],
                                  @"sort":[NSString stringWithFormat:@"%d",i],
                                  @"property":_buyarr[i][@"property"]
                                  };
            [buypeopel addObject:dic];
        }
        
        NSData *buyData = [NSJSONSerialization dataWithJSONObject:buypeopel options:NSJSONWritingPrettyPrinted error:nil];
        NSString *buyjson = [[NSString alloc] initWithData:buyData encoding:NSUTF8StringEncoding];
        adddic = @{
                   @"deal_code":_tradedic[@"deal_code"],
                   @"deal_money":_tradedic[@"deal_money"],
                   @"buy_breach":_tradedic[@"buy_breach"],
                   @"sale_breach":_tradedic[@"sale_breach"],
                   @"buy_brokerage":_tradedic[@"buy_brokerage"],
                   @"sale_brokerage":_tradedic[@"sale_brokerage"],
                   @"certificate_time":_tradedic[@"certificate_time"],
                   @"mortgage_cancel_time":_tradedic[@"mortgage_cancel_time"],
                   @"pay_way":_tradedic[@"pay_way"],
                   @"sale_reason":_tradedic[@"sale_reason"],
                   @"buy_reason":_tradedic[@"buy_reason"],
                   @"comment":_tradedic[@"comment"],
                   @"house_id":_sellarr[0][@"house_id"],
                   @"sale_contact_group":selljson,
                   @"buy_contact_group":buyjson,
                   @"type":@"1"
                   };
    }

    [BaseRequest POST:AddContract_URL parameters:adddic success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            [self showContent:@"添加成功"];
            
            if (self.addContractVCBlock) {
                
                self.addContractVCBlock();
            }
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[LookMaintainVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
                if ([vc isKindOfClass:[RoomMaintainVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
                if ([vc isKindOfClass:[ContractSignVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
//            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
        else if(section ==1)
        {
            return _buyarr.count + 1;
//            if (_isadd) {
//
//                return _buyarr.count+1;
//            }else{
//                return _buyarr.count==1?1:_buyarr.count+1;
//            }
        }else{
            return _sellarr.count==1?1:_sellarr.count+1;
        }
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        
        return NO;
    }else if (indexPath.section == 1){
        
        if (!_buyarr.count) {
            
            return NO;
        }else{
            
            if (indexPath.row == 0) {
                
                if (_buyarr[0][@"butter_tel"]){
                    
                    return NO;
                }
                return YES;
            }else if (indexPath.row < _buyarr.count){
                
                return YES;
            }else{
                
                return NO;
            }
        }
    }else{
        if (indexPath.row < 2) {
            
            return NO;
        }
        else{
            return YES;
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    if (indexPath.section == 1) {
        if (_buyarr[0][@"butter_tel"]){
            
            [_buyarr removeObjectAtIndex:indexPath.row];
            if (_buyarr.count == 1) {
                
                [_buyarr removeAllObjects];
            }
        }else{
            
            [_buyarr removeObjectAtIndex:indexPath.row];
        }
        
        [_table reloadData];
//        [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [_sellarr removeObjectAtIndex:indexPath.row];
        [_table reloadData];
//        [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    
        AddContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell"];
        if (!cell) {
        
            cell = [[AddContractCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell"];
        
        }
        cell.data = _tradedic;
        [cell setDataWithdic:_tradedic];
        __weak AddContractCell *weakcell = cell;
        cell.cardTimeBlock = ^{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                
                weakcell.loanTimeBtn.content.text = [self->_formatter stringFromDate:date];
                weakcell.loanTimeBtn->str = [self->_formatter stringFromDate:date];
                [_tradedic setObject:[self->_formatter stringFromDate:date] forKey:@"certificate_time"];
            };
            [self.view addSubview:view];
        };
        
        cell.cancelTimeBlock = ^{
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                
                weakcell.cardTimeBtn.content.text = [self->_formatter stringFromDate:date];
                weakcell.cardTimeBtn->str = [self->_formatter stringFromDate:date];
                //                [self.handleDic setObject:[self->_formatter stringFromDate:date] forKey:@"regist_time"];
                [_tradedic setObject:[self->_formatter stringFromDate:date] forKey:@"mortgage_cancel_time"];
            };
            [self.view addSubview:view];
        };
        
        cell.paywWayBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.payWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.payWayBtn->str = [NSString stringWithFormat:@"%@", ID];
                [_tradedic setObject:[NSString stringWithFormat:@"%@", ID] forKey:@"pay_way"];
                //                [tableView reloadData];
            };
            [self.view addSubview:view];
            
        };
        
        cell.buyReasonBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:BUY_HOUSE_RESON]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.buyReasonBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.buyReasonBtn->str = [NSString stringWithFormat:@"%@", ID];
                [_tradedic setObject:[NSString stringWithFormat:@"%@", ID] forKey:@"buy_reason"];
                //                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        cell.sellReasonBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:SELL_HOUSE_RESON]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.sellReasonBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.sellReasonBtn->str = [NSString stringWithFormat:@"%@", ID];
                [_tradedic setObject:[NSString stringWithFormat:@"%@", ID] forKey:@"sale_reason"];
                //                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        cell.textFiledBlock = ^(NSMutableDictionary * _Nonnull datadic) {
            _tradedic = datadic;
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        return cell;
    }else if (indexPath.section == 1) {
#pragma mark   ---- 买方信息
        if (indexPath.row ==0) {
            
            if (_buyarr.count) {
                
                if (_buyarr[0][@"butter_tel"]) {
                    
                    AddContractCell7 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell7"];
                    if (!cell) {
                    
                        cell = [[AddContractCell7 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell7"];
                    }
                    [cell setDataDic:_buyarr[indexPath.row]];
                    [cell.choosebtn addTarget:self action:@selector(action_choosebuyer) forControlEvents:UIControlEventTouchUpInside];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else{
                    
                    AddContractCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell4"];
                    if (!cell) {
                        
                        cell = [[AddContractCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell4"];
                    }
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_buyarr[indexPath.row]];
                    [cell setData:dic];
                    cell.propertyL.hidden = NO;
                    cell.stickieBtn.hidden = YES;
                    cell.titelL.text = @"主权益人";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }else{
                
                AddContractCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell2"];
                if (!cell) {
                
                    cell = [[AddContractCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell2"];
                    [cell.addbtn addTarget:self action:@selector(action_addbuy) forControlEvents:UIControlEventTouchUpInside];
                    [cell.choosebtn addTarget:self action:@selector(action_choosebuyer) forControlEvents:UIControlEventTouchUpInside];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }else if (indexPath.row == _buyarr.count){
            
            AddContractCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell5"];
            if (!cell) {
                
                cell = [[AddContractCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell5"];
            }
            [cell.addBtn addTarget:self action:@selector(action_addbuyer) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            AddContractCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell4"];
            if (!cell) {
                cell = [[AddContractCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell4"];
            }
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_buyarr[indexPath.row]];
            [cell setData:dic];
            cell.propertyL.hidden = NO;
            if (indexPath.row == 1 && _buyarr[0][@"butter_tel"]) {
                    
                cell.stickieBtn.hidden = YES;
                cell.titelL.text = @"主权益人";
            }else{
                
                cell.stickieBtn.hidden = NO;
                cell.titelL.text = @"附权益人";
            }
            cell.indexpath = indexPath;
            cell.stickieBlock = ^(NSIndexPath * _Nonnull indexpath) {
                
                if (_buyarr[0][@"butter_tel"]) {

                    [_buyarr exchangeObjectAtIndex:indexpath.row withObjectAtIndex:0];
                    [_table reloadData];
                }else{

                    [_buyarr exchangeObjectAtIndex:indexpath.row withObjectAtIndex:1];
                    [_table reloadData];
                }
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }else {
#pragma mark  --卖方信息

        if (![_sellarr[0] isEqual:@""]) {
            
            if (indexPath.row ==0) {
                
                AddContractCell6 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell6"];
                if (!cell) {
                    
                    cell = [[AddContractCell6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell6"];
                    
                }
                [cell setDataDic:_sellarr[indexPath.row]];
                [cell.choosebtn addTarget:self action:@selector(action_chooseseller) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }else if(indexPath.row ==_sellarr.count){
                
                AddContractCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell5"];
                if (!cell) {
                    
                    cell = [[AddContractCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell5"];
                }
                
                [cell.addBtn addTarget:self action:@selector(action_addseller) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else{
                
                AddContractCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell4"];
                if (!cell) {
                    
                    cell = [[AddContractCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell4"];
                    
                }
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_sellarr[indexPath.row]];
                [cell setData:dic];
                cell.propertyL.hidden = YES;
                if (indexPath.row ==1) {
                    
                    cell.stickieBtn.hidden = YES;
                    cell.titelL.text = @"主权益人";
                }else{
                 
                    cell.stickieBtn.hidden = NO;
                    cell.titelL.text = @"附权益人";
                }
                cell.indexpath = indexPath;
                cell.stickieBlock = ^(NSIndexPath * _Nonnull indexpath) {
              
                    [_sellarr exchangeObjectAtIndex:indexpath.row withObjectAtIndex:1];
                    [_table reloadData];
                
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }

        }else{
            AddContractCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell3"];
            if (!cell) {
                
                cell = [[AddContractCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell3"];
                [cell.choosebtn addTarget:self action:@selector(action_chooseseller) forControlEvents:UIControlEventTouchUpInside];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (_buyarr[0][@"butter_tel"]) {
            if (indexPath.row > 0 && indexPath.row < _buyarr.count) {
                
                AddPeopleVC *vc = [[AddPeopleVC alloc]init];
                vc.dataDic = _buyarr[indexPath.row];
                vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
                    [_buyarr replaceObjectAtIndex:indexPath.row withObject:dic];
                    [_table reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else{
            if (indexPath.row >= 0 && indexPath.row < _buyarr.count) {
                AddPeopleVC *vc = [[AddPeopleVC alloc]init];
                vc.dataDic = _buyarr[indexPath.row];
                vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
                     [_buyarr replaceObjectAtIndex:indexPath.row withObject:dic];
                    [_table reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }else if (indexPath.section ==2){
        if (indexPath.row > 0 && indexPath.row < _sellarr.count) {
            AddPeopleVC *vc = [[AddPeopleVC alloc]init];
            vc.dataDic = _sellarr[indexPath.row];
            vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
                [_sellarr replaceObjectAtIndex:indexPath.row withObject:dic];
                [_table reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


#pragma mark  -----action-----

-(void)action_addbuy
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_buyarr removeAllObjects];
//        _isadd = YES;
        [_buyarr addObject:dic];
        [_table reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)action_addbuyer
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_buyarr addObject:dic];
        [_table reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)action_addseller
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_sellarr addObject:dic];
        [_table reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)action_choosebuyer
{
    ChooseCustomerVC *vc =[[ChooseCustomerVC alloc]init];
    vc.ChooseCustomerblock = ^(NSDictionary * _Nonnull dic) {
        [BaseRequest GET:TakePeopleList_URL
              parameters:@{@"take_id":dic[@"take_id"],
                           @"type":@"1"
                           }
                 success:^(id resposeObject) {
                     if ([resposeObject[@"code"] integerValue]==200) {
                         [_buyarr removeAllObjects];
                         [_buyarr addObject:dic];
//                         _isadd = YES;
                         [_buyarr addObjectsFromArray:resposeObject[@"data"]];
                         [_table reloadData];
                     }
                 }
                 failure:^(NSError *error) {
                     
                 }];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)action_chooseseller
{
    ChooseHouseVC *vc =[[ChooseHouseVC alloc]init];
    vc.ChooseHouseblock = ^(NSDictionary * _Nonnull dic) {
        
        
        [BaseRequest GET:HousePeopleList_URL
              parameters:@{@"house_id":dic[@"house_id"],
                               @"type":@"1"
                            }
                 success:^(id resposeObject) {
                     if ([resposeObject[@"code"] integerValue]==200) {
                         [_sellarr removeAllObjects];
                         [_sellarr addObject:dic];
                         [_sellarr addObjectsFromArray:resposeObject[@"data"]];
                         [_table reloadData];
                     }
                     
            
        }
                 failure:^(NSError *error) {
            
        }];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
    [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_nextBtn];
}
@end
