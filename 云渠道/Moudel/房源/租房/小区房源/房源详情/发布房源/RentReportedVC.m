//
//  RentReportedVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/17.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentReportedVC.h"
#import "SecComRoomDetailVC.h"
#import "RoomReportVC.h"
#import "CompleteSurveyInfoVC.h"

#import "BaseFrameHeader.h"
#import "ReportView.h"
#import "ReportVew2.h"
#import "DateChooseView.h"
#import "FailView.h"
#import "SinglePickView.h"
#import "AdressChooseView.h"
#import "ReportSuccussView.h"
#import "ReportSuccussView2.h"

@interface RentReportedVC ()<UITextFieldDelegate>
{
    
    NSDictionary *_data;
    NSString *_buildId;
    NSString *_unitId;
    NSString *_reporterType;
    NSString *_cardType;
    NSString *_gender;
    //    NSInteger _num;
    NSString *_tel;
    NSString *_address;
    BOOL _isCheck;
    NSDateFormatter *_formatter;
    NSString *_city;
    //    NSString *_district;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) BaseFrameHeader *headerView;

@property (nonatomic, strong) ReportView *reportView;

@property (nonatomic, strong) UITextView *markText;

@property (nonatomic, strong) ReportVew2 *wayView;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) FailView *failView;

@end

@implementation RentReportedVC

