//
//  ReportFailDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportFailDetailVC.h"
#import "ReportFailComplaintVC.h"

#import "BrokerageDetailTableCell3.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface ReportFailDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
    NSString *_recordId;
    NSMutableArray *_processArr;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *complaintBtn;

@end

@implementation ReportFailDetailVC

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
    
    _titleArr = @[@"失效信息",@"抢单信息",@"报备信息"];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    
    _processArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseRecordDisabledDetail_URL parameters:@{@"survey_id":_recordId} success:^(id resposeObject) {
        
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
    
    _contentArr = @[@[[NSString stringWithFormat:@"失效类型：%@",data[@"disabled_state"]],[NSString stringWithFormat:@"失效时间：%@",data[@"disabled_time"]],[NSString stringWithFormat:@"失效描述：%@",data[@"disabled_reason"]]],@[[NSString stringWithFormat:@"抢单时间：%@",data[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",data[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"agent_tel"]]],@[[NSString stringWithFormat:@"%@",data[@"house"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",data[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",data[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",data[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]]];
    
    _processArr = [NSMutableArray arrayWithArray:data[@"process"]];
    [_detailTable reloadData];
}

- (void)ActionComplaintBtn:(UIButton *)btn{
    
    ReportFailComplaintVC *nextVC = [[ReportFailComplaintVC alloc] initWithSurveyId:_recordId];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _contentArr.count? _contentArr.count + 1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section < _contentArr.count) {
        
        return [_contentArr[section] count];
    }else{
        
        return _processArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section < _contentArr.count) {
        
        return 40 *SIZE;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section < _contentArr.count) {
        
        header.titleL.text = _titleArr[section];
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
}

- (void)initUI{
    
    self.titleLabel.text = @"失效详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaintBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"申诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    [_complaintBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.view addSubview:_complaintBtn];
}

@end
