//
//  GetWorkDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "GetWorkDetailVC.h"
//#import "RentingSurveyWaitDetailVC.h"

//#import "CountDownCell.h"
#import "SingleContentCell.h"
#import "BaseHeader.h"

@interface GetWorkDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_recordId;
}
@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic, strong) UIButton *validBtn;

@end

@implementation GetWorkDetailVC

- (instancetype)initWithRecordId:(NSString *)recordId
{
    self = [super init];
    if (self) {
        
        _recordId = recordId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    if ([self.type integerValue] == 1) {
        
        [BaseRequest GET:HouseRecordDetail_URL parameters:@{@"record_id":_recordId} success:^(id resposeObject) {
            
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
    }else{
        
        [BaseRequest GET:RentRecordDetail_URL parameters:@{@"record_id":_recordId} success:^(id resposeObject) {
            
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
}

- (void)SetData:(NSDictionary *)data{
    
    _titleArr = @[/*@[data[@"timeLimit"]],*/@[[NSString stringWithFormat:@"%@",data[@"project_name"]],[NSString stringWithFormat:@"房源编号：%@",data[@"house_code"]],[NSString stringWithFormat:@"归属门店：%@",data[@"store_name"]],[NSString stringWithFormat:@"联系人：%@",data[@"name"]],[NSString stringWithFormat:@"性别：%@",[data[@"sex"] integerValue] == 2?@"女":@"男"],[NSString stringWithFormat:@"报备时间：%@",data[@"record_time"]],[NSString stringWithFormat:@"备注：%@",data[@"comment"]]]];
    
    [_detailTable reloadData];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ActionValidBtn:(UIButton *)btn{
    
    [BaseRequest GET:HouseGrabRecord_URL parameters:@{@"record_id":_recordId,@"type":self.type} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"抢单成功" WithDefaultBlack:^{
                
                if (self.getWorkDetailVCBlock) {
                    
                    self.getWorkDetailVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            //            SurveyWaitDetailVC *nextVC = [[SurveyWaitDetailVC alloc] initWithSurveyId:_recordId];
            //            [self.navigationController pushViewController:nextVC animated:YES];
            //            RentingSurveyWaitDetailVC *nextVC = [[RentingSurveyWaitDetailVC alloc] init];
            //            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
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
    
//    if (section == 0) {
//
//        header.titleL.text = @"抢单信息";
//    }else{
//
        header.titleL.text = @"报备信息";
//    }
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
    
//    if (indexPath.section == 0) {
//
//        static NSString *CellIdentifier = @"CountDownCell";
//        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        cell.titleL.text = @"房源真实性判断失效倒计时：";
//        cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
//        cell.countdownblock = ^{
//
//            //            [self refresh];
//        };
//        cell.titleL.textColor = YJTitleLabColor;
//        [cell setcountdownbyendtime:@"1529044650"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else{
//
        SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
        if (!cell) {
            
            cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
        
        return cell;
//    }
}

- (void)initUI{
    
    self.titleLabel.text = @"抢单详情";
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
    [_validBtn setTitle:@"抢单" forState:UIControlStateNormal];
    [self.view addSubview:_validBtn];
}


@end