- (instancetype)initWithData:(NSDictionary *)data buildId:(NSString *)buildId unitId:(NSString *)unitId
{
    self = [super init];
    if (self) {
        
        _data = data;
        _buildId = buildId;
        _unitId = unitId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    [self RequestMethod];
}

- (void)AddressRequestMethod{
    
    [BaseRequest GET:HouseProjectAddressInfo_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _city = resposeObject[@"data"][@"city_name"];
            //            _district = resposeObject[@"data"][@"district_name"];
        }
        [self initUI];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:RentCapacityCheck_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] integerValue] == 1) {
                
                self->_isCheck = YES;
                [self AddressRequestMethod];
            }else{
                
                [self AddressRequestMethod];
            }
        }else{
            
            [self initUI];
        }
    } failure:^(NSError *error) {
        
        [self initUI];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _reportView.tel1.textfield) {
        
        if (![self checkTel:_reportView.tel1.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
            
            [textField becomeFirstResponder];
        }
    }
    
    if (textField == _reportView.tel2.textfield) {
        
        if (![self checkTel:_reportView.tel2.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
            
            [textField becomeFirstResponder];
        }
    }
    
    if (textField == _reportView.tel3.textfield) {
        
        if (![self checkTel:_reportView.tel3.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
            
            [textField becomeFirstResponder];
        }
    }
}


- (void)ActionCommitBtn:(UIButton *)btn{
    
    
    if ([self isEmpty:_reportView.nameTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入姓名"];
        return;
    }
    
    if (!_gender.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择性别"];
        return;
    }
    
    if (_reportView.num == 0) {
        
        if (![self checkTel:_reportView.tel1.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
            return;
        }else{
            
            _tel = _reportView.tel1.textfield.text;
        }
    }else if (_reportView.num == 1){
        
        if (![self isEmpty:_reportView.tel2.textfield.text]) {
            
            if (![self checkTel:_reportView.tel2.textfield.text] ) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
                return;
            }else{
                
                _tel = _reportView.tel1.textfield.text;
                _tel = [NSString stringWithFormat:@"%@,%@",_tel,_reportView.tel2.textfield.text];
            }
        }
    }else{
        
        if (![self isEmpty:_reportView.tel3.textfield.text]) {
            
            if (![self checkTel:_reportView.tel3.textfield.text] ) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
                return;
            }else{
                
                _tel = _reportView.tel1.textfield.text;
                _tel = [NSString stringWithFormat:@"%@,%@",_tel,_reportView.tel2.textfield.text];
                _tel = [NSString stringWithFormat:@"%@,%@",_tel,_reportView.tel3.textfield.text];
            }
        }
    }
    
    
    if (!_reporterType.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择与业主的关系"];
        return;
    }
    
    NSDictionary *tempDic = @{@"project_id":self.projectId,
                              @"build_id":_buildId,
                              @"build_name":_data[@"LDMC"],
                              @"unit_id":_unitId,
                              @"unit_name":_data[@"DYMC"],
                              @"house_id":_data[@"FJID"],
                              @"house_name":_data[@"FJMC"],
                              @"property_type":_data[@"WYMC"],
                              @"house_type":_data[@"HXMC"],
                              @"floor_num":_data[@"FLOORNUM"],
                              @"orientation":@"1",
                              @"build_area":_data[@"JZMJ"],
                              @"name":_reportView.nameTF.textfield.text,
                              @"sex":_gender,
                              @"tel":_tel,
                              @"report_type":_reporterType,
                              };
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
    
    if (_address.length) {
        
        [dic setObject:[NSString stringWithFormat:@"%@%@",_address,_reportView.addressTV.text] forKey:@"address"];
    }
    
    if (_cardType.length) {
        
        [dic setObject:_cardType forKey:@"card_type"];
    }
    
    if (![self isEmpty:_reportView.numTF.textfield.text]) {
        
        [dic setObject:_reportView.numTF.textfield.text forKey:@"card_id"];
    }
    
    if (_wayView.otherBtn.selected) {
        
        [dic setObject:@"2" forKey:@"survey_type"];
    }else{
        
        [dic setObject:@"1" forKey:@"survey_type"];
    }
    
    if ([dic[@"survey_type"] integerValue] == 1) {
        
        if ([self isEmpty:_wayView.timeBtn.content.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择勘察时间"];
            return;
        }else{
            
            [dic setObject:_wayView.timeBtn.content.text forKey:@"survey_time"];
        }
    }
    
    if (![self isEmpty:_markText.text]) {
        
        [dic setObject:_markText.text forKey:@"comment"];
    }
    NSString *urlStr;
    if ([self.status isEqualToString:@"rent"]) {
        
        urlStr = RentRecord_URL;
    }else{
        
        urlStr = HouseRecord_URL;
    }
    
    [BaseRequest POST:urlStr parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self->_wayView.otherBtn.selected) {
                
                ReportSuccussView2 *view = [[ReportSuccussView2 alloc] initWithFrame:self.view.bounds];
                view.comName.text = [NSString stringWithFormat:@"小区名称：%@",self.comName];
                view.houseL.text = [NSString stringWithFormat:@"报备房号：%@%@%@",self->_data[@"LDMC"],self->_data[@"DYMC"],self->_data[@"FJMC"]];
                view.contactL.text = [NSString stringWithFormat:@"联系人：%@",self->_reportView.nameTF.textfield.text];
                view.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",self->_tel];
                view.timeL.text = [NSString stringWithFormat:@"报备时间：%@",[self->_formatter stringFromDate:[NSDate date]]];
                view.reportSuccussView2BackBlock = ^{
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[SecComRoomDetailVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }else if ([vc isKindOfClass:[RoomReportVC class]]){
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                };
                [self.view addSubview:view];
            }else{
                
                ReportSuccussView *view = [[ReportSuccussView alloc] initWithFrame:self.view.bounds];
                view.comName.text = [NSString stringWithFormat:@"小区名称：%@",self.comName];
                view.houseL.text = [NSString stringWithFormat:@"报备房号：%@%@%@",self->_data[@"LDMC"],self->_data[@"DYMC"],self->_data[@"FJMC"]];
                view.contactL.text = [NSString stringWithFormat:@"联系人：%@",self->_reportView.nameTF.textfield.text];
                view.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",self->_tel];
                view.timeL.text = [NSString stringWithFormat:@"报备时间：%@",[self->_formatter stringFromDate:[NSDate date]]];
                view.reportSuccussViewBackBlock = ^{
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[SecComRoomDetailVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }else if ([vc isKindOfClass:[RoomReportVC class]]){
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                };
                
                view.reportSuccussViewconfirmBlock = ^{
                    
                    CompleteSurveyInfoVC *nextVC = [[CompleteSurveyInfoVC alloc] initWithTitle:@"完成勘察信息"];
                    nextVC.completeSurveyInfoVCBlock = ^{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"comleteSurvey" object:nil];
                        [self RequestMethod];
                    };
                    nextVC.dataDic = resposeObject[@"data"];
                    nextVC.surveyId = resposeObject[@"data"][@"survey_id"];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                [self.view addSubview:view];
            }
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
    self.titleLabel.text = @"房源报备";
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_scrollView];
    
    _headerView = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _headerView.titleL.text = @"报备信息";
    [_scrollView addSubview:_headerView];
    
    _reportView = [[ReportView alloc] init];
    _reportView.comL.text = [NSString stringWithFormat:@"小区名称：(%@)%@",_city,self.comName];
    _reportView.roomL.text = [NSString stringWithFormat:@"报备房号：%@%@%@",_data[@"LDMC"],_data[@"DYMC"],_data[@"FJMC"]];
    _reportView.tel1.textfield.delegate = self;
    _reportView.tel2.textfield.delegate = self;
    _reportView.tel3.textfield.delegate = self;
    
    SS(strongSelf);
    WS(weakSelf);
    _reportView.reportViewRelationshipBlock = ^{
        
        SinglePickView *view = [[SinglePickView alloc]initWithFrame:weakSelf.view.frame WithData:[weakSelf getDetailConfigArrByConfigState:30]];
        
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            self->_reporterType = [NSString stringWithFormat:@"%@",ID];
            strongSelf->_reportView.relationBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        };
        [weakSelf.view addSubview:view];
    };
    
    _reportView.reportViewSexBlock = ^{
        
        [strongSelf->_reportView.tel1.textfield endEditing:YES];
        [strongSelf->_reportView.tel2.textfield endEditing:YES];
        [strongSelf->_reportView.tel3.textfield endEditing:YES];
        [strongSelf->_reportView.nameTF.textfield endEditing:YES];
        [strongSelf->_reportView.tel2.textfield endEditing:YES];
        [strongSelf->_reportView.numTF.textfield endEditing:YES];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self->_gender = @"1";
            strongSelf->_reportView.sexBtn.content.text = @"男";
        }];
        
        UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _gender = @"2";
            strongSelf->_reportView.sexBtn.content.text = @"女";
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:male];
        [alert addAction:female];
        [alert addAction:cancel];
        [weakSelf.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    };
    
    _reportView.reportViewAddBlock = ^{
        
        [strongSelf->_reportView.tel1.textfield endEditing:YES];
        [strongSelf->_reportView.tel2.textfield endEditing:YES];
        [strongSelf->_reportView.tel3.textfield endEditing:YES];
        [strongSelf->_reportView.nameTF.textfield endEditing:YES];
        [strongSelf->_reportView.tel2.textfield endEditing:YES];
        [strongSelf->_reportView.numTF.textfield endEditing:YES];
        
        if (_reportView.num == 0 ) {
            
            if ([weakSelf checkTel:strongSelf->_reportView.tel1.textfield.text]) {
                
                strongSelf->_reportView.num += 1;
                [strongSelf->_reportView.tel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(strongSelf->_reportView).offset(81 *SIZE);
                    make.top.equalTo(strongSelf->_reportView.tel1.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                strongSelf->_reportView.tel2.hidden = NO;
                
                
                [strongSelf->_reportView.typeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(strongSelf->_reportView).offset(10 *SIZE);
                    make.top.equalTo(strongSelf->_reportView.tel2.mas_bottom).offset(29 *SIZE);
                    make.width.mas_equalTo(70 *SIZE);
                }];
                
                [strongSelf->_reportView.typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(strongSelf->_reportView).offset(81 *SIZE);
                    make.top.equalTo(strongSelf->_reportView.tel2.mas_bottom).offset(19 *SIZE);
                    make.width.mas_equalTo(258 *SIZE);
                    make.height.mas_equalTo(33 *SIZE);
                }];
            }else{
                
                [weakSelf showContent:@"请填写正确的电话号码"];
            }
            
        }else{
            
            if ([strongSelf->_reportView.tel2.textfield.text isEqualToString:strongSelf->_reportView.tel1.textfield.text]) {
                
                [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请不要输入相同电话号码" WithDefaultBlack:^{
                    
                    
                }];
            }else{
                
                if ([weakSelf checkTel:strongSelf->_reportView.tel2.textfield.text]) {
                    
                    strongSelf->_reportView.num += 1;
                    [strongSelf->_reportView.tel3 mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_reportView).offset(81 *SIZE);
                        make.top.equalTo(strongSelf->_reportView.tel2.mas_bottom).offset(19 *SIZE);
                        make.width.equalTo(@(258 *SIZE));
                        make.height.equalTo(@(33 *SIZE));
                    }];
                    strongSelf->_reportView.tel3.hidden = NO;
                    
                    
                    [strongSelf->_reportView.typeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_reportView).offset(10 *SIZE);
                        make.top.equalTo(strongSelf->_reportView.tel3.mas_bottom).offset(29 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [strongSelf->_reportView.typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_reportView).offset(81 *SIZE);
                        make.top.equalTo(strongSelf->_reportView.tel3.mas_bottom).offset(19 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }else{
                    
                    [weakSelf showContent:@"请填写正确的电话号码"];
                }
            }
        }
    };
    
    _reportView.reportViewTypeBlock = ^{
        
        SinglePickView *view = [[SinglePickView alloc]initWithFrame:weakSelf.view.frame WithData:[weakSelf getDetailConfigArrByConfigState:2]];
        
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            _cardType = [NSString stringWithFormat:@"%@",ID];
            strongSelf->_reportView.typeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        };
        [weakSelf.view addSubview:view];
    };
    
    _reportView.reportViewAddressBlock = ^{
        
        AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:weakSelf.view.frame withdata:@[]];
        [strongSelf.view addSubview:view];
        view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
            
            //            _address = [NSString stringWithFormat:@"%@%@%@%@",proviceid]
            strongSelf->_reportView.addressBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
            _address = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
        };
    };
    [_scrollView addSubview:_reportView];
    
    _markText = [[UITextView alloc] init];
    _markText.font = [UIFont systemFontOfSize:12 *SIZE];
    [_scrollView addSubview:_markText];
    
    _wayView = [[ReportVew2 alloc] init];
    //    WS(weakSelf);
    __weak ReportVew2 *weekview = _wayView;
    _wayView.reportTimeBlock = ^{
        
        DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        [view.pickerView setMinimumDate:[NSDate date]];
        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:15];//设置最大时间为：当前时间推后10天
        [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {
            //        NSLog(@"%@",[self gettime:date]);
            weekview.timeBtn.content.text = [weakSelf gettime:date];
        };
        [weakSelf.view addSubview:view];
    };
    if (_isCheck) {
        
        [_scrollView addSubview:_wayView];
    }
    
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:YJBlueBtnColor];
    [_scrollView addSubview:_commitBtn];
    
    [self MasonryUI];
}

