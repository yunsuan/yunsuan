//
//  RentingRoomAgencyCancelVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingRoomAgencyCancelVC.h"
#import "AgencyProtocolDetailVC.h"

#import "RoomAgencyProtocolCell.h"

@interface RentingRoomAgencyCancelVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArr;
    NSString *_page;
    //    NSString *_content;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingRoomAgencyCancelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouse];
    [self initUI];
}

-(void)initDataSouse
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SearchMethod:) name:@"protocolbreakSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"AgencyProtocol" object:nil];
    _dataArr =@[];
    _page =@"1";
    [self postWithpage:_page];
}

- (void)SearchMethod:(NSNotification *)noti{
    
    //    _content = noti.userInfo[@"content"];
    [self postWithpage:_page];
}

- (void)RequestMethod{
    
    _page = @"1";
    [self postWithpage:_page];
}

-(void)postWithpage:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":page}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:BreachList_URL parameters:dic success:^(id resposeObject) {
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] ==200) {
            if ([page integerValue]==1) {
                _dataArr = resposeObject[@"data"][@"data"];
                if ([resposeObject[@"data"][@"total"] integerValue]==0||[resposeObject[@"data"][@"total"] integerValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _table.mj_footer.state = MJRefreshStateNoMoreData;
                    });
                    
                }
            }else
            {
                _dataArr = [_dataArr arrayByAddingObjectsFromArray:resposeObject[@"data"][@"data"]];
                if ([_page integerValue]>=[resposeObject[@"data"][@"total"] integerValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _table.mj_footer.state = MJRefreshStateNoMoreData;
                    });
                }
            }
            [_table reloadData];
        }
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomAgencyProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyProtocolCell"];
    if (!cell) {
        
        cell = [[RoomAgencyProtocolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyProtocolCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.validL.hidden = YES;;
    cell.auditL.hidden = YES;;
    
    cell.roomCodeL.text = [NSString stringWithFormat:@"房源编号：%@",_dataArr[indexPath.row][@"house_code"]];
    //    cell.recommendL.text = @"推荐编号：？？？？？？";
    cell.tradeCodeL.text = [NSString stringWithFormat:@"交易编号：%@",_dataArr[indexPath.row][@"sub_code"]];
    cell.typeL.text = [NSString stringWithFormat:@"挞定类型：%@",_dataArr[indexPath.row][@"disabled_state"]];
    cell.timeL.text = [NSString stringWithFormat:@"登记日期：%@",_dataArr[indexPath.row][@"regist_time"]];
    
    //    [cell.payL mas_remakeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(cell.contentView).offset(10 *SIZE);
    //        make.top.equalTo(cell.timeL.mas_bottom).offset(7 *SIZE);
    //        make.width.mas_equalTo(40 *SIZE);
    //        make.height.mas_equalTo(17 *SIZE);
    //    }];
    cell.payL.text = @"已失效";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgencyProtocolDetailVC *nextVC = [[AgencyProtocolDetailVC alloc] init];
    nextVC.sub_id = _dataArr[indexPath.row][@"sub_id"];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.mj_header= [GZQGifHeader headerWithRefreshingBlock:^{
        _page =@"1";
        [self postWithpage:_page];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        NSInteger i = [_page integerValue];
        i++;
        [self postWithpage:[NSString stringWithFormat:@"%ld",(long)i]];
    }];
    [self.view addSubview:_table];
}

@end
