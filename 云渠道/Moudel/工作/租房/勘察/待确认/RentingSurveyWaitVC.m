//
//  RentingSurveyWaitVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingSurveyWaitVC.h"
#import "RentingSurveyWaitDetailVC.h"
#import "RentingInvalidApplyVC.h"
#import "RentingValidApplyVC.h"

#import "RoomSurveyWaitCell.h"

@interface RentingSurveyWaitVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}
@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation RentingSurveyWaitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"secReload" object:nil];
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
    [BaseRequest GET:RentSurveyWaitConfirm_URL parameters:dic success:^(id resposeObject) {
        
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
    [BaseRequest GET:RentSurveyWaitConfirm_URL parameters:dic success:^(id resposeObject) {
        
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
    
    RoomSurveyWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomSurveyWaitCell"];
    if (!cell) {
        
        cell = [[RoomSurveyWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomSurveyWaitCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.roomSyrveyWaitComfirmBlock = ^(NSInteger index) {
        
        [BaseRequest GET:HouseCapacityCheck_URL parameters:@{@"project_id":_dataArr[index][@"project_id"]} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if ([resposeObject[@"data"] integerValue] == 1) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认房源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"房源有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        RentingValidApplyVC *nextVC = [[RentingValidApplyVC alloc] initWithData:_dataArr[index] SurveyId:_dataArr[index][@"survey_id"]];
                        nextVC.rentingValidApplyVCBlock = ^{
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"RoomSurveying" object:nil];
                            [self RequestMethod];
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
                    
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"房源无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        RentingInvalidApplyVC *nextVC = [[RentingInvalidApplyVC alloc] initWithData:_dataArr[index] SurveyId:_dataArr[index][@"survey_id"]];
                        nextVC.rentingInvalidApplyVCBlock = ^{
                            
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

    
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
//    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
//    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
//    cell.phoneL.attributedText = attr;
    cell.roomSurveyWaitPhoneBlock = ^(NSInteger index) {
        
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
    
    RentingSurveyWaitDetailVC *nextVC = [[RentingSurveyWaitDetailVC alloc] initWithSurveyId:_dataArr[indexPath.row][@"survey_id"]];
    nextVC.rentingSurveyWaitDetailVCBlock = ^{
      
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RoomSurveying" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SurveyInvlid" object:nil];
        [self RequestMethod];
        if (self.rentingSurveyWaitVCBlock) {
            
            self.rentingSurveyWaitVCBlock();
        }
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
    _waitTable.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    
    _waitTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
}

@end
