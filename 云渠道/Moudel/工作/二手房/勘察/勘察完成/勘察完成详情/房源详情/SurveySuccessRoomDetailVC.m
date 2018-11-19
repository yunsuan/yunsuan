//
//  SurveySuccessRoomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveySuccessRoomDetailVC.h"

#import "SingleContentCell.h"

@interface SurveySuccessRoomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_contentArr;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation SurveySuccessRoomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = @[@"产权编号：NJKFVDFJKLM VL",@"拿证时间：2018-03-20",@"小区地址：郫都区大禹东路94号 云算公馆",@"物业类型：住宅",@"房号：1批次1楼栋1单元102",@"户型：2室1厅1卫",@"产权面积：80㎡",@"朝向：东南",@"年代：2015"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _contentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = YJBackColor;
    cell.contentL.text = _contentArr[indexPath.row];
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房源信息";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 31 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}
@end
