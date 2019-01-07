//
//  RentingAgencyDoneDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingAgencyDoneDetailVC.h"
#import "AgencyDoneCustomerDetailVC.h"
#import "RentingCancelAgencyProtocolVC.h"

#import "AgencyDoneHeader.h"
//#import "BaseHeader.h"
#import "BlueTitleMoreHeader.h"
#import "SingleContentCell.h"
#import "NameSexImgCell.h"
#import "AddPeopleCell.h"

@interface RentingAgencyDoneDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _item;
    //    NSArray *_titleArr;
    //    NSArray *_headerArr;
    NSArray *_contentArr;
    NSArray *_contentArr2;
    NSArray *_contentArr3;
    NSInteger _count;
    NSDictionary *_subDic;
    NSArray *_customerArr;
    NSMutableArray *_customerUseArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingAgencyDoneDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _customerUseArr = [NSMutableArray arrayWithObjects:@[], nil];
    [BaseRequest GET:RentPurchaseContractDetail_URL parameters:@{@"sub_id":_sub_id} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            _customerArr = resposeObject[@"data"][@"contact_info"];
            
            for (int i= 0; i<_customerArr.count; i++) {
                [_customerUseArr addObject:@[[NSString stringWithFormat:@"名称：%@",_customerArr[i][@"name"]],[NSString stringWithFormat:@"证件类型：%@",_customerArr[i][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",_customerArr[i][@"card_id"]],[NSString stringWithFormat:@"通讯地址：%@",_customerArr[i][@"address"]]]];
            }
            _count = _customerArr.count;
            _subDic =resposeObject[@"data"][@"basic_info"];
            _contentArr2 = @[[NSString stringWithFormat:@"公司名称：%@",resposeObject[@"data"][@"agent_info"][@"company_name"]],[NSString stringWithFormat:@"门店名称：%@",resposeObject[@"data"][@"agent_info"][@"store_name"]],[NSString stringWithFormat:@"门店地址：%@",resposeObject[@"data"][@"agent_info"][@"store_address"]],[NSString stringWithFormat:@"经办人名称：%@",resposeObject[@"data"][@"agent_info"][@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",resposeObject[@"data"][@"agent_info"][@"agent_tel"]],[NSString stringWithFormat:@"登记日期：%@",resposeObject[@"data"][@"agent_info"][@"regist_time"]]];
            
            _contentArr3 = @[[NSString stringWithFormat:@"房源编号：%@",_subDic[@"house_code"]],[NSString stringWithFormat:@"所属小区：%@",resposeObject[@"data"][@"house_info"][@"project_name"]],[NSString stringWithFormat:@"物业类型：%@",resposeObject[@"data"][@"house_info"][@"property_type"]],[NSString stringWithFormat:@"房号：%@",resposeObject[@"data"][@"house_info"][@"house_info"]],[NSString stringWithFormat:@"户型：%@",resposeObject[@"data"][@"house_info"][@"house_type"]],[NSString stringWithFormat:@"产权面积：%@",resposeObject[@"data"][@"house_info"][@"build_area"]],[NSString stringWithFormat:@"房屋所有权证号：%@",resposeObject[@"data"][@"house_info"][@"permit_code"]],[NSString stringWithFormat:@"国土使用证号：%@",resposeObject[@"data"][@"house_info"][@"land_use_permit_code"]]];
            [_table reloadData];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
    
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //    UIAlertAction *protocol = [UIAlertAction actionWithTitle:@"转合同" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //
    //    }];
    
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"挞定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RentingCancelAgencyProtocolVC *nextVC = [[RentingCancelAgencyProtocolVC alloc] init];
        nextVC.sub_id = _sub_id;
        NSString *tel = _customerArr[0][@"tel"];
        NSArray *array = [tel componentsSeparatedByString:@","];
        NSArray *infoarr = @[[NSString stringWithFormat:@"交易编号：%@",_subDic[@"sub_code"]],@"推荐编号：",[NSString stringWithFormat:@"客户名称：%@",_customerArr[0][@"name"]],[NSString stringWithFormat:@"联系电话：%@",array[0]],[NSString stringWithFormat:@"房源编号：%@",_subDic[@"house_code"]],_contentArr3[1],_contentArr3[3],@"挞定类型:",@"违约金:",@"挞定描述:",@"登记时间:"];
        nextVC.infoArr = infoarr;
        nextVC.broker = _subDic[@"break_money"];
        nextVC.rentingCancelAgencyProtocolVCBlock = ^{

            if (self.rentingAgencyDoneDetailVCBlock) {

                self.rentingAgencyDoneDetailVCBlock();
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //    [alert addAction:protocol];
    [alert addAction:set];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark -- tableView;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        if ([_subDic[@"check_state"] integerValue] == 1) {
            
            return _count + 1;
        }else{
            
            return _count + 2;
        }
    }else{
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        if (section == 0) {
            
            return 0;
        }else if (section < _count + 1){
            
            return 4;
        }else{
            
            return 1;
        }
    }else if (_item == 1){
        
        return _contentArr2.count;
    }else{
        
        return _contentArr3.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == _count + 1 && _item == 0) {
        
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        AgencyDoneHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgencyDoneHeader"];
        if (!header) {
            
            header = [[AgencyDoneHeader alloc] initWithReuseIdentifier:@"AgencyDoneHeader"];
            
        }
        
        header.validL.hidden = YES;;
        header.auditL.hidden = YES;;
        header.payL.hidden = YES;;
        
        [header.infoBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.infoBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.agentBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.agentBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        [header.roomBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.roomBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
        
        header.roomCodeL.text =[NSString stringWithFormat:@"房源编号：%@",_subDic[@"house_code"]];
        header.tradeCodeL.text = [NSString stringWithFormat:@"交易编号：%@",_subDic[@"sub_code"]];
        //        header.recommendL.text = @"推荐编号：？？？？？？";
        //        header.validL.text = @"未接";
        
        if ([_subDic[@"check_state"] integerValue] == 1) {
            
            header.editBtn.hidden = YES;
            [header.validL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(header.titleView).offset(10 *SIZE);
                make.top.equalTo(header.tradeCodeL.mas_bottom).offset(7 *SIZE);
                make.width.mas_equalTo(40 *SIZE);
                make.height.mas_equalTo(17 *SIZE);
                make.bottom.equalTo(header.titleView).offset(-13 *SIZE);
            }];
            
            [header.auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(header.validL.mas_right).offset(5 *SIZE);
                make.top.equalTo(header.tradeCodeL.mas_bottom).offset(7 *SIZE);
                make.width.mas_equalTo(40 *SIZE);
                make.height.mas_equalTo(17 *SIZE);
                make.bottom.equalTo(header.titleView).offset(-13 *SIZE);
            }];
            
            header.validL.hidden = YES;;
            header.auditL.hidden = NO;;
            //            header.validL.text = @"有效";
            header.auditL.text = @"已审核";
            header.reviewTimeL.text = [NSString stringWithFormat:@"审核时间：%@",_subDic[@"check_time"]];
        }
        else{
            
            header.editBtn.hidden = NO;
            header.auditL.hidden = NO;;
            
            [header.auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(header.titleView).offset(10 *SIZE);
                make.top.equalTo(header.tradeCodeL.mas_bottom).offset(7 *SIZE);
                make.width.mas_equalTo(40 *SIZE);
                make.height.mas_equalTo(17 *SIZE);
                make.bottom.equalTo(header.titleView).offset(-13 *SIZE);
            }];
            header.validL.text = @"";
            header.auditL.text = @"未审核";
            header.payL.text = @"";
        }
        
        
        header.priceL.text = [NSString stringWithFormat:@"交易总价：%@万",_subDic[@"total_price"]];
        header.SincertyGoldL.text = [NSString stringWithFormat:@"诚意金：%@元",_subDic[@"earnest_money"]];
        header.breachL.text = [NSString stringWithFormat:@"违约金：%@元",_subDic[@"break_money"]];
        header.commissionL.text = [NSString stringWithFormat:@"佣金：%@%@",_subDic[@"broker_ratio"],@"%"];
        header.payWayL.text = [NSString stringWithFormat:@"付款方式：%@",_subDic[@"pay_way"]];
        header.timeL.text = [NSString stringWithFormat:@"预定签约时间：%@",_subDic[@"appoint_construct_time"]];
        header.comment.text = [NSString stringWithFormat:@"约定事项：%@",_subDic[@"comment"]];
        
        header.reviewL.text = [NSString stringWithFormat:@"审核人：%@",_subDic[@"check_person"]];
        
        
        if (_item == 0) {
            
            [header.infoBtn setBackgroundColor:YJBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_item == 1){
            
            [header.agentBtn setBackgroundColor:YJBlueBtnColor];
            [header.agentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.roomBtn setBackgroundColor:YJBlueBtnColor];
            [header.roomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.agencyDoneHeaderBlock = ^(NSInteger index) {
            
            _item = index;
            [tableView reloadData];
        };
        
        header.agencyEditHeaderBlock = ^{
            
//            AgencyEditTradeVC *nextVC = [[AgencyEditTradeVC alloc] initWithData:_subDic];
//            nextVC.agencyEditTradeBlock = ^{
//
//                [self initDataSource];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        return header;
    }else{
        
        if (_item == 0) {
            
            if (section < _count+1) {
                
                BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
                if (!header) {
                    
                    header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
                }
                if (section ==1) {
                    header.titleL.text = @"主权益人";
                }
                else{
                    header.titleL.text = @"附权益人";
                }
                header.lineView.backgroundColor = [UIColor whiteColor];
                header.blueTitleMoreHeaderBlock = ^{
                    AgencyDoneCustomerDetailVC *nextVC = [[AgencyDoneCustomerDetailVC alloc] init];
                    nextVC.status = _subDic[@"check_state"];
                    nextVC.customerDic = _customerArr[section-1];
                    nextVC.agencyDoneCustomerDetailVCBlock = ^{
                        
                        [self initDataSource];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                return header;
            }else{
                
                return [[UIView alloc] init];
            }
        }else{
            
            BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
            if (!header) {
                
                header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
            }
            
            header.titleL.text = @"2222";
            header.lineView.backgroundColor = [UIColor blackColor];
            return header;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (_item == 2) {
        
        if (section == 0) {
            
            return 0;
        }else{
            
            return 8 *SIZE;
        }
    }else{
        
        return SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.section == _count+1) {
            
            AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPeopleCell"];
            if (!cell) {
                
                cell = [[AddPeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddPeopleCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addImg.image = [UIImage imageNamed:@"add30"];
            
            return cell;
        }else{
            
            NameSexImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameSexImgCell"];
            if (!cell) {
                
                cell = [[NameSexImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameSexImgCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.lineView.hidden = YES;
            cell.contentL.text = _customerUseArr[indexPath.section][indexPath.row];
            
            if (indexPath.row == 0) {
                
                if ([_customerArr[indexPath.section-1][@"sex"] integerValue]==0) {
                    cell.sexImg.hidden = YES;
                }
                else if([_customerArr[indexPath.section-1][@"sex"] integerValue]==1)
                {
                    cell.sexImg.hidden = NO;
                    cell.sexImg.image = [UIImage imageNamed:@"man"];
                }
                else{
                    cell.sexImg.hidden = NO;
                    cell.sexImg.image = [UIImage imageNamed:@"woman"];
                }
            }else{
                
                cell.sexImg.hidden = YES;
            }
            [cell.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(27*SIZE);
                make.top.equalTo(cell.contentView).offset(9*SIZE);
                make.width.mas_equalTo(cell.contentL.mj_textWith + 10 *SIZE);
            }];
            return cell;
        }
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.hidden = YES;
        
        if (_item == 1){
            
            cell.contentL.text = _contentArr2[indexPath.row];
        }else{
            
            cell.contentL.text = _contentArr3[indexPath.row];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_item == 0) {
        
        if (indexPath.section == _count+1) {
            
//            AgencyEditCustomerDetailVC *nextVC = [[AgencyEditCustomerDetailVC alloc] initWithData:@{}];
//            nextVC.status = @"添加";
//            nextVC.subId = _sub_id;
//            nextVC.agencyAddCustomerDetailVCBlock = ^{
//                
//                [self initDataSource];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"代购详情";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.estimatedSectionHeaderHeight = 425 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 30 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
