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
    _tradedic =[NSMutableDictionary dictionaryWithDictionary:@{@"0":@"",
                                                               @"1":@"",
                                                               @"2":@"",
                                                               @"3":@"",
                                                               @"4":@"",
                                                               @"5":@"",
                                                               @"6":@"",
                                                               @"7":@"",
                                                               @"8":@"",
                                                               @"9":@"",
                                                               @"10":@"",
                                                               @"11":@""
                                                               }];  //替换0～11为接口需要的键值
    _buyarr =[NSMutableArray arrayWithArray:@[@""]];
    _sellarr =[NSMutableArray arrayWithArray:@[@""]];
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
        else if(section ==1)
        {
            return _buyarr.count;
        }else{
            return _sellarr.count;
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
    
        AddContractCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell2"];
        if (!cell) {
            
            cell = [[AddContractCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell2"];
            [cell.addbtn addTarget:self action:@selector(action_addbuyer) forControlEvents:UIControlEventTouchUpInside];
            [cell.choosebtn addTarget:self action:@selector(action_choosebuyer) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        
        AddContractCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell3"];
        if (!cell) {
            
            cell = [[AddContractCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell3"];
            [cell.choosebtn addTarget:self action:@selector(action_chooseseller) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark  -----action-----
-(void)action_addbuyer
{
    AddPeopleVC *vc = [[AddPeopleVC alloc]init];
    vc.AddPeopleblock = ^(NSMutableDictionary * _Nonnull dic) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)action_addseller
{
//    MaintainModifyCustomVC *nextVC = [[MaintainModifyCustomVC alloc] init];
////    nextVC.houseId = _houseId;
//    nextVC.status = @"添加";
//    nextVC.maintainModifyCustomVCBlock = ^(NSDictionary *dic) {
//
//    };
//    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)action_choosebuyer
{
    ChooseCustomerVC *vc =[[ChooseCustomerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)action_chooseseller
{
    ChooseHouseVC *vc =[[ChooseHouseVC alloc]init];
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
