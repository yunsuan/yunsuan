//
//  ContractAddAgentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractAddAgentVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "DropDownBtn.h"

@interface ContractAddAgentVC ()
{
    
    NSDateFormatter *_formatter;
    NSMutableArray *_agentArr;
}
@property (nonatomic, strong) DropDownBtn *flowBtn;

@property (nonatomic, strong) DropDownBtn *agentBtn;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UIButton *nextBtn;


@end

@implementation ContractAddAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    _agentArr = [@[] mutableCopy];
}

- (void)ActionTagBtn:(DropDownBtn *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:59]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                _flowBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                _flowBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 1:
        {
            if (_agentArr.count) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:_agentArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    _agentBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    _agentBtn->str = [NSString stringWithFormat:@"%@",ID];
                };
                [self.view addSubview:view];
            }else{
                
                [BaseRequest GET:TakeMaintainFollowAgentList_URL parameters:nil success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        _agentArr = [NSMutableArray arrayWithArray:[resposeObject[@"data"] mutableCopy]];
                        for (int i = 0; i < _agentArr.count; i++) {
                            
                            NSMutableDictionary *tempDic = [_agentArr[i] mutableCopy];
                            [tempDic setObject:tempDic[@"agent_id"] forKey:@"id"];
                            [tempDic setObject:tempDic[@"name"] forKey:@"param"];
                            [tempDic removeObjectForKey:@"agent_id"];
                            [tempDic removeObjectForKey:@"name"];
                            
                            [_agentArr replaceObjectAtIndex:i withObject:tempDic];
                        }
                        
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:_agentArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            _agentBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                            _agentBtn->str = [NSString stringWithFormat:@"%@",ID];
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"获取经纪人失败，请重试"];
                }];
            }
            break;
        }
        case 2:
        {
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                
                _timeBtn.content.text = [_formatter stringFromDate:date];
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_flowBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择经办流程"];
        return;
    }
    
    if (!_agentBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择经办人"];
        return;
    }
    
    if (!_timeBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择经办时间"];
        return;
    }
    
    NSDictionary *dic = @{@"deal_id":self.dealId,
                          @"agent_id":_agentBtn->str,
                          @"handle_time":_timeBtn.content.text,
                          @"deal_type":_flowBtn->str
                          };
    
    [BaseRequest GET:TakeDealAgentAdd_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"" And:@"添加成功" WithDefaultBlack:^{
               
                if (self.contractAddAgentVCBlock) {
                    
                    self.contractAddAgentVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加经办人";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 175 *SIZE)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSArray *titleArr = @[@"经办流程:",@"经办人:",@"经办时间:"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 28 *SIZE + i * 50 *SIZE, 70 *SIZE, 12 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        [view addSubview:label];
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 18 *SIZE + i * 50 *SIZE, 258 *SIZE, 33 *SIZE)];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        if (i == 0) {
            
            _flowBtn = btn;
            [view addSubview:_flowBtn];
        }else if (i == 1){
            
            _agentBtn = btn;
            [view addSubview:_agentBtn];
        }else{
            
            _timeBtn = btn;
            [view addSubview:_timeBtn];
        }
    }
}

@end
