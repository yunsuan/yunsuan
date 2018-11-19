//
//  MaintainFollowDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainFollowDetailVC.h"

#import "BaseHeader.h"
#import "SingleContentCell.h"

@interface MaintainFollowDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSString *_timeStr;
}

@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation MaintainFollowDetailVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        NSLog(@"%@",dataDic);
        _timeStr = dataDic[@"next_visit_time"];
        _dataArr = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"跟进时间：%@",dataDic[@"follow_time"]],[NSString stringWithFormat:@"跟进方式：%@",dataDic[@"check_way"]],[NSString stringWithFormat:@"挂牌标题：%@",dataDic[@"title"]],[NSString stringWithFormat:@"看房方式：%@",dataDic[@"check_way"]],[NSString stringWithFormat:@"挂牌价格：%@",dataDic[@"price"]],[NSString stringWithFormat:@"出售底价：%@",dataDic[@"minimum"]],[NSString stringWithFormat:@"卖房意愿度：%@",dataDic[@"intent"]],[NSString stringWithFormat:@"买房急迫度：%@",dataDic[@"urgency"]],[NSString stringWithFormat:@"跟进内容：%@",dataDic[@"comment"]]]];
        if ([dataDic[@"pay_way"] count]) {
            
            [_dataArr insertObject:[NSString stringWithFormat:@"收款方式：%@",dataDic[@"pay_way"][0]] atIndex:6];
        }else{
            
            [_dataArr insertObject:[NSString stringWithFormat:@"收款方式：%@",@"暂无数据"] atIndex:6];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count?1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = [NSString stringWithFormat:@"下次回访时间：%@",_timeStr];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
    if (!cell) {
        
        cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _dataArr[indexPath.row];
    cell.lineView.hidden = YES;
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _mainTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedSectionHeaderHeight = 50 *SIZE;
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 40 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
}


@end
