//
//  StoreDetailVC.m
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreDetailVC.h"
#import "BaseHeader.h"
#import "StoreDetailCell.h"
#import "SecdaryAllTableCell.h"
#import "SecdaryAllTableModel.h"

@interface StoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_recommendId;
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@property (nonatomic , strong) UIButton *surebtn;
@end

@implementation StoreDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self requestMethod];
}

- (void)initDataSource{
    
    //    _dataArr = [@[] mutableCopy];
}

-(void)action_sure
{
    
}

- (void)requestMethod{
    
//    [BaseRequest GET:RecommendBrokerWaitDetail_URL parameters:@{@"recommend_id":_recommendId} success:^(id resposeObject) {
//
//
//    } failure:^(NSError *error) {
//
//        [self showContent:@"网络错误"];
//    }];
}

- (void)SetData:(NSDictionary *)data{
    
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:data];
    
    //    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    //
    //        if (obj isKindOfClass:[NSNull class]) {
    //            <#statements#>
    //        }
    //    }];
    
    _dataArr = @[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else
    {
        return 1;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40*SIZE;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        
        header.titleL.text = @"门店信息";
        
        return header;
    }
    else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 40*SIZE)];
        view.backgroundColor = COLOR(240, 240, 240, 1);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 12*SIZE, 200*SIZE, 16*SIZE)];
        lab.textColor = YJTitleLabColor;
        lab.font = [UIFont systemFontOfSize:15 *SIZE];
        if ([_type isEqualToString:@"1"]) {
            lab.text = [NSString stringWithFormat:@"可售房源（%@）",_type];
        }else
        {
            lab.text = [NSString stringWithFormat:@"可租房源（%@）",_type];
        }
        [view addSubview:lab];
            return view;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        StoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[StoreDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreDetailCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        cell.contentL.text = _dataArr[indexPath.row];
        
        return cell;
    }
    else{
        SecdaryAllTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecdaryAllTableCell"];
        if (!cell) {
            
            cell = [[SecdaryAllTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecdaryAllTableCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        SecdaryAllTableModel *model = _dataArr[indexPath.row];
//        cell.model = model;
        
        return cell;
    }
}

- (void)initUI{
     self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"门店详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    
    [self.view addSubview:_table];
    [self.view addSubview:self.surebtn];
}


-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame =  CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        [_surebtn setTitle:@"推荐" forState:UIControlStateNormal];
        
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:15.3*SIZE];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}

@end



