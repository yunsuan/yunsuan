//
//  LookWorkWaitDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookWorkWaitDetailVC.h"
#import "LookWorkConfirmDetailVC.h"

#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "CountDownCell.h"


@interface LookWorkWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_pushId;
    NSArray *_needArr;
    NSString *_timelimit;
}

@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation LookWorkWaitDetailVC

- (instancetype)initWithPushId:(NSString *)pushId
{
    self = [super init];
    if (self) {
        
        _pushId = pushId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:TakeLookWaitDetail_URL parameters:@{@"push_id":_pushId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSDictionary *recommendDic = data[@"recommend_info"];
    NSDictionary *needDic = data[@"need_info"];
    if ([recommendDic[@"property_type"] integerValue] == 2) {
        
        NSString *str = @"";
        for (NSDictionary *dic in needDic[@"match_tags"]) {
            
            if (str.length) {
                
                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"name"]];
            }else{
                
                str = dic[@"name"];
            }
        }
        _needArr = @[[NSString stringWithFormat:@"意向物业：%@",@"商铺"],[NSString stringWithFormat:@"意向区域：%@",[needDic[@"region"] count]?[NSString stringWithFormat:@"%@%@%@",needDic[@"region"][0][@"province_name"],needDic[@"region"][0][@"city_name"],needDic[@"region"][0][@"district_name"]]:@""],[NSString stringWithFormat:@"意向价格：%@",needDic[@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",needDic[@"area"]],[NSString stringWithFormat:@"商铺类型：%@",[needDic[@"shop_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"购买用途：%@",needDic[@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套设施：%@",str],[NSString stringWithFormat:@"备注：%@",needDic[@"comment"]]];
    }else if ([recommendDic[@"property_type"] integerValue] == 1){
        
        _needArr = @[[NSString stringWithFormat:@"意向物业：%@",@"住宅"],[NSString stringWithFormat:@"意向区域：%@",[needDic[@"region"] count]?[NSString stringWithFormat:@"%@%@%@",needDic[@"region"][0][@"province_name"],needDic[@"region"][0][@"city_name"],needDic[@"region"][0][@"district_name"]]:@""],[NSString stringWithFormat:@"意向价格：%@",needDic[@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",needDic[@"area"]],[NSString stringWithFormat:@"意向户型：%@",needDic[@"house_type"]],[NSString stringWithFormat:@"意向楼层：%@层-%@层",needDic[@"floor_min"],needDic[@"floor_max"]],[NSString stringWithFormat:@"装修标准：%@",needDic[@"decorate"]],[NSString stringWithFormat:@"置业目的：%@",needDic[@"buy_purpose"]],[NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"需求标签：%@",needDic[@"need_tags"]],[NSString stringWithFormat:@"备注：%@",needDic[@"comment"]]];
    }else{
        
        NSString *str = @"";
        for (NSDictionary *dic in needDic[@"match_tags"]) {
            
            if (str.length) {
                
                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"name"]];
            }else{
                
                str = dic[@"name"];
            }
        }
        _needArr = @[[NSString stringWithFormat:@"意向物业：%@",@"写字楼"],[NSString stringWithFormat:@"意向区域：%@",[needDic[@"region"] count]?[NSString stringWithFormat:@"%@%@%@",needDic[@"region"][0][@"province_name"],needDic[@"region"][0][@"city_name"],needDic[@"region"][0][@"district_name"]]:@""],[NSString stringWithFormat:@"意向价格：%@",needDic[@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",needDic[@"area"]],[NSString stringWithFormat:@"写字楼等级：%@",needDic[@"office_level"]],[NSString stringWithFormat:@"已使用年限：%@",needDic[@"used_years"]],[NSString stringWithFormat:@"购买用途：%@",needDic[@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套设施：%@",str],[NSString stringWithFormat:@"备注：%@",needDic[@"comment"]]];
    }
    
    NSString *sex =@"";
    if ([data[@"recommend_info"][@"client_sex"] integerValue]==1) {
        sex =@"男";
    }
    if ([data[@"recommend_info"][@"client_sex"] integerValue]==2) {
        sex =@"女";
    }
    _titleArr = @[[NSString stringWithFormat:@"来源：%@",data[@"recommend_info"][@"source"]],[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_info"][@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"recommend_info"][@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",sex],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_info"][@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"recommend_info"][@"comment"]]];
    
    _timelimit = [NSString stringWithFormat:@"%@",data[@"recommend_info"][@"timeLimit"]];
    [_detailTable reloadData];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"确认接受派单" WithCancelBlack:^{
        
        
    } WithDefaultBlack:^{
        
        [BaseRequest GET:AcceptTake_URL parameters:@{@"push_id":_pushId} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"接单成功" And:@"" WithDefaultBlack:^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemWork" object:nil];
                    LookWorkConfirmDetailVC *nextVC = [[LookWorkConfirmDetailVC alloc] initWithSurveyId:[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"survey_id"]] type:resposeObject[@"data"][@"type"]];
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_titleArr.count) {
        
        return 2;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _titleArr.count + 1;
    }else{
        
        return _needArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    if (section==0) {
         header.titleL.text = @"推荐信息";
    }else{
        header.titleL.text = @"需求信息";
    }
    header.lineView.hidden = YES;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        CountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountDownCell"];
        if (!cell) {
            
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CountDownCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setcountdownbyendtime:_timelimit];
        
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        if (indexPath.section == 0) {
            
            cell.contentL.text = _titleArr[indexPath.row - 1];
        }else{
            
            cell.contentL.text = _needArr[indexPath.row];
        }
        
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"待接单详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _invalidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _invalidBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 119 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    [_invalidBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    _invalidBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_invalidBtn addTarget:self action:@selector(ActionInValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_invalidBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"接受派单" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}

@end
