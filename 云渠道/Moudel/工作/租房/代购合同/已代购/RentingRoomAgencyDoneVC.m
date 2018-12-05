//
//  RentingRoomAgencyDoneVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingRoomAgencyDoneVC.h"
#import "RentingAgencyDoneDetailVC.h"

#import "RoomAgencyDoneCell.h"

@interface RentingRoomAgencyDoneVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArr;
    NSString *_page;
    //    NSString *_content;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation RentingRoomAgencyDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SearchMethod:) name:@"protocolSearch" object:nil];
    _dataArr = @[];
    _page =@"1";
    [self postWithpage:_page];
}

- (void)SearchMethod:(NSNotification *)noti{
    
    //    _content = noti.userInfo[@"content"];
    [self postWithpage:_page];
}

-(void)postWithpage:(NSString *)page{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":page}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:PurchaseContractList_URL parameters:dic success:^(id resposeObject) {
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
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomAgencyDoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomAgencyDoneCell"];
    if (!cell) {
        
        cell = [[RoomAgencyDoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomAgencyDoneCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.validL.hidden = YES;;
    cell.auditL.hidden = YES;;
    cell.payL.hidden = YES;;
    
    cell.roomCodeL.text = [NSString stringWithFormat:@"房源编号：%@",_dataArr[indexPath.row][@"house_code"]];
    cell.recommendL.text = @"推荐编号：";
    cell.tradeCodeL.text = [NSString stringWithFormat:@"交易编号：%@",_dataArr[indexPath.row][@"sub_code"]];
    cell.agentL.text = [NSString stringWithFormat:@"代办人：%@",_dataArr[indexPath.row][@"agent_name"]];
    cell.timeL.text = [NSString stringWithFormat:@"登记日期：%@",_dataArr[indexPath.row][@"regist_time"]];
    if ([_dataArr[indexPath.row][@"check_state"] integerValue] == 1) {
        
        [cell.validL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(10 *SIZE);
            make.top.equalTo(cell.timeL.mas_bottom).offset(7 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
            make.height.mas_equalTo(17 *SIZE);
        }];
        
        [cell.auditL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.validL.mas_right).offset(5 *SIZE);
            make.top.equalTo(cell.timeL.mas_bottom).offset(7 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
            make.height.mas_equalTo(17 *SIZE);
        }];
        cell.validL.hidden = YES;
        cell.auditL.hidden = NO;
        //        cell.validL.text = @"有效";
        cell.auditL.text = @"已审核";
    }else if ([_dataArr[indexPath.row][@"check_state"] integerValue] == 2){
        
        cell.auditL.hidden = NO;;
        
        [cell.auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(10 *SIZE);
            make.top.equalTo(cell.timeL.mas_bottom).offset(7 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
            make.height.mas_equalTo(17 *SIZE);
        }];
        cell.validL.text = @"";
        cell.auditL.text = @"未审核";
        cell.payL.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RentingAgencyDoneDetailVC *nextVC = [[RentingAgencyDoneDetailVC alloc] init];
    nextVC.sub_id = _dataArr[indexPath.row][@"sub_id"];
    nextVC.rentingAgencyDoneDetailVCBlock = ^{

        if (self.rentingRoomAgencyDoneVCBlock) {

            self.rentingRoomAgencyDoneVCBlock();
        }
    };
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
