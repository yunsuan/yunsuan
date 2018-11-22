//
//  RentingSurveyFailDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyFailDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface RentingSurveyFailDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *complaintBtn;

@end

@implementation RentingSurveyFailDetailVC

-  (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"失效信息",@"抢单信息",@"报备信息"];
    _contentArr = @[@[@"失效类型：规定时间内未判断房源真实性申诉",@"失效时间：2017-10-23  19:00:00",@"失效描述：***************************"],@[@"抢单时间：2017-10-23  19:00:00",@"经纪人：张三",@"联系电话：18745561223",@"房源真实性判断失效倒计时："],@[@"天鹅湖小区 - 17栋 - 2单元 - 103",@"房源编号：CD - TEH - 20170810 - 1（F）",@"归属门店：MDBHNO1",@"联系人：李四",@"性别：男",@"身份证号：5130291556231203",@"联系电话：13932452456",@"与业主关系：业主本人",@"报备时间：2017-10-23  19:00:00",@"备注：**********************"]];
    [self initUI];
}

- (void)ActionComplaintBtn:(UIButton *)btn{
    
//    ReportFailComplaintVC *nextVC = [[ReportFailComplaintVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)refresh{
    
    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return [_contentArr[section] count];
    }else{
        
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = _titleArr[section];
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
    
    self.titleLabel.text = @"勘察失效详情";
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
    _complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_complaintBtn addTarget:self action:@selector(ActionComplaintBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_complaintBtn setTitle:@"申诉" forState:UIControlStateNormal];
    [_complaintBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    [_complaintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_complaintBtn];
    
}

@end