- (FailView *)failView{
    
    if (!_failView) {
        
        _failView = [[FailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _failView.statusL.text = @"报备失败";
        _failView.reasonL.textAlignment = NSTextAlignmentCenter;
    }
    return _failView;
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_reportView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_scrollView).offset(40 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        //        make.bottom.equalTo(_markText.mas_top).offset(-1 *SIZE);
    }];
    
    [_markText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0 *SIZE);
        make.top.equalTo(_reportView.mas_bottom).offset(1 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(100 *SIZE));
        //        make.bottom.equalTo(_wayView.mas_top).offset(-6 *SIZE);
    }];
    
    if (_isCheck) {
        
        [_wayView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(0 *SIZE);
            make.top.equalTo(_markText.mas_bottom).offset(1 *SIZE);
            make.right.equalTo(_scrollView).offset(0);
            make.width.equalTo(@(SCREEN_Width));
            make.height.equalTo(@(157 *SIZE));
            make.bottom.equalTo(_commitBtn.mas_top).offset(-25 *SIZE);
        }];
    }else{
        
        
    }
    
    
    if (_isCheck) {
        
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(22 *SIZE);
            make.top.equalTo(_wayView.mas_bottom).offset(25 *SIZE);
            make.width.equalTo(@(317 *SIZE));
            make.height.equalTo(@(40 *SIZE));
            make.bottom.equalTo(_scrollView).offset(-53 *SIZE);
        }];
    }else{
        
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(22 *SIZE);
            make.top.equalTo(_markText.mas_bottom).offset(25 *SIZE);
            make.width.equalTo(@(317 *SIZE));
            make.height.equalTo(@(40 *SIZE));
            make.bottom.equalTo(_scrollView).offset(-53 *SIZE);
        }];
    }
    
}

@end
