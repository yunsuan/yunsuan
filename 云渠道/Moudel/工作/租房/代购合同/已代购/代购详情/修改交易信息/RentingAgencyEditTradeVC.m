//
//  RentingAgencyEditTradeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RentingAgencyEditTradeVC.h"

#import "RoomAgencyAddProtocolCell4.h"

#import "DateChooseView.h"
#import "SinglePickView.h"

@interface RentingAgencyEditTradeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableDictionary *_dataDic;
    NSDateFormatter *_formatter;
    
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingAgencyEditTradeVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
        [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_dataDic setObject:@"" forKey:key];
            }
        }];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY/MM/dd"];
    [self initUI];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([self isEmpty:cell.priceTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入交易总价"];
        return;
    }
    
    if ([self isEmpty:cell.sincerityTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入诚意金"];
        return;
    }
    
    if ([self isEmpty:cell.breachTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入违约金"];
        return;
    }
    
    if ([self isEmpty:cell.payWayBtn.content.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择付款方式"];
        return;
    }
    
    if ([self isEmpty:cell.signTimeBtn.content.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择签约时间"];
        return;
    }
    
    //    if ([self isEmpty:cell.eventTV.text]) {
    //
    //        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入约定事项"];
    //        return;
    //    }
    NSDictionary *dic = @{@"sub_id":_dataDic[@"sub_id"],
                          @"total_price":cell.priceTF.textfield.text,
                          @"earnest_money":cell.sincerityTF.textfield.text,
                          @"break_money":cell.breachTF.textfield.text,
                          @"broker_ratio":_dataDic[@"broker_ratio"],
                          @"pay_way":cell.payWayBtn->str,
                          @"appoint_construct_time":cell.signTimeBtn->str,
                          @"comment":cell.eventTV.text
                          };
    [BaseRequest POST:PurchaseRentSub_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.rentingAgencyEditTradeVCBlock) {
                
                self.rentingAgencyEditTradeVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomAgencyAddProtocolCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyAddProtocolCell4"];
    if (!cell) {
        
        cell = [[RoomAgencyAddProtocolCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyAddProtocolCell4"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataDic.count) {
        
        cell.ratio = [_dataDic[@"broker_ratio"] integerValue];
    }else{
        
        cell.ratio = 0;
    }
    
    cell.tradeDic = _dataDic;
    cell.priceTF.unitL.text = @"元";
    __weak typeof(RoomAgencyAddProtocolCell4) *weakcell = cell;
    cell.roomAgencyAddProtocolCell4TimeBlock = ^{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
        view.dateblock = ^(NSDate *date) {
            
            [_dataDic setObject:[_formatter stringFromDate:date] forKey:@"appoint_construct_time"];
            weakcell.signTimeBtn->str = [_formatter stringFromDate:date];
            weakcell.signTimeBtn.content.text = [_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    };
    
    cell.roomAgencyAddProtocolCell4PayBlock = ^{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:PAY_WAY]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            weakcell.payWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
            weakcell.payWayBtn->str = [NSString stringWithFormat:@"%@", ID];
            [_dataDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"pay_way"];
            
            RoomAgencyAddProtocolCell4 *cell = (RoomAgencyAddProtocolCell4 *)[tableView cellForRowAtIndexPath:indexPath];
            
            if ([self isEmpty:cell.priceTF.textfield.text]) {
                
                [_dataDic setObject:@"" forKey:@"total_price"];
            }else{
                
                [_dataDic setObject:cell.priceTF.textfield.text forKey:@"total_price"];
            }
            
            if ([self isEmpty:cell.sincerityTF.textfield.text]) {
                
                [_dataDic setObject:@"" forKey:@"earnest_money"];
            }else{
                
                [_dataDic setObject:cell.sincerityTF.textfield.text forKey:@"earnest_money"];
            }
            
            if ([self isEmpty:cell.breachTF.textfield.text]) {
                
                [_dataDic setObject:@"" forKey:@"break_money"];
            }else{
                
                [_dataDic setObject:cell.breachTF.textfield.text forKey:@"break_money"];
            }
            
            if (!cell.payWayBtn->str.length) {
                
                [_dataDic setObject:@"" forKey:@"pay_way"];
            }else{
                
                [_dataDic setObject:cell.payWayBtn->str forKey:@"pay_way"];
            }
            
            if (!cell.signTimeBtn->str.length) {
                
                [_dataDic setObject:@"" forKey:@"appoint_construct_time"];
            }else{
                
                [_dataDic setObject:cell.signTimeBtn->str forKey:@"appoint_construct_time"];
            }
            
            if (![self isEmpty:cell.eventTV.text]) {
                
                [_dataDic setObject:cell.eventTV.text forKey:@"comment"];
            }else{
                
                [_dataDic setObject:@"" forKey:@"comment"];
            }
            
            [tableView reloadData];
        };
        [self.view addSubview:view];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"修改交易合同";
    
    
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
