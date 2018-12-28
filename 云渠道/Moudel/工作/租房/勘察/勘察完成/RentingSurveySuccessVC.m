//
//  RentingSurveySuccessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveySuccessVC.h"
#import "RentingMaintainDetailVC.h"

#import "RoomSurveySuccessCell.h"

@interface RentingSurveySuccessVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation RentingSurveySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"comleteSurvey" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _mainTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:RentSurveyFinish_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {
                
                [_mainTable.mj_header endRefreshing];
                [self SetData:resposeObject[@"data"]];
                
            }else{
                

                [_mainTable.mj_header endRefreshing];
                _mainTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_mainTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
        [_mainTable reloadData];
    } failure:^(NSError *error) {
        
        [_mainTable.mj_footer endRefreshing];
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
    [BaseRequest GET:RentSurveyFinish_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [_mainTable.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"]];
            }else{
                
                _mainTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [_mainTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_mainTable.mj_footer endRefreshing];
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
    
    [_mainTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomSurveySuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomSurveySuccessCell"];
    if (!cell) {
        
        cell = [[RoomSurveySuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomSurveySuccessCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.roomSurveSuccessPhoneBlock = ^(NSInteger index) {
        
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
    
//    RoomMaintainModel *model = _dataArr[indexPath.row];
    RentingMaintainDetailVC *nextVC = [[RentingMaintainDetailVC alloc] initWithSurveyId:_dataArr[indexPath.row][@"survey_id"] houseId:_dataArr[indexPath.row][@"house_id"] type:[_dataArr[indexPath.row][@"type"] integerValue]];
    nextVC.edit = [_dataArr[indexPath.row][@"edit"] integerValue] ? YES:NO;
    nextVC.rentingMaintainDetailVCBlock = ^{
        
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 87 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
    _mainTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    
    _mainTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}

@end
