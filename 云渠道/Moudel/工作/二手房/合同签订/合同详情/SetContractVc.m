//
//  SetContractVc.m
//  云渠道
//
//  Created by xiaoq on 2019/2/18.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SetContractVc.h"
#import "BlueTitleMoreHeader.h"
#import "SinglePickView.h"
#import "DateChooseView.h"
#import "AddContractCell.h"

@interface SetContractVc ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titleArr;
    NSMutableArray *_foldArr;
    NSDateFormatter *_formatter;

}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation SetContractVc


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
}

- (void)initDataSource{
    
    _titleArr = @[@"交易信息"];
    _foldArr = [[NSMutableArray alloc] initWithArray:@[@"1"]];
    if (!_tradedic) {
        _tradedic =[NSMutableDictionary dictionaryWithDictionary:@{@"deal_code":@"",
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
    }
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];

    
    
}



- (void)ActionNextBtn:(UIButton *)btn{
    
 
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
    
 
       NSDictionary * adddic = @{
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
                   @"type":@"1"
                   };
    
    [BaseRequest POST:AddContract_URL parameters:adddic success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            [self showContent:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
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
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

        
        return 6 *SIZE;

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
//    [header.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
 
    
    return header;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        AddContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddContractCell"];
        if (!cell) {
            
            cell = [[AddContractCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddContractCell"];
            
        }
        [cell setDataWithdic:[NSMutableDictionary dictionaryWithDictionary:_tradedic]];
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
    
    
}


#pragma mark  -----action-----




- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"修改合同";
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
