//
//  PerformanceContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PerformanceContractVC.h"

#import "BaseHeader.h"
#import "PerformanceContractCell.h"

@interface PerformanceContractVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_dataArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation PerformanceContractVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = [NSString stringWithFormat:@"业绩金额：%@",self.money];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PerformanceContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerformanceContractCell"];
    if (!cell) {
        
        cell = [[PerformanceContractCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerformanceContractCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.typeL.text = @"分配类型";
        cell.salemanL.text = @"业务员";
        cell.propertyL.text = @"分配比例（%）";
        cell.moneyL.text = @"分配金额（元）";
        cell.storeL.text = @"所属门店";
        
        cell.contentView.backgroundColor = YJBlueBtnColor;
        cell.typeL.textColor = CLWhiteColor;
        cell.salemanL.textColor = CLWhiteColor;
        cell.propertyL.textColor = CLWhiteColor;
        cell.moneyL.textColor = CLWhiteColor;
        cell.storeL.textColor = CLWhiteColor;
    }else{
        
        cell.typeL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"area_name"]];
        cell.salemanL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"agent_name"]];
        cell.propertyL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"proportion"]];
        cell.moneyL.text = [NSString stringWithFormat:@"%.2f",[self MultiplyingNumber:[_dataArr[indexPath.row - 1][@"proportion"] doubleValue] num2:[self.money doubleValue]] / 100];
        cell.storeL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"store_name"]];
        
        cell.contentView.backgroundColor = CLWhiteColor;
        cell.typeL.textColor = YJContentLabColor;
        cell.salemanL.textColor = YJContentLabColor;
        cell.propertyL.textColor = YJContentLabColor;
        cell.moneyL.textColor = YJContentLabColor;
        cell.storeL.textColor = YJContentLabColor;
    }
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"业绩分佣";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
