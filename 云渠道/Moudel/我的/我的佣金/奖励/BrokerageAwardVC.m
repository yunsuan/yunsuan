//
//  BrokerageAwardVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BrokerageAwardVC.h"

#import "BrokerageAwardCell.h"

@interface BrokerageAwardVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_title;
}

@property (nonatomic, strong) UITableView *mainTable;
@end

@implementation BrokerageAwardVC

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        
        _title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrokerageAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrokerageAwardCell"];
    if (!cell) {
        
        cell = [[BrokerageAwardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrokerageAwardCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.nameL.text = @"张三";
//    cell.phoneL.text = @"15983804766";
//    cell.priceL.text = @"￥20";
//    cell.timeL.text = @"2018-02-10";
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = _title;
    self.navBackgroundView.hidden = NO;
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 67 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}

@end
