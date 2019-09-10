
//
//  ModifyTimeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ModifyTimeVC.h"

#import "DateChooseView.h"

#import "DropDownBtn.h"

@interface ModifyTimeVC (){
    
    NSArray *_titleArr;
//    NSArray *_contentArr;
    NSString *_surveyId;
//    NSDate *_date;
//    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) DropDownBtn *originTimeBtn;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation ModifyTimeVC

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
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"YYYY-MM-dd"];
    _titleArr = @[@"联系人",@"联系电话",@"勘察地址"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    [BaseRequest POST:HouseSurveyChangeReserveTime_URL parameters:@{@"survey_id":_surveyId,@"reserve_time":[NSString stringWithFormat:@"%@ 23:59:59",_timeBtn.content.text]} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"变更勘察时间成功" WithDefaultBlack:^{
               
                if (self.modifyTimeVCBlock) {
                    
                    self.modifyTimeVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.pickerView.datePickerMode = UIDatePickerModeDate;
    SS(strongSelf);
    WS(weakSelf);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [formatter dateFromString:self.dataDic[@"survey_time"]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:7];//设置最大时间为：当前时间推后十年
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    NSDate *minDate = currentDate;
    view.pickerView.maximumDate = maxDate;
    view.pickerView.minimumDate = minDate;
    
    view.dateblock = ^(NSDate *date) {
        
//        strongSelf->_date = date;
        strongSelf->_timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"勘察计划";
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 130 *SIZE)];
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
//        label1.text = @"自动生成";
        if (i == 0) {
            
            label1.text = _dataDic[@"name"];
        }else if (i == 1){
            
            label1.text = _dataDic[@"tel"];
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
    
    UIView *whiteView2 = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 136 *SIZE, SCREEN_Width, 143 *SIZE)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 27 *SIZE, 80 *SIZE, 10 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:9 *SIZE];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = @"原预约勘察时间:";
    [whiteView2 addSubview:label];
    
    _originTimeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 22 *SIZE, 258 *SIZE, 33 *SIZE)];
    _originTimeBtn.content.text = [NSString stringWithFormat:@"%@",[self.formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_dataDic[@"timeLimit"] integerValue]]]];
    [whiteView2 addSubview:_originTimeBtn];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 99 *SIZE, 80 *SIZE, 10 *SIZE)];
    label2.textColor = YJTitleLabColor;
    label2.font = [UIFont systemFontOfSize:9 *SIZE];
    label2.adjustsFontSizeToFitWidth = YES;
    label2.text = @"新预约勘察时间:";
    [whiteView2 addSubview:label2];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 86 *SIZE, 258 *SIZE, 33 *SIZE)];
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


@end
