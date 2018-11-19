//
//  SurveyWaitDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveyWaitDetailVC.h"
#import "RoomInvalidApplyVC.h"
#import "RoomValidApplyVC.h"

#import "CountDownCell.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface SurveyWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_surveyId;
    NSDictionary *_dataDic;
    NSString *_phone;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation SurveyWaitDetailVC

- (instancetype)initWithSurveyId:(NSString *)surveyId
{
    self = [super init];
    if (self) {
        
        _surveyId = surveyId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _titleArr = @[@[@"抢单时间：2017-10-23  19:00:00",@"经纪人：张三",@"联系电话：18745561223",@"房源真实性判断失效倒计时："],@[@"天鹅湖小区 - 17栋 - 2单元 - 103",@"房源编号：CD - TEH - 20170810 - 1（F）",@"归属门店：MDBHNO1",@"联系人：李四",@"性别：男",@"身份证号：5130291556231203",@"联系电话：13932452456",@"与业主关系：业主本人",@"报备时间：2017-10-23  19:00:00",@"备注：**********************"]];
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
    
    [BaseRequest GET:HouseSurveyWaitConfirmDetail_URL parameters:@{@"survey_id":_surveyId} success:^(id resposeObject) {
        
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
    _titleArr = @[@[[NSString stringWithFormat:@"抢单时间：%@",data[@"survey_time"]],[NSString stringWithFormat:@"经纪人：%@",data[@"agent_name"]],[NSString stringWithFormat:@"联系电话：%@",data[@"agent_tel"]],data[@"timeLimit"]],@[[NSString stringWithFormat:@"%@",data[@"house"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2? @"女":@"男"],[NSString stringWithFormat:@"证件类型：%@",data[@"card_type"]],[NSString stringWithFormat:@"证件编号：%@",data[@"card_id"]],[NSString stringWithFormat:@"联系电话：%@",data[@"tel"]],[NSString stringWithFormat:@"与业主关系：%@",data[@"report_type"]],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]]];
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
    
    if (_dataDic.count) {
        
        RoomInvalidApplyVC *nextVC = [[RoomInvalidApplyVC alloc] initWithData:_dataDic SurveyId:_surveyId];
        nextVC.roomInvalidApplyVCBlock = ^{
            
            if (self.surveyWaitDetailVCBlock) {
                
                self.surveyWaitDetailVCBlock();
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    if (_dataDic.count) {
        
        RoomValidApplyVC *nextVC = [[RoomValidApplyVC alloc] initWithData:_dataDic SurveyId:_surveyId];
        nextVC.roomValidApplyVCBlock = ^{
            
            if (self.surveyWaitDetailVCBlock) {
                
                self.surveyWaitDetailVCBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }
        };
        [self.navigationController pushViewController:nextVC animated:YES];
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
        
        header.titleL.text = @"抢单信息";
    }else{
        
        header.titleL.text = @"报备信息";
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
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        
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
        if (_titleArr.count) {
            
            [cell setcountdownbyendtime:_titleArr[0][3]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        if (indexPath.row == 7) {
            
            NSString *str = _titleArr[indexPath.section][indexPath.row];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
            [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(5, str.length - 5)];
            cell.contentL.userInteractionEnabled = YES;
            cell.contentL.attributedText = attr;
            _phone = [str substringFromIndex:5];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTapMethod:)];
            [cell.contentL addGestureRecognizer:tap];
        }else{
            
            cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
        }
//        cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
        
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
    _invalidBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_invalidBtn addTarget:self action:@selector(ActionInValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_invalidBtn setTitle:@"房源无效" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _validBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _validBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    
    _validBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_validBtn addTarget:self action:@selector(ActionValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_validBtn setBackgroundColor:YJBlueBtnColor];
    [_validBtn setTitle:@"房源有效" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}
@end
