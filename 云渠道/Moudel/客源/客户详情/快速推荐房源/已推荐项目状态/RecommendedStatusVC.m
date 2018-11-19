//
//  RecommendedStatusVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendedStatusVC.h"
#import "ReStatusTableCell.h"

@interface RecommendedStatusVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *reStatusTable;

@end

@implementation RecommendedStatusVC

- (instancetype)initWithData:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [NSMutableArray arrayWithArray:dataArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initDataSource];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReStatusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReStatusTableCell"];
    if (!cell) {
        
        cell = [[ReStatusTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReStatusTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.dataDic = _dataArr[indexPath.section];
//    cell.titleL.text = _dataArr[indexPath.row][@"project_name"];
    
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"已推荐项目状态";
    

    _reStatusTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _reStatusTable.rowHeight = UITableViewAutomaticDimension;
    _reStatusTable.estimatedRowHeight = 113 *SIZE;
    _reStatusTable.backgroundColor = self.view.backgroundColor;
    _reStatusTable.delegate = self;
    _reStatusTable.dataSource = self;
    _reStatusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_reStatusTable];
}

@end
