//
//  LookMaintainDetailAddAppointVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddAppointVC.h"

#import "LookMaintainVC.h"
#import "LookMaintainDetailVC.h"
#import "LookMaintainDetailAddAppointRoomVC.h"

#import "LookMaintainDetailAddAppointRoomModel.h"

#import "LookMaintainDetailAddAppointCell.h"
#import "LookMaintainDetailAddAppointCell2.h"

#import "CalendarsManger.h"

@interface LookMaintainDetailAddAppointVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSString *_takeId;
}
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *commintBtn;

@end

@implementation LookMaintainDetailAddAppointVC

- (instancetype)initWithTakeId:(NSString *)takeId
{
    self = [super init];
    if (self) {
        
        _takeId = takeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    LookMaintainDetailAddAppointRoomVC *nextVC = [[LookMaintainDetailAddAppointRoomVC alloc] initWithTakeId:_takeId dataArr:_dataArr];
    nextVC.isSelect = self.isSelect;
    nextVC.dataDic = self.dataDic;
    nextVC.status = self.status;
    nextVC.lookMaintainDetailAddAppointRoomVCBlock = ^(NSDictionary * _Nonnull dic) {
        
        [_dataArr addObject:dic];
        [_table reloadData];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    if (!_dataArr.count) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择带看房源"];
        return;
    }
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    
    if ([self.status integerValue] == 1) {
        
        for (NSDictionary *dic in _dataArr) {
            
            LookMaintainDetailAddAppointRoomModel *model = dic[@"model"];
            [tempArr addObject:@{@"house_id":model.house_id,@"take_time":dic[@"take_time"]}];
        }
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.dataDic setObject:jsonTemp forKey:@"take_group"];
    }else{
        
        for (NSDictionary *dic in _dataArr) {
            
            NSMutableDictionary *tempDic = [dic mutableCopy];
            [tempDic removeObjectForKey:@"model"];
            [tempArr addObject:tempDic];
        }
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.dataDic setObject:jsonTemp forKey:@"take_group"];
    }
    
    if (self.isSelect) {
        
        [BaseRequest POST:TakeMaintainAdd_URL parameters:self.dataDic success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if ([self.dataDic[@"follow_type"] integerValue] == 2) {
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    for (NSDictionary *dic in _dataArr) {
                        
                        LookMaintainDetailAddAppointRoomModel *model = dic[@"model"];
                        CalendarsManger *manger = [CalendarsManger sharedCalendarsManger];
                        
                        [manger createCalendarWithTitle:@"预约带看" location:model.title startDate:[formatter dateFromString:dic[@"take_time"]] endDate:[formatter dateFromString:dic[@"take_time"]] allDay:NO alarmArray:@[@"86400"]];
                    }
                }
                if (self.lookMaintainDetailAddAppointVCBlock) {
                    
                    self.lookMaintainDetailAddAppointVCBlock();
                }
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[LookMaintainDetailVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                    if ([vc isKindOfClass:[LookMaintainVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [BaseRequest POST:TakeMaintainFollowAdd_URL parameters:self.dataDic success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if ([self.dataDic[@"follow_type"] integerValue] == 2) {
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    for (NSDictionary *dic in _dataArr) {
                        
                        LookMaintainDetailAddAppointRoomModel *model = dic[@"model"];
                        CalendarsManger *manger = [CalendarsManger sharedCalendarsManger];
                        
                        [manger createCalendarWithTitle:@"预约带看" location:model.title startDate:[formatter dateFromString:dic[@"take_time"]] endDate:[formatter dateFromString:dic[@"take_time"]] allDay:NO alarmArray:@[@"86400"]];
                    }
                }
                if (self.lookMaintainDetailAddAppointVCBlock) {
                    
                    self.lookMaintainDetailAddAppointVCBlock();
                }
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[LookMaintainDetailVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            [self showContent:@"网络错误"];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count ? _dataArr.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        LookMaintainDetailAddAppointCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailAddAppointCell2"];
        if (!cell) {
            
            cell = [[LookMaintainDetailAddAppointCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailAddAppointCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = _dataArr[indexPath.row][@"model"];
        cell.storeL.text = [NSString stringWithFormat:@"预约时间：%@",_dataArr[indexPath.row][@"take_time"]];
        return cell;
    }else{
        
        LookMaintainDetailAddAppointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailAddAppointCell"];
        if (!cell) {
            
            cell = [[LookMaintainDetailAddAppointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailAddAppointCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.roomImg.image = [UIImage imageNamed:@"add40"];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        
    }else{
        
        LookMaintainDetailAddAppointRoomVC *nextVC = [[LookMaintainDetailAddAppointRoomVC alloc] initWithTakeId:_takeId dataArr:_dataArr];
        nextVC.dataDic = self.dataDic;
        nextVC.isSelect = self.isSelect;
        nextVC.status = self.status;
        nextVC.lookMaintainDetailAddAppointRoomVCBlock = ^(NSDictionary * _Nonnull dic) {
            
            [_dataArr addObject:dic];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([self.status integerValue] == 1) {
    
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = UITableViewAutomaticDimension;
        _table.estimatedRowHeight = 202.5 *SIZE;
        _table.backgroundColor = self.view.backgroundColor;
        _table.delegate = self;
        _table.dataSource = self;
        [self.view addSubview:_table];
        
        _commintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commintBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
        _commintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        [_commintBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_commintBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_commintBtn setBackgroundColor:YJBlueBtnColor];
        [self.view addSubview:_commintBtn];
//    }else{
//
//        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
//        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _table.rowHeight = UITableViewAutomaticDimension;
//        _table.estimatedRowHeight = 202.5 *SIZE;
//        _table.backgroundColor = self.view.backgroundColor;
//        _table.delegate = self;
//        _table.dataSource = self;
//        [self.view addSubview:_table];
//    }
}

@end
