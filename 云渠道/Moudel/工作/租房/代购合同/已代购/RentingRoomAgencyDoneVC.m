//
//  RentingRoomAgencyDoneVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingRoomAgencyDoneVC.h"
#import "RentingAgencyDoneDetailVC.h"

#import "RoomAgencyDoneCell.h"

@interface RentingRoomAgencyDoneVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingRoomAgencyDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomAgencyDoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyDoneCell"];
    if (!cell) {
        
        cell = [[RoomAgencyDoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyDoneCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.roomCodeL.text = @"房源编号：DSBNS1623266320";
    cell.recommendL.text = @"推荐编号：SAF4535654316652";
    cell.tradeCodeL.text = @"交易编号：SAF4535654316652";
    cell.agentL.text = @"代办人：张三";
    cell.timeL.text = @"登记日期：2017-02-23 12:23";
    cell.validL.text = @"有效";
    cell.auditL.text = @"已审核";
    cell.payL.text = @"已收款";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RentingAgencyDoneDetailVC *nextVC = [[RentingAgencyDoneDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
