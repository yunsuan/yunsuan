//
//  RentingMaintainRoomInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingMaintainRoomInfoVC.h"

#import "BaseHeader.h"
#import "SingleContentCell.h"
#import "BrokerageDetailTableCell3.h"

@interface RentingMaintainRoomInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_contentArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingMaintainRoomInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = @[@"房屋所有权证号:65623665562632",@"小区地址：郫都区大禹东路94号 云算公馆",@"出租价格：500月/平",@"物业类型：住宅",@"户型：二室二厅",@"收款方式：押一付三",@"租赁类型：合租",@"最短租期：一个月",@"最长租期：无限",@"入住时间：2018-10-01",@"楼层：18",@"朝向：南",@"装修：简装",@"电梯：有",@"出租意愿度：45",@"出租急迫度：45"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _contentArr.count;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    
    header.titleL.text = @"房源编号：SCCDPDHPXQ-0302102";
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
        if (!cell) {
            cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = @"报备  ——  报备时间：2017-10-08 18:00";
        if (indexPath.row == 0) {
            
            cell.upLine.hidden = YES;
        }else{
            
            cell.upLine.hidden = NO;
        }
        if (indexPath.row == 3) {
            
            cell.downLine.hidden = YES;
        }else{
            
            cell.downLine.hidden = NO;
        }
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = _contentArr[indexPath.row];
        cell.lineView.hidden = YES;
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"房源信息";
    self.navBackgroundView.hidden = NO;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.estimatedRowHeight = 50 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
