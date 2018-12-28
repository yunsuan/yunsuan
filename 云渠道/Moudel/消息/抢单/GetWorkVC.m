//
//  GetWorkVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "GetWorkVC.h"
#import "GetWorkDetailVC.h"
//#import "RentingSurveyWaitDetailVC.h"

#import "GetWorkCell.h"

@interface GetWorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *waitTable;

@end

@implementation GetWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseRecordList_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        [_waitTable reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    
    _dataArr = [NSMutableArray arrayWithArray:data];
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        [_dataArr replaceObjectAtIndex:i withObject:tempDic];
    }
    
    [_waitTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GetWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetWorkCell"];
    if (!cell) {
        
        cell = [[GetWorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GetWorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];

    
    cell.getWorkCellBlock = ^(NSInteger index) {
        
        [BaseRequest GET:HouseGrabRecord_URL parameters:@{@"record_id":_dataArr[index][@"record_id"],@"type":_dataArr[index][@"type"]} success:^(id resposeObject) {
            
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"抢单成功" WithDefaultBlack:^{
                    
                    [self RequestMethod];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            NSLog(@"%@",error);
        }];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GetWorkDetailVC *nextVC = [[GetWorkDetailVC alloc] initWithRecordId:_dataArr[indexPath.row][@"record_id"]];
    nextVC.type = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"type"]];
    nextVC.getWorkDetailVCBlock = ^{
      
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察抢单";
    
    _waitTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    _waitTable.rowHeight = UITableViewAutomaticDimension;
    _waitTable.estimatedRowHeight = 87 *SIZE;
    _waitTable.backgroundColor = self.view.backgroundColor;
    _waitTable.delegate = self;
    _waitTable.dataSource = self;
    _waitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_waitTable];
}

@end
