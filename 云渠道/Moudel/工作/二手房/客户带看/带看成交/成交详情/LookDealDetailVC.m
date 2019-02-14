//
//  LookDealDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookDealDetailVC.h"

#import "BaseHeader.h"
#import "RoomBrokerageTableHeader.h"
#import "SingleContentCell.h"
#import "BrokerageDetailTableCell3.h"

@interface LookDealDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_lookId;
    NSMutableArray *_proArr;
    NSArray *_Pace;
    NSArray *_contentArr;
}

@property (nonatomic, strong) UITableView *detailTable;
@end

@implementation LookDealDetailVC

- (instancetype)initWithLookId:(NSString *)lookId
{
    self = [super init];
    if (self) {
        
        _lookId = lookId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArr = @[@"推荐信息",@"接单信息",@"完成信息"];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    
//    _processArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:RecommendButterFinishDetail_URL parameters:@{@"take_id":_lookId} success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self SetData:resposeObject[@"data"]];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _contentArr = @[@[[NSString stringWithFormat:@"客源编号：%@",data[@"take_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"变更时间：%@",data[@"disabled_time"]],[NSString stringWithFormat:@"当前状态：%@",data[@"disabled_state"]]]];
    
    [_detailTable reloadData];
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
    
    header.titleL.text = _titleArr[section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
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
    self.titleLabel.text = @"完成详情";
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
}

@end
