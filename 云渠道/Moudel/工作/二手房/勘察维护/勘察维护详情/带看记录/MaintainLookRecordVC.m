//
//  MaintainLookRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainLookRecordVC.h"

#import "MaintainLookCell.h"
#import "MaintainLookHeader.h"

@interface MaintainLookRecordVC ()<UITableViewDataSource,UITableViewDelegate>
//{
//
//    NSArray *_titleArr;
//}
@property (nonatomic, strong) UITableView *table;

@end

@implementation MaintainLookRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return UITableViewAutomaticDimension;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MaintainLookHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MaintainLookHeader"];
    if (!header) {
        
        header = [[MaintainLookHeader alloc] initWithReuseIdentifier:@"MaintainLookHeader"];
    }
    
    header.numL.text = @"3";
    header.allL.text = @"6";
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintainLookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainLookCell"];
    if (!cell) {
        
        cell = [[MaintainLookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaintainLookCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.timeL.text = @"2018.03.12";
    cell.priceL.text = @"89万";
    cell.agentL.text = @"张三";
    cell.tag = indexPath.row;
    
    cell.maintainLookBlock = ^(NSInteger index) {
        
    };
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"带看记录";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 107 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
