//
//  LookMaintainDetailLookRecordSingleVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailLookRecordSingleVC.h"

#import "BaseHeader.h"
#import "SingleContentCell.h"

@interface LookMaintainDetailLookRecordSingleVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_houseTakeFollowId;
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation LookMaintainDetailLookRecordSingleVC

- (instancetype)initWithHouseTakeFollowId:(NSString *)houseTakeFollowId
{
    self = [super init];
    if (self) {
        
        _houseTakeFollowId = houseTakeFollowId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:TakeMaintainHouseDetail_URL parameters:@{@"house_take_follow_id":_houseTakeFollowId} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _dataArr = @[[NSString stringWithFormat:@"意向度：%@",data[@"intent"]],[NSString stringWithFormat:@"带看时间：%@",data[@"take_time"]],[NSString stringWithFormat:@"带看人数：%@",data[@"take_visit_num"]],[NSString stringWithFormat:@"客户中意点：%@",data[@"client_like"]],[NSString stringWithFormat:@"客户抗性：%@",data[@"client_dislike"]],[NSString stringWithFormat:@"是否出价：%@",[data[@"price"] integerValue] == 0 ? @"否":@"是"],[NSString stringWithFormat:@"出价金额：%@",data[@"price"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"pay_way"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"附带看：%@",data[@"attach_agent"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]];
    [_table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    
    header.titleL.text = @"带看信息";
    
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
    self.titleLabel.text = @"带看信息";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}
@end
