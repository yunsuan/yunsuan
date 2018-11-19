//
//  RoomSurveyFailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomSurveyFailVC.h"
#import "SurveyFailDetailVC.h"

#import "RoomSurveyFailCell.h"

@interface RoomSurveyFailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}
@property (nonatomic, strong) UITableView *failTable;

@end

@implementation RoomSurveyFailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"SurveyInvlid" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _failTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:HouseSurveyDisabled_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {
                
                [_failTable.mj_header endRefreshing];
                [self SetData:resposeObject[@"data"]];
                
            }else{
                
                [_failTable.mj_header endRefreshing];
                _failTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_failTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
        [_failTable reloadData];
    } failure:^(NSError *error) {
        
        [_failTable.mj_footer endRefreshing];
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:HouseSurveyDisabled_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [_failTable.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"]];
            }else{
                
                _failTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [_failTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_failTable.mj_footer endRefreshing];
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    [_dataArr addObjectsFromArray:data];
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }else{
                
                [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        [_dataArr replaceObjectAtIndex:i withObject:tempDic];
    }
    
    [_failTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomSurveyFailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomSurveyFailCell"];
    if (!cell) {
        
        cell = [[RoomSurveyFailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomSurveyFailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
//    cell.nameL.text = @"张三";
//    cell.roomL.text = @"天鹅湖小区 - 17栋 - 2单元 - 103";
//    cell.codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
//    cell.statusL.text = @"他人";
//    cell.timeL.text = @"失效日期：2017-12-15  13:00:00";
//    cell.typeL.text = @"失效类型：规定时间内未判断房源真实性申诉";

    cell.roomSurveyFailPhoneBlock = ^(NSInteger index) {
        
        //        NSString *phone = [_validArr[index][@"tel"] componentsSeparatedByString:@","][0];
        NSString *phone = _dataArr[index][@"tel"];
        if (phone.length) {
            
            //获取目标号码字符串,转换成URL
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:url];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SurveyFailDetailVC *nextVC = [[SurveyFailDetailVC alloc] initWithSurveyId:_dataArr[indexPath.row][@"survey_id"]];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _failTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE) style:UITableViewStylePlain];
    
    _failTable.rowHeight = UITableViewAutomaticDimension;
    _failTable.estimatedRowHeight = 87 *SIZE;
    _failTable.backgroundColor = self.view.backgroundColor;
    _failTable.delegate = self;
    _failTable.dataSource = self;
    _failTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_failTable];
    
    WS(weakSelf);
    _failTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf RequestMethod];
    }];
    
    _failTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [weakSelf RequestAddMethod];
    }];
}

@end
