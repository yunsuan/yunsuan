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
    NSMutableDictionary *_tradedic;
    NSMutableArray *_buyarr;
    NSMutableArray *_sellarr;
    NSDateFormatter *_formatter;
    BOOL _ischoose;
    BOOL _isadd;
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
    _tradedic =[NSMutableDictionary dictionaryWithDictionary:@{@"construct_code":@"",
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
    _buyarr =[NSMutableArray arrayWithArray:@[@""]];
    _sellarr =[NSMutableArray arrayWithArray:@[@""]];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY/MM/dd"];
//    _ischoose = NO;
    _isadd = NO;
    
    
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
        else if(section ==1)
        {
            if (_isadd) {

                  return _buyarr.count+1;

                
            }else{
                return _buyarr.count==1?1:_buyarr.count+1;
            }
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    AddContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell"];
    if (!cell) {
        
        cell = [[AddContractCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell"];
        
        __weak AddContractCell *weakcell = cell;
        cell.cardTimeBlock = ^{
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                
                weakcell.loanTimeBtn.content.text = [self->_formatter stringFromDate:date];
                weakcell.loanTimeBtn->str = [self->_formatter stringFromDate:date];
//                [self.handleDic setObject:[self->_formatter stringFromDate:date] forKey:@"regist_time"];
            };
            [self.view addSubview:view];
        };
        
        cell.cancelTimeBlock = ^{
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                
                weakcell.cardTimeBtn.content.text = [self->_formatter stringFromDate:date];
                weakcell.cardTimeBtn->str = [self->_formatter stringFromDate:date];
                //                [self.handleDic setObject:[self->_formatter stringFromDate:date] forKey:@"regist_time"];
            };
            [self.view addSubview:view];
        };
        
        cell.paywWayBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.payWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.payWayBtn->str = [NSString stringWithFormat:@"%@", ID];

                //                [tableView reloadData];
            };
            [self.view addSubview:view];
            
        };
        
        cell.buyReasonBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.buyReasonBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.buyReasonBtn->str = [NSString stringWithFormat:@"%@", ID];
                
                //                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        cell.sellReasonBlock = ^{
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                cell.sellReasonBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                cell.sellReasonBtn->str = [NSString stringWithFormat:@"%@", ID];
                
                //                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    }else if (indexPath.section == 1) {
#pragma mark   ---- 买方信息
        if (indexPath.row ==0) {
            if ([_buyarr[0] isEqual:@""]) {
                AddContractCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell2"];
                if (!cell) {
                
                    cell = [[AddContractCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell2"];
                    [cell.addbtn addTarget:self action:@selector(action_addbuy) forControlEvents:UIControlEventTouchUpInside];
                    [cell.choosebtn addTarget:self action:@selector(action_choosebuyer) forControlEvents:UIControlEventTouchUpInside];
                                  }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
            }else{
             if (_isadd == NO)
            {
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
                            cell.stickieBtn.hidden = YES;
                       cell.titelL.text = @"主权益人";
                        
                          cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                          return cell;
            }}
        }else if (indexPath.row==_buyarr.count)
        {
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
            if (indexPath.row ==1 &&_isadd ==NO) {
                    cell.stickieBtn.hidden = YES;
                cell.titelL.text = @"主权益人";
                }
            else{
                cell.stickieBtn.hidden = NO;
                cell.titelL.text = @"副权益人";
                }
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
//                UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action_addseller)];
//                [cell.addImg addGestureRecognizer:tapGesturRecognizer];
//
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
            else{
                AddContractCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell4"];
                if (!cell) {
                    
                    cell = [[AddContractCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell4"];
                    
                }
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_sellarr[indexPath.row]];
                [cell setData:dic];
                if (indexPath.row ==1) {
                    cell.stickieBtn.hidden = YES;
                    cell.titelL.text = @"主权益人";
                }
                else{
                    cell.stickieBtn.hidden = NO;
                    cell.titelL.text = @"副权益人";
                }
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
        if (_isadd ==NO) {
            if (indexPath.row>0&&indexPath.row<_buyarr.count+1) {
                AddPeopleVC *vc = [[AddPeopleVC alloc]init];
                vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else{
            if (indexPath.row>=0&&indexPath.row<_buyarr.count+1) {
                AddPeopleVC *vc = [[AddPeopleVC alloc]init];
                vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }else if (indexPath.section ==2){
        if (indexPath.row >0&&indexPath.row<_sellarr.count+1) {
            AddPeopleVC *vc = [[AddPeopleVC alloc]init];
            vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


#pragma mark  -----action-----

-(void)action_addbuy
{
    _isadd = YES;
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_buyarr removeAllObjects];
        [_buyarr addObject:dic];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)action_addbuyer
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_buyarr addObject:dic];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)action_fixbuyer
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)action_fixseller
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)action_addseller
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        [_sellarr addObject:dic];
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
