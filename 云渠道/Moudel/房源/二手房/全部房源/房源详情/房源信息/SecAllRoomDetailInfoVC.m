//
//  SecAllRoomDetailInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomDetailInfoVC.h"

#import "BaseHeader.h"
#import "TitleContentBaseCell.h"

@interface SecAllRoomDetailInfoVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_titleArr;
//    NSArray *_contentArr;
//    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *overTable;

@end

@implementation SecAllRoomDetailInfoVC

- (instancetype)initWithDataDic:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
//        _dataDic = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@[@"挂牌价格",@"单价",@"收款方式",@"产权所有",@"抵押信息",@"产权年限",@"看房方式",@"卖房意愿度",@"卖房急迫度"],@[@"产权编号",@"拿证时间",@"房源编号",@"小区地址",@"房号",@"物业类型",@"房型",@"产权面积",@"朝向",@"梯户比",@"楼层类型",@"楼层",@"建成年代",@"装修"]];
//    _contentArr = @[@[@"挂牌价格",@"单价",@"收款方式",@"产权所有",@"抵押信息",@"产权年限",@"看房方式",@"卖房意愿度",@"卖房急迫度"],@[@"产权编号",@"拿证时间",@"房源编号",@"小区地址",@"房号",@"物业类型",@"房型",@"产权面积",@"朝向",@"梯户比",@"楼层类型",@"楼层",@"建成年代",@"装修"]];
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
