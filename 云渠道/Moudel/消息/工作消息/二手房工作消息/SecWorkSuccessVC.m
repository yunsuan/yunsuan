//
//  SecWorkSuccessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/8.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SecWorkSuccessVC.h"

#import "SecAllRoomDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "CountDownCell.h"
#import "BrokerageDetailTableCell3.h"

@interface SecWorkSuccessVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_contentArr;
    NSString *_state;
    NSMutableArray *_processArr;
    NSString *_endtime;
    NSMutableDictionary *_dataDic;
}

@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *gotoBtn;

@end

@implementation SecWorkSuccessVC

- (instancetype)initWithData:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _processArr = [@[] mutableCopy];
        _dataDic = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
        _contentArr = @[@[[NSString stringWithFormat:@"抢单时间:%@",dataDic[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",dataDic[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",dataDic[@"agent_tel"]]],@[[NSString stringWithFormat:@"%@",dataDic[@"house"]],[NSString stringWithFormat:@"房源编号：%@",dataDic[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",dataDic[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",dataDic[@"name"]],[NSString stringWithFormat:@"性别：%@",[dataDic[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",dataDic[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",dataDic[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",dataDic[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",dataDic[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",dataDic[@"record_time"]],[NSString stringWithFormat:@"备注：%@",dataDic[@"comment"]]]];
        
        _endtime = [NSString stringWithFormat:@"%@",dataDic[@"timeLimit"]];
        _processArr = [NSMutableArray arrayWithArray:dataDic[@"process"]];
        _state = dataDic[@"current_state"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionGotoBtn:(UIButton *)btn{
    
    SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:_dataDic[@"house_id"] city:@""];
    nextVC.type = [_dataDic[@"type"] integerValue];//[model.type integerValue];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
//    if (self.secWorkSuccessVCBlock) {
//
//        self.secWorkSuccessVCBlock();
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"goto" object:nil];
    
}


#pragma mark -- tableView --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (![_state isEqualToString:@"待确认"] && ![_state isEqualToString:@"勘察中"]) {
        
        if (_contentArr.count) {
            
            return 3;
        }else{
            
            return 0;
        }
    }else{
        
        if (_contentArr.count) {
            
            return 4;
        }else{
            
            return 0;
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (![_state isEqualToString:@"待确认"] && ![_state isEqualToString:@"勘察中"]) {
        
        if (section < _contentArr.count) {
            
            return [_contentArr[section] count];
        }else{
            
            return _processArr.count;
        }
    }else{
        
        if (section == 0) {
            
            return 1;
        }else if (section < _contentArr.count + 1) {
            
            return [_contentArr[section - 1] count];
        }else{
            
            return _processArr.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (![_state isEqualToString:@"待确认"] && ![_state isEqualToString:@"勘察中"]) {
        
        if (section == 2) {
            
            return 0;
        }else{
            
            return 40 *SIZE;
        }
    }else{
        
        if (section == 3) {
            
            return 0;
        }else{
            
            return 40 *SIZE;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (![_state isEqualToString:@"待确认"] && ![_state isEqualToString:@"勘察中"]) {
        
        if (section == 0) {
            
            header.titleL.text = @"抢单信息";
        }else{
            
            header.titleL.text = @"报备信息";
        }
    }else{
        if (section == 0) {
            
            header.titleL.text = @"失效倒计时";
        }else if (section == 1) {
            
            header.titleL.text = @"抢单信息";
        }else{
            
            header.titleL.text = @"报备信息";
        }
    }
    
    header.lineView.hidden = YES;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![_state isEqualToString:@"待确认"] && ![_state isEqualToString:@"勘察中"]) {
        
        if (indexPath.section < _contentArr.count) {
            
            SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
            if (!cell) {
                
                cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.lineView.hidden = YES;
            
            cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
            
            return cell;
        }else{
            
            BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
            if (!cell) {
                cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_processArr[indexPath.row][@"process_name"],_processArr[indexPath.row][@"time"]];
            if (indexPath.row == 0) {
                
                cell.upLine.hidden = YES;
            }else{
                
                cell.upLine.hidden = NO;
            }
            if (indexPath.row == _processArr.count - 1) {
                
                cell.downLine.hidden = YES;
            }else{
                
                cell.downLine.hidden = NO;
            }
            return cell;
        }
    }else{
        
        if (indexPath.section == 0) {
            
            static NSString *CellIdentifier = @"CountDownCell";
            CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
            cell.countdownblock = ^{
                [self refresh];
            };
            [cell setcountdownbyendtime:_endtime];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.section < _contentArr.count + 1){
            
            SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
            if (!cell) {
                
                cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.lineView.hidden = YES;
            
            cell.contentL.text = _contentArr[indexPath.section - 1][indexPath.row];
            
            return cell;
        }else{
            
            BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
            if (!cell) {
                cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_processArr[indexPath.row][@"process_name"],_processArr[indexPath.row][@"time"]];
            if (indexPath.row == 0) {
                
                cell.upLine.hidden = YES;
            }else{
                
                cell.upLine.hidden = NO;
            }
            if (indexPath.row == _processArr.count - 1) {
                
                cell.downLine.hidden = YES;
            }else{
                
                cell.downLine.hidden = NO;
            }
            return cell;
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"有效详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    if ([_state isEqualToString:@"勘察完成"]) {
        
        _detailTable.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE);
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
        [_gotoBtn addTarget:self action:@selector(ActionGotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_gotoBtn setTitle:@"去查看" forState:UIControlStateNormal];
        [_gotoBtn setBackgroundColor:YJBlueBtnColor];
        [self.view addSubview:_gotoBtn];
    }
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
