//
//  SignListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SignListVC.h"

#import "BrokerageDetailTableCell3.h"

@interface SignListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation SignListVC

- (instancetype)initWithDataArr:(NSArray *)data
{
    self = [super init];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        _dataArr = [NSMutableArray arrayWithArray:data];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrokerageDetailTableCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageDetailTableCell3"];
    if (!cell) {
        
        cell = [[BrokerageDetailTableCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageDetailTableCell3"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"确认流程";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    
    [self.view addSubview:_table];
}

@end
