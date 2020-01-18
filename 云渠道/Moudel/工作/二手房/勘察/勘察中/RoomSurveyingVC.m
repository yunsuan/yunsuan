//
//  RoomSurveyingVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomSurveyingVC.h"
#import "SurveyingDetailVC.h"
#import "SurveyInvalidVC.h"
#import "CompleteSurveyInfoVC.h"
#import "RoomReportAddVC.h"

#import "RoomSurveyingCell.h"

@interface RoomSurveyingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}
@property (nonatomic, strong) UITableView *waitTable;


@end

@implementation RoomSurveyingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"secReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"RoomSurveying" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"SurveyInvlid" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _waitTable.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:HouseSurveyUnderWay_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            if ([resposeObject[@"data"] count]) {
                
                [_waitTable.mj_header endRefreshing];
                [self SetData:resposeObject[@"data"]];
                
            }else{
                
                [_waitTable.mj_header endRefreshing];
                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [_waitTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
        [_waitTable reloadData];
    } failure:^(NSError *error) {
        
        [_waitTable.mj_footer endRefreshing];
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
    [BaseRequest GET:HouseSurveyUnderWay_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [_waitTable.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"]];
            }else{
                
                _waitTable.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            _page -= 1;
            [_waitTable.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _page -= 1;
        [_waitTable.mj_footer endRefreshing];
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }else{
                
                [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_waitTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomSurveyingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomSurveyingCell"];
    if (!cell) {
        
        cell = [[RoomSurveyingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomSurveyingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];

    
    cell.roomSyrveyingConfirmBlock = ^(NSInteger index) {
        
        [BaseRequest GET:HouseCapacityCheck_URL parameters:@{@"project_id":_dataArr[index][@"project_id"]} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if ([resposeObject[@"data"] integerValue] == 1) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认房源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"完成勘察信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        if ([self->_dataArr[indexPath.row][@"is_from_home"] integerValue] == 1) {
                            
                            RoomReportAddVC *nextVC = [[RoomReportAddVC alloc] init];
                            nextVC.status = @"zhiyejia";
                            nextVC.homeDic = self->_dataArr[indexPath.row];
                            nextVC.roomReportAddHouseBlock = ^(NSDictionary *dic) {
                                
                                [self RequestMethod];
                            };
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else{
                            
                            CompleteSurveyInfoVC *nextVC = [[CompleteSurveyInfoVC alloc] initWithTitle:@"完成勘察信息"];
                            nextVC.completeSurveyInfoVCBlock = ^{
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"comleteSurvey" object:nil];
                                [self RequestMethod];
                                if (self.roomSurveyingBlock) {
                                    
                                    self.roomSurveyingBlock();
                                }
                            };
                            nextVC.dataDic = _dataArr[index];
                            nextVC.surveyId = _dataArr[index][@"survey_id"];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }
                        
                    }];
                    
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"勘察失效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        SurveyInvalidVC *nextVC = [[SurveyInvalidVC alloc] initWithData:_dataArr[index]];
                        nextVC.surveyId = _dataArr[index][@"survey_id"];
                        nextVC.surveyInvalidVCBlock = ^{
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"SurveyInvlid" object:nil];
                            [self RequestMethod];
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
                    
                    [alert addAction:valid];
                    [alert addAction:invalid];
                    [alert addAction:cancel];
                    [self.navigationController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"您当前没有勘察权限，请联系门店负责人"];
                }
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"您当前没有勘察权限，请联系门店负责人"];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    };
    
    cell.roomSurveyingPhoneBlock = ^(NSInteger index) {
        
        NSString *phone = [_dataArr[index][@"tel"] componentsSeparatedByString:@","][0];
//        NSString *phone = _dataArr[index][@"tel"];
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
    
    SurveyingDetailVC *nextVC = [[SurveyingDetailVC alloc] initWithSurveyId:_dataArr[indexPath.row][@"survey_id"]];
    nextVC.surveyingDetailVCBlock = ^{
      
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SurveyInvlid" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"comleteSurvey" object:nil];
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    _waitTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE) style:UITableViewStylePlain];
    
    _waitTable.rowHeight = UITableViewAutomaticDimension;
    _waitTable.estimatedRowHeight = 87 *SIZE;
    _waitTable.backgroundColor = self.view.backgroundColor;
    _waitTable.delegate = self;
    _waitTable.dataSource = self;
    _waitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_waitTable];
    
    WS(weakSelf);
    _waitTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf RequestMethod];
    }];
    
    _waitTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [weakSelf RequestAddMethod];
    }];
}

@end
