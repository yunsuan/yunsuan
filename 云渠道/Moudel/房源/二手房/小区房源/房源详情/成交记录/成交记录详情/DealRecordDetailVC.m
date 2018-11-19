//
//  DealRecordDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DealRecordDetailVC.h"

#import "BaseHeader.h"
#import "SingleContentCell.h"

@interface DealRecordDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation DealRecordDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"成交信息",@"房源信息"];
    _contentArr = [[NSMutableArray alloc] initWithArray:@[@[@"成交时间：2017-10-23  19:00:00",@"成交单价：16888元/平米",@"成交总价：120万",@"过户经纪人：李四",@"带看经纪人：张三",@"勘察经纪人：李刚",@"推荐经纪人：陈坤",@"报备经纪人：刘强"],@[@"房源编号：CD - TEH - 20170810 - 1（F）",@"所属小区：成都市 郫都区 大禹东路198号",@"房号：1批次 1栋 1单元 102",@"建筑面积：103m2"]]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6 *SIZE;
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
    self.titleLabel.text = @"成交详情";
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 30 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 40 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_table];
}

@end
