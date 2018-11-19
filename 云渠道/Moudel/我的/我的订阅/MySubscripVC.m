//
//  MySubscripVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/6.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "MySubscripVC.h"

#import "RoomDetailVC1.h"
#import "SecComRoomDetailVC.h"

#import "MySubscripModel.h"
#import "RoomListModel.h"
#import "SecdaryComModel.h"

#import "MySubscripCell.h"
#import "CompanyCell.h"
#import "SecdaryComTableCell.h"


@interface MySubscripVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation MySubscripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [@[] mutableCopy];
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetFocusProjectList_URL parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];

        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        if ([tempDic[@"sub_type"] integerValue] == 0) {
            
            
            RoomListModel *model = [[RoomListModel alloc] initWithDictionary:tempDic];
            NSDictionary *dic = @{@"model":model,
                                  @"sub_type":tempDic[@"sub_type"]
                                  };
            [_dataArr addObject:dic];
        }else if ([tempDic[@"sub_type"] integerValue] == 1){
            
            SecdaryComModel *model = [[SecdaryComModel alloc] initWithDictionary:tempDic];
            NSDictionary *dic = @{@"model":model,
                                  @"sub_type":tempDic[@"sub_type"]
                                  };
            [_dataArr addObject:dic];

        }else{
            
            MySubscripModel *model = [[MySubscripModel alloc] initWithDictionary:tempDic];

        }
//
//        [_dataArr addObject:model];
    }
    [_table reloadData];
}

#pragma table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_dataArr[indexPath.row][@"sub_type"] integerValue] == 0) {
        
        RoomListModel *model = _dataArr[indexPath.row][@"model"];
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.statusImg.hidden = YES;
        
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        
        [cell settagviewWithdata:@[model.property_tags,model.project_tags]];
        return cell;
    }else if ([_dataArr[indexPath.row][@"sub_type"] integerValue] == 1){
        
        SecdaryComTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecdaryComTableCell"];
        if (!cell) {
            
            cell = [[SecdaryComTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecdaryComTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.codeL.hidden = NO;
        cell.model = _dataArr[indexPath.row][@"model"];
        
        return cell;
    }else{
        
        RoomListModel *model = _dataArr[indexPath.row][@"model"];
        static NSString *CellIdentifier = @"CompanyCell";
        
        CompanyCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell SetTitle:model.project_name image:model.img_url contentlab:model.absolute_address statu:model.sale_state];
        
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySubscripModel *model = _dataArr[indexPath.row];
    NSDictionary *dic = @{@"sub_id":model.sub_id};
    [BaseRequest GET:CancelFocusProject_URL parameters:dic success:^(id resposeObject) {
        
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        }        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消订阅";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"sub_type"] integerValue] == 0) {
        
        RoomListModel *model = _dataArr[indexPath.row][@"model"];
        RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//        if ([model.guarantee_brokerage integerValue] == 2) {
//
//            nextVC.brokerage = @"no";
//        }else{
//
            nextVC.brokerage = @"yes";
//        }
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        SecdaryComModel *model = _dataArr[indexPath.row][@"model"];
        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:@"0"];
        
        
        nextVC.type = @"0";
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
        
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的订阅";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
