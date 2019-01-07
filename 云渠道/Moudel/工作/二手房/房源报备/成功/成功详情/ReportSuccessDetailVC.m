//
//  ReportSuccessDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportSuccessDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "CountDownCell.h"
#import "BrokerageDetailTableCell3.h"

@interface ReportSuccessDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recordId;
    NSArray *_contentArr;
    NSString *_state;
    NSMutableArray *_processArr;
    NSString *_endtime;
}
@property (nonatomic, strong) UITableView *detailTable;

@end

@implementation ReportSuccessDetailVC

- (instancetype)initWithRecordId:(NSString *)recordId
{
    self = [super init];
    if (self) {
        
        _recordId = recordId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    
    _processArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseRecordValueDetail_URL parameters:@{@"survey_id":_recordId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}


- (void)SetData:(NSDictionary *)data{
    
    if (data[@"sub_info"]) {
        
        NSDictionary *dic = data[@"sub_info"];
        _contentArr = @[@[[NSString stringWithFormat:@"%@",data[@"house"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",data[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",data[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",data[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"抢单时间:%@",data[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",data[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"agent_tel"]]],@[[NSString stringWithFormat:@"经办人姓名：%@",dic[@"agent_name"]],[NSString stringWithFormat:@"经办人电话：%@",dic[@"agent_tel"]],[NSString stringWithFormat:@"经办人性别：%@",[dic[@"agent_sex"] integerValue] == 1 ? @"男":@"女"],[NSString stringWithFormat:@"预付金：%@",dic[@"earnest_money"]],[NSString stringWithFormat:@"违约金：%@",dic[@"break_money"]],[NSString stringWithFormat:@"预定签约时间：%@",dic[@"appoint_construct_time"]]]];
    }else{
        
        _contentArr = @[@[[NSString stringWithFormat:@"%@",data[@"house"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",data[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",data[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",data[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"抢单时间:%@",data[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",data[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"agent_tel"]]]];
    }
    
    _endtime = [NSString stringWithFormat:@"%@",data[@"timeLimit"]];
    _processArr = [NSMutableArray arrayWithArray:data[@"process"]];
    _state = [NSString stringWithFormat:@"%@",data[@"current_state"]];//data[@"current_state"];
    [_detailTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
        
        if (_contentArr.count) {
            
            return 1 + _contentArr.count;
        }else{
            
            return 0;
        }
    }else{
        
        if (_contentArr.count) {
            
            return 2 + _contentArr.count;
        }else{
            
            return 0;
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
        
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
    
    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
        
        if (section == _contentArr.count) {
            
            return 0;
        }else{
            
            return 40 *SIZE;
        }
    }else{
        
        if (section == _contentArr.count) {
            
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
    
    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
        
        if (section == 0) {
            
            header.titleL.text = @"报备信息";
        }else if(section == 1){
            
            header.titleL.text = @"抢单信息";
        }else{
            
            header.titleL.text = @"成交信息";
        }
    }else{
        if (section == 0) {
            
            header.titleL.text = @"失效倒计时";
        }else if (section == 1) {
            
            header.titleL.text = @"报备信息";
        }else if (section == 2) {
            
            header.titleL.text = @"抢单信息";
        }else{
            
            header.titleL.text = @"成交信息";
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
    
    if (![_state isEqualToString:@"1"] && ![_state isEqualToString:@"2"]) {
        
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
