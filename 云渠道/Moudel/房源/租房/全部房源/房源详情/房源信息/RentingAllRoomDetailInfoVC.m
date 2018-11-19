//
//  RentingAllRoomDetailInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/1.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingAllRoomDetailInfoVC.h"

#import "BaseHeader.h"
#import "TitleContentBaseCell.h"

@interface RentingAllRoomDetailInfoVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_titleArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) UITableView *overTable;

@end

@implementation RentingAllRoomDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@[@"出租价格",@"付款方式",@"租赁类型",@"最短租期",@"最长租期",@"看房方式",@"入住时间"],@[@"物业类型",@"房源编号",@"小区地址",@"房号",@"房型",@"产权面积",@"朝向",@"楼层",@"装修",@"电梯"]];
    _contentArr = @[@[@"出租价格",@"付款方式",@"租赁类型",@"最短租期",@"最长租期",@"看房方式",@"入住时间"],@[@"物业类型",@"房源编号",@"小区地址",@"房号",@"房型",@"产权面积",@"朝向",@"楼层",@"装修",@"电梯"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    if (section == 0) {
        
        header.titleL.text = @"挂牌信息";
    }else{
        
        header.titleL.text = @"房源信息";
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"TitleContentBaseCell";
    
    TitleContentBaseCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setTitle:_titleArr[indexPath.section][indexPath.row] content:_titleArr[indexPath.section][indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房源信息";
    
    _overTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _overTable.rowHeight = UITableViewAutomaticDimension;
    _overTable.estimatedRowHeight = 43 *SIZE;
    _overTable.backgroundColor = self.view.backgroundColor;
    _overTable.delegate = self;
    _overTable.dataSource = self;
    _overTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_overTable];
}

@end
