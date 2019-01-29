//
//  LookWorkConfirmDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookWorkConfirmDetailVC.h"

#import "RoomInvalidApplyVC.h"
#import "RoomValidApplyVC.h"
//#import "SystemWorkWaitVC.h"
//#import "SystemWorkConfrimVC.h"
#import "SystemoWorkVC.h"

#import "CountDownCell.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"
#import "WaitAnimation.h"

@interface LookWorkConfirmDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_needArr;
    NSString *_surveyId;
    NSString *_type;
    NSDictionary *_dataDic;
    NSString *_phone;
    NSString *_houseCode;
    NSString *_endtime;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation LookWorkConfirmDetailVC

- (instancetype)initWithSurveyId:(NSString *)surveyId type:(NSString *)type
{
    self = [super init];
    if (self) {
        
        _surveyId = surveyId;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [BaseRequest GET:HouseSurveyWaitConfirmDetail_URL parameters:@{@"survey_id":_surveyId,@"type":_type} success:^(id resposeObject) {
        
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
    
    _dataDic = data;

    NSString *sex =@"";
    if ([data[@"recommend_info"][@"client_sex"] integerValue]==1) {
        sex =@"男";
    }
    if ([data[@"recommend_info"][@"client_sex"] integerValue]==2) {
        sex =@"女";
    }
    
    NSDictionary *recommendDic = data[@"recommend_info"];
    NSDictionary *needDic = data[@"need_info"];
    if ([recommendDic[@"property_type"] integerValue] == 2) {
        
        _needArr = @[[NSString stringWithFormat:@"区域：%@",[needDic[@"region"] count]?[NSString stringWithFormat:@"%@%@%@",needDic[@"region"][0][@"province_name"],needDic[@"region"][0][@"city_name"],needDic[@"region"][0][@"district_name"]]:@""],[NSString stringWithFormat:@"总价：%@",needDic[@"total_price"]],[NSString stringWithFormat:@"面积：%@",needDic[@"area"]],[NSString stringWithFormat:@"商铺类型：%@",needDic[@"shop_type"]],[NSString stringWithFormat:@"置业目的：%@",needDic[@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套：%@",[needDic[@"match_tags"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"备注：%@",needDic[@"comment"]]];
    }else if ([recommendDic[@"property_type"] integerValue] == 1){
        
        _needArr = @[[NSString stringWithFormat:@"区域：%@",[needDic[@"region"] count]?[NSString stringWithFormat:@"%@%@%@",needDic[@"region"][0][@"province_name"],needDic[@"region"][0][@"city_name"],needDic[@"region"][0][@"district_name"]]:@""],[NSString stringWithFormat:@"总价：%@",needDic[@"total_price"]],[NSString stringWithFormat:@"面积：%@",needDic[@"area"]],[NSString stringWithFormat:@"户型：%@",needDic[@"house_type"]],[NSString stringWithFormat:@"楼层：%@层-%@层",needDic[@"floor_min"],needDic[@"floor_max"]],[NSString stringWithFormat:@"装修标准：%@",needDic[@"decorate"]],[NSString stringWithFormat:@"置业目的：%@",needDic[@"buy_purpose"]],[NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套：%@",needDic[@"need_tags"]],[NSString stringWithFormat:@"备注：%@",needDic[@"comment"]]];
    }else{
        
        _needArr = @[[NSString stringWithFormat:@"区域：%@",[needDic[@"region"] count]?[NSString stringWithFormat:@"%@%@%@",needDic[@"region"][0][@"province_name"],needDic[@"region"][0][@"city_name"],needDic[@"region"][0][@"district_name"]]:@""],[NSString stringWithFormat:@"总价：%@",needDic[@"total_price"]],[NSString stringWithFormat:@"面积：%@",needDic[@"area"]],[NSString stringWithFormat:@"级别：%@",needDic[@"office_level"]],[NSString stringWithFormat:@"已使用年限：%@",needDic[@"used_years"]],[NSString stringWithFormat:@"置业目的：%@",needDic[@"buy_use"]],[NSString stringWithFormat:@"付款方式：%@",[needDic[@"pay_type"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"配套：%@",[needDic[@"match_tags"] componentsJoinedByString:@","]],[NSString stringWithFormat:@"备注：%@",needDic[@"comment"]]];
    }
    
    _titleArr = @[@[[NSString stringWithFormat:@"来源：%@",data[@"recommend_info"][@"source"]],[NSString stringWithFormat:@"客源编号：%@",data[@"recommend_info"][@"recommend_code"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"recommend_info"][@"client_name"]],[NSString stringWithFormat:@"客户性别：%@",sex],[NSString stringWithFormat:@"推荐时间：%@",data[@"recommend_info"][@"recommend_time"]],[NSString stringWithFormat:@"备注：%@",data[@"recommend_info"][@"comment"]]],@[[NSString stringWithFormat:@"经纪人：%@",data[@""][@""]],[NSString stringWithFormat:@"联系电话：%@",data[@""][@""]],[NSString stringWithFormat:@"门店编号：%@",data[@""][@""]],[NSString stringWithFormat:@"门店名称：%@",data[@""][@""]],[NSString stringWithFormat:@"接单时间：%@",data[@""][@""]]],_needArr];
    
    _endtime = [NSString stringWithFormat:@"%@",data[@"timeLimit"]];
    [_detailTable reloadData];

}

- (void)ActionTapMethod:(UILabel *)label{
    
    if (_phone.length) {
        
        //获取目标号码字符串,转换成URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
    }
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SystemoWorkVC class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [WaitAnimation stopAnimation];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SystemoWorkVC class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    
    if (_dataDic.count) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认房源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *valid = [UIAlertAction actionWithTitle:@"房源有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            RoomValidApplyVC *nextVC = [[RoomValidApplyVC alloc] initWithData:_dataDic SurveyId:_surveyId];
            nextVC.houseCode = _houseCode;
            nextVC.roomValidApplyVCBlock = ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RoomSurveying" object:nil];
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        
        UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"房源无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            RoomInvalidApplyVC *nextVC = [[RoomInvalidApplyVC alloc] initWithData:_dataDic SurveyId:_surveyId];
            nextVC.roomInvalidApplyVCBlock = ^{
                
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
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"订单信息";
    }else if (section == 1){
        
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
    
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.titleL.text = @"房源真实性判断失效倒计时：";
        cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
        cell.countdownblock = ^{
            
            //            [self refresh];
        };
        cell.titleL.textColor = YJTitleLabColor;
        [cell setcountdownbyendtime:_endtime];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"已接单详情";
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
    [_invalidBtn setTitle:@"确认无效" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"确认有效" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}

@end
