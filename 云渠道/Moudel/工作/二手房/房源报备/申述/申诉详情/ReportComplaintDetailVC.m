//
//  ReportComplaintDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportComplaintDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "BlueTitleMoreHeader.h"

@interface ReportComplaintDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
    NSString *_appealId;
    NSString *_status;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UILabel *statusL;

@end

@implementation ReportComplaintDetailVC

- (instancetype)initWithAppealId:(NSString *)appealId
{
    self = [super init];
    if (self) {
        
        _appealId = appealId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"申诉信息",@"报备信息",@"抢单信息",@"失效信息"];
//    _contentArr = @[@[@"申诉类型：规定时间内未判断房源真实性申诉",@"申诉时间：2017-10-23  19:00:00",@"申诉描述：***************************"],@[@"失效类型：业主不售房源",@"失效时间：2017-10-23  19:00:00",@"失效描述：***************************"],@[@"抢单时间：2017-10-23  19:00:00",@"经纪人：李四",@"联系电话：13932452456"],@[@"天鹅湖小区",@"房源编号：CD - TEH - 20170810 - 1（F）",@"归属门店：MDBHNO1",@"联系人：李四",@"性别：男",@"身份证号：5130291556231203",@"联系电话：13932452456",@"与业主关系：业主本人",@"报备时间：2017-10-23  19:00:00",@"备注：**********************"]];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseRecordAppealDetail_URL parameters:@{@"appeal_id":_appealId} success:^(id resposeObject) {
        
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
    
    _status = data[@"appeal_solve_info"];
    _contentArr = @[@[[NSString stringWithFormat:@"申诉类型：%@",data[@"appeal_type"]],[NSString stringWithFormat:@"申诉时间：%@",data[@"appeal_time"]],[NSString stringWithFormat:@"申诉描述：%@",data[@"appeal_comment"]]],@[[NSString stringWithFormat:@"%@",data[@"house"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",data[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",data[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",data[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"抢单时间：%@",data[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",data[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"agent_tel"]]],@[[NSString stringWithFormat:@"失效类型：%@",data[@"disabled_state"]],[NSString stringWithFormat:@"失效时间：%@",data[@"disabled_time"]],[NSString stringWithFormat:@"失效描述：%@",data[@"disabled_reason"]]]];
    
    [_detailTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _contentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
        if (!header) {
            
            header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
        }
        
        header.titleL.text = _titleArr[section];
        if ([_status isEqualToString:@"处理完成"]) {
            
            [header.moreBtn setTitle:@"处理完成" forState:UIControlStateNormal];
            [header.moreBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];

        }else{
            
            [header.moreBtn setTitle:@"处理中" forState:UIControlStateNormal];
            [header.moreBtn setTitleColor:COLOR(255, 168, 0, 1) forState:UIControlStateNormal];
        }
        header.lineView.hidden = YES;
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        header.titleL.text = _titleArr[section];
        header.lineView.hidden = YES;
        
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lineView.hidden = YES;
    
    cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"申诉详情";
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

@end
