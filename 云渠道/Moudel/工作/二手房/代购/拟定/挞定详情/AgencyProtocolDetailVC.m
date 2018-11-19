//
//  AgencyProtocolDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AgencyProtocolDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface AgencyProtocolDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
    NSDictionary *_subDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation AgencyProtocolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"交易信息",@"客户信息",@"房源信息",@"挞定信息"];
    _contentArr = @[@[@"交易编号："],@[@"推荐编号：",@"客户名称：",@"性别：",@"联系电话："],@[@"房源编号：",@"",@"批次："],@[@"挞定类型:",@"违约金:",@"挞定描述:",@"登记时间:"]];
    
    [BaseRequest GET:BreachDetail_URL parameters:@{@"sub_id":_sub_id} success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue]==200) {
            _subDic = resposeObject[@"data"];
            NSString *sex = @"性别：";
            if ([_subDic[@"sex"] integerValue]==1) {
                sex = @"性别：男";
            }
            if ([_subDic[@"sex"] integerValue]==2) {
                sex = @"性别：女";
            }
            _contentArr =@[@[[NSString stringWithFormat:@"交易编号：%@",_subDic[@"sub_code"]]],@[@"推荐编号：？？？？？？",[NSString stringWithFormat:@"交易编号：%@",_subDic[@"name"]],sex,[NSString stringWithFormat:@"联系方式：%@",_subDic[@"tel"]]],@[[NSString stringWithFormat:@"房源编号：%@",_subDic[@"house_code"]],[NSString stringWithFormat:@"小区信息：%@",_subDic[@"project_name"]],[NSString stringWithFormat:@"批次：%@",_subDic[@"house_info"]]],@[[NSString stringWithFormat:@"挞定类型：%@",_subDic[@"disabled_state"]],[NSString stringWithFormat:@"违约金：%@",_subDic[@"break_num"]],[NSString stringWithFormat:@"挞定描述：%@",_subDic[@"disabled_reason"]],[NSString stringWithFormat:@"登记时间：%@",_subDic[@"regist_time"]]]];
            [_table reloadData];
        }
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.lineView.hidden = YES;
    header.titleL.text = _titleArr[section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 4 *SIZE;
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
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"挞定详情";
    
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
