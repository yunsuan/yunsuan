//
//  CustomLookWaitDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookWaitDetailVC.h"

#import "ModifyTimeVC.h"
#import "ModifyRecordVC.h"
#import "CustomLookConfirmFailVC.h"
#import "CustomLookConfirmSuccessVC.h"

//#import "CountDownCell.h"
#import "CountDownCell.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "SurveyingDetailCell.h"

@interface CustomLookWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSString *_takeId;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation CustomLookWaitDetailVC

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
    
    _titleArr = @[@"失效倒计时：",@"推荐信息",@"接单信息",@"需求信息"];
    _contentArr = [@[] mutableCopy];
    _dataDic = [@{} mutableCopy];
    [self initUI];
    [self RequestMethod];
}

-(void)refresh{
    
    [BaseRequest GET:HouseSurveyTimeOut_URL parameters:nil success:^(id resposeObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secReload" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:RecommendButterWaitDetail_URL parameters:@{@"take_id":_takeId} success:^(id resposeObject) {
        
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
    
    _dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
//    NSDictionary *recommendDic = data[@"recommend_info"];
    NSDictionary *needDic = data[@"need_info"];
    if ([_dataDic[@"property_type"] integerValue] == 1) {
        
        if ([data[@"need_info"][@"region"] count]) {
            
            _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"%@",_dataDic[@"timeLimit"]]],@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"意向物业：%@",@"住宅"],[NSString stringWithFormat:@"意向区域：%@",[NSString stringWithFormat:@"%@%@%@",data[@"need_info"][@"region"][0][@"province_name"],data[@"need_info"][@"region"][0][@"city_name"],data[@"need_info"][@"region"][0][@"district_name"]]],[NSString stringWithFormat:@"意向价格：%@",data[@"need_info"][@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",data[@"need_info"][@"area"]],[NSString stringWithFormat:@"装修标准：%@",data[@"need_info"][@"decorate"]],[NSString stringWithFormat:@"置业目的：%@",data[@"need_info"][@"buy_purpose"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"need_info"][@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"需求标签：%@",data[@"need_info"][@"need_tags"]],[NSString stringWithFormat:@"备注：%@",data[@"need_info"][@"comment"]]]]];
        }else{
            
            _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"%@",_dataDic[@"timeLimit"]]],@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"意向物业：%@",@"住宅"],[NSString stringWithFormat:@"意向区域："],[NSString stringWithFormat:@"意向价格：%@",data[@"need_info"][@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",data[@"need_info"][@"area"]],[NSString stringWithFormat:@"装修标准：%@",data[@"need_info"][@"decorate"]],[NSString stringWithFormat:@"置业目的：%@",data[@"need_info"][@"buy_purpose"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"need_info"][@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"需求标签：%@",data[@"need_info"][@"need_tags"]],[NSString stringWithFormat:@"备注：%@",data[@"need_info"][@"comment"]]]]];
        }
        
    }else if ([_dataDic[@"property_type"] integerValue] == 2){
        
        NSString *str = @"";
        for (NSDictionary *dic in needDic[@"match_tags"]) {
            
            if (str.length) {
                
                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"name"]];
            }else{
                
                str = dic[@"name"];
            }
        }
        if ([data[@"need_info"][@"region"] count]) {
            
            _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"%@",_dataDic[@"timeLimit"]]],@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"意向物业：%@",@"商铺"],[NSString stringWithFormat:@"意向区域：%@",[NSString stringWithFormat:@"%@%@%@",data[@"need_info"][@"region"][0][@"province_name"],data[@"need_info"][@"region"][0][@"city_name"],data[@"need_info"][@"region"][0][@"district_name"]]],[NSString stringWithFormat:@"意向价格：%@",data[@"need_info"][@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",data[@"need_info"][@"area"]],[NSString stringWithFormat:@"商铺类型：%@",[data[@"need_info"][@"shop_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"购买用途：%@",data[@"need_info"][@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"need_info"][@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套设施：%@",str],[NSString stringWithFormat:@"备注：%@",data[@"need_info"][@"comment"]]]]];
        }else{
            
            _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"%@",_dataDic[@"timeLimit"]]],@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"意向物业：%@",@"商铺"],[NSString stringWithFormat:@"意向区域："],[NSString stringWithFormat:@"意向价格：%@",data[@"need_info"][@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",data[@"need_info"][@"area"]],[NSString stringWithFormat:@"商铺类型：%@",[data[@"need_info"][@"shop_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"购买用途：%@",data[@"need_info"][@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"need_info"][@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套设施：%@",str],[NSString stringWithFormat:@"备注：%@",data[@"need_info"][@"comment"]]]]];
        }
        
    }else{
        
        NSString *str = @"";
        for (NSDictionary *dic in needDic[@"match_tags"]) {
            
            if (str.length) {
                
                str = [NSString stringWithFormat:@"%@,%@",str,dic[@"name"]];
            }else{
                
                str = dic[@"name"];
            }
        }
        if ([data[@"need_info"][@"region"] count]) {
            
            _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"%@",_dataDic[@"timeLimit"]]],@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"意向物业：%@",@"写字楼"],[NSString stringWithFormat:@"意向区域：%@",[NSString stringWithFormat:@"%@%@%@",data[@"need_info"][@"region"][0][@"province_name"],data[@"need_info"][@"region"][0][@"city_name"],data[@"need_info"][@"region"][0][@"district_name"]]],[NSString stringWithFormat:@"意向价格：%@",data[@"need_info"][@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",data[@"need_info"][@"area"]],[NSString stringWithFormat:@"写字楼等级：%@",data[@"need_info"][@"office_level"]],[NSString stringWithFormat:@"购买用途：%@",data[@"need_info"][@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"need_info"][@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套设施：%@",str],[NSString stringWithFormat:@"备注：%@",data[@"need_info"][@"comment"]]]]];
        }else{
            
            _contentArr = [NSMutableArray arrayWithArray:@[@[[NSString stringWithFormat:@"%@",_dataDic[@"timeLimit"]]],@[[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"client_sex"] integerValue] == 1? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"client_tel"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@"butter_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"butter_tel"]],[NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]],[NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]],[NSString stringWithFormat:@"接单时间：%@",data[@"accept_time"]]],@[[NSString stringWithFormat:@"意向物业：%@",@"写字楼"],[NSString stringWithFormat:@"意向区域："],[NSString stringWithFormat:@"意向价格：%@",data[@"need_info"][@"total_price"]],[NSString stringWithFormat:@"意向面积：%@",data[@"need_info"][@"area"]],[NSString stringWithFormat:@"写字楼等级：%@",data[@"need_info"][@"office_level"]],[NSString stringWithFormat:@"购买用途：%@",data[@"need_info"][@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[data[@"need_info"][@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套设施：%@",str],[NSString stringWithFormat:@"备注：%@",data[@"need_info"][@"comment"]]]]];
        }
    }
    
    [_detailTable reloadData];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    if (_dataDic.count) {
        
        CustomLookConfirmFailVC *nextVC = [[CustomLookConfirmFailVC alloc] initWithData:_dataDic];
        nextVC.customLookConfirmFailVCBlock = ^{
            
            if (self.customLookWaitDetailVCBlock) {
                
                self.customLookWaitDetailVCBlock();
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    if (_dataDic) {
        
        CustomLookConfirmSuccessVC *nextVC = [[CustomLookConfirmSuccessVC alloc] initWithDataDic:_dataDic];
        nextVC.customLookConfirmSuccessVCBlock = ^{
            
            if (self.customLookWaitDetailVCBlock) {
                
                self.customLookWaitDetailVCBlock();
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _contentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = _titleArr[section];
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
    
    if (indexPath.section == 0 ) {
        
        
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.titleL.text = @"";
        cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
        cell.countdownblock = ^{
            
            //            [self refresh];
        };
        
        cell.titleL.textColor = YJTitleLabColor;
        [cell setcountdownbyendtime:_contentArr[indexPath.section][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"待确认详情";
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
    [_invalidBtn setTitle:@"客源无效" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"客源有效" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}

@end
