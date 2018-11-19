//
//  SurveySuccessOwnerDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveySuccessOwnerDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface SurveySuccessOwnerDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_contentArr;
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation SurveySuccessOwnerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"业主信息1",@"业主信息2"];
    _contentArr = @[@[@"姓名：张三",@"类型：主权益人",@"联系号码1：18745561223",@"联系号码2：18745561223",@"证件类型：身份证",@"证件号：513029199412535"],@[@"姓名：张三",@"类型：主权益人",@"联系号码1：18745561223",@"联系号码2：18745561223",@"证件类型：身份证",@"证件号：513029199412535"]];
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
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.contentView.backgroundColor = COLOR(249, 249, 249, 1);
    header.titleL.text = _titleArr[section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5 *SIZE;
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
    cell.contentView.backgroundColor = COLOR(249, 249, 249, 1);
    cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
    cell.lineView.hidden = YES;
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"业主信息";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 31 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}
@end
