//
//  RentingValidApplyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingValidApplyVC.h"

#import "RentingSurveyVC.h"
#import "RentingSurveyWaitVC.h"
#import "SystemoWorkVC.h"

#import "RentingCompleteSurveyInfoVC.h"

#import "DateChooseView.h"

#import "DropDownBtn.h"

@interface RentingValidApplyVC ()
{
    
    NSArray *_titleArr;
    NSString *_time;
    NSDictionary *_dataDic;
    NSString *_surveyId;
}
@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) DateChooseView *dateView;

@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation RentingValidApplyVC

- (instancetype)initWithData:(NSDictionary *)data SurveyId:(NSString *)surveyId
{
    self = [super init];
    if (self) {
        
        _dataDic = data;
        _surveyId = surveyId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    _titleArr = @[@"联系人",@"联系电话",@"勘察地址"];
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.pickerView.datePickerMode = UIDatePickerModeDate;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:7];//设置最大时间为：当前时间推后十年
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    NSDate *minDate = currentDate;
    view.pickerView.maximumDate = maxDate;
    view.pickerView.minimumDate = minDate;
    
    __weak __typeof(&*self)weakSelf = self;
    __strong __typeof(&*self)strongSelf = self;
    view.dateblock = ^(NSDate *date) {
        
        weakSelf.timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
        strongSelf->_time = [weakSelf.formatter stringFromDate:date];
    };
    [self.view addSubview:view];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_time.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择勘察时间"];
        return;
    }
    NSDictionary *dic = @{@"survey_id":_surveyId,
                          @"reserve_time":[NSString stringWithFormat:@"%@ 23:59:59",_time]
                          };
    [BaseRequest GET:RentRecordValue_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"确认成功" WithDefaultBlack:^{
                
                if (self.rentingValidApplyVCBlock) {
                    
                    self.rentingValidApplyVCBlock();
                }
                
                UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否立即勘察房源？" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"%@",self.navigationController.viewControllers);
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[RentingSurveyVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            break;
                        }
                        if ([vc isKindOfClass:[RentingSurveyWaitVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            break;
                        }
                        if ([vc isKindOfClass:[SystemoWorkVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            break;
                        }
                    }
                }];
                UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"立即勘察" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    RentingCompleteSurveyInfoVC *nextVC = [[RentingCompleteSurveyInfoVC alloc] initWithTitle:@"完成勘察信息"];
                    nextVC.rentingCompleteSurveyInfoVCBlock = ^{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"comleteSurvey" object:nil];
                    
                    };
                    nextVC.dataDic = _dataDic;
                    nextVC.surveyId = _surveyId;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
                [alert addAction:alert1];
                [alert addAction:alert2];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察计划";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 131 *SIZE)];
    whiteView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView1];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 16 *SIZE + i * 43 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        [whiteView1 addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(80 *SIZE, 16 *SIZE + i * 43 *SIZE, 200 *SIZE, 13 *SIZE)];
        label1.textColor = YJ170Color;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            label1.text = _dataDic[@"name"];
        }else if (i == 1){
            
            label1.text = [_dataDic[@"tel"] componentsSeparatedByString:@","][0];
        }else{
            
            label1.text = [NSString stringWithFormat:@"%@",_dataDic[@"house"]];
        }
        [whiteView1 addSubview:label1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 43 *SIZE * i - SIZE, 340 *SIZE, SIZE)];
        line.backgroundColor = COLOR(202, 201, 201, 0.55);
        if (i != 0) {
            
            [whiteView1 addSubview:line];
        }
    }
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 136  *SIZE, SCREEN_Width, 83 *SIZE)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 38 *SIZE, 80 *SIZE, 10 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    label.text = @"预约勘察时间:";
    [whiteView2 addSubview:label];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE, 258 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:_timeBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 493 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}

- (DateChooseView *)dateView{
    
    if (!_dateView) {
        
        _dateView = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _dateView.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        __weak __typeof(&*self)weakSelf = self;
        __strong __typeof(&*self)strongSelf = self;
        _dateView.dateblock = ^(NSDate *date) {
            
            //            _time = date;
            weakSelf.timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
            strongSelf->_time = [weakSelf.formatter stringFromDate:date];
        };
    }
    return _dateView;
}

@end
