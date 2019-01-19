//
//  QuickAddCustomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "QuickAddCustomVC.h"

#import "QuickRoomVC.h"

#import "WorkerPickView.h"
#import "AdressChooseView.h"
#import "SinglePickView.h"
#import "DateChooseView.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

#import "CustomerInfoModel.h"
//#import "CustomerModel.h"


@interface QuickAddCustomVC ()<UITextFieldDelegate>
{
    NSInteger _numAdd;
    NSString *_projectId;
    BOOL _isHide;
    NSString *_tel4;
    NSString *_tel5;
    NSString *_tel6;
    NSString *_tel7;
    CustomerModel *_model;
    NSString *_clientId;
    NSMutableArray *_workArr;
    NSInteger _state;
    NSInteger _selected;
    NSString *_workId;
    NSString *_clientNeedId;
}
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *numclasslab;
@property (nonatomic, strong) UILabel *numlab;
@property (nonatomic, strong) UILabel *adresslab;
@property (nonatomic , strong) DropDownBtn *sex;
@property (nonatomic , strong) BorderTF *name;
@property (nonatomic , strong) DropDownBtn *birth;

@property (nonatomic, strong) UITextField *phoneTF1;

@property (nonatomic, strong) UITextField *phoneTF2;

@property (nonatomic, strong) UITextField *phoneTF3;

@property (nonatomic, strong) UITextField *phoneTF4;

@property (nonatomic, strong) UITextField *phoneTF5;

@property (nonatomic, strong) UITextField *phoneTF6;

@property (nonatomic, strong) UITextField *phoneTF7;

@property (nonatomic, strong) UITextField *phoneTF8;

@property (nonatomic, strong) UITextField *phoneTF9;

@property (nonatomic, strong) UITextField *phoneTF10;

@property (nonatomic, strong) UITextField *phoneTF11;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UIImageView *hideImg;

@property (nonatomic, strong) UILabel *hideReportL;

@property (nonatomic, strong) UIButton *hideBtn;

@property (nonatomic , strong) DropDownBtn *numclass;
@property (nonatomic , strong) BorderTF *num;
@property (nonatomic , strong) DropDownBtn *adress;
@property (nonatomic , strong) UITextView *detailadress;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) DropDownBtn *projectBtn;

@property (nonatomic, strong) UILabel *selectWorkerL;

@property (nonatomic, strong) DropDownBtn *selectWorkerBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic , strong) UIButton *surebtn;

@property (nonatomic, strong) WorkerPickView *workerPickView;

@end

@implementation QuickAddCustomVC

- (instancetype)initWithProjectId:(NSString *)projectId clientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        _clientId = clientId;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackgroundView.hidden = NO;
    
    [self initDataSouce];
    [self initUI];
    if (_projectId.length) {
        
        [self WorkSelectRequest];
    }
    
    if (_clientId.length) {
        
        self.titleLabel.text = @"客户信息";
        [self RequestMethod];
    }else{
        
        self.titleLabel.text = @"添加客户";
        _isHide = NO;
        _model = [[CustomerModel alloc] init];
    }
}

-(void)initDataSouce
{

    _workArr = [@[] mutableCopy];
}

- (void)WorkSelectRequest{
    
    [BaseRequest GET:ProjectAdvicer_URL parameters:@{@"project_id":_projectId} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            if ([resposeObject[@"data"][@"rows"] count]) {
                
                _workArr = [NSMutableArray arrayWithArray:[resposeObject[@"data"][@"rows"] mutableCopy]];
                _state = [resposeObject[@"data"][@"tel_complete_state"] integerValue];
                _selected = [resposeObject[@"data"][@"advicer_selected"] integerValue];
                if (_selected == 1) {
                    
                    _selectWorkerBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",_workArr[0][@"GSMC"],_workArr[0][@"RYXM"],_workArr[0][@"RYDH"]];
                    _workId = [NSString stringWithFormat:@"%@",_workArr[0][@"ID"]];
                }
            }else{
                
                _state = [resposeObject[@"data"][@"tel_complete_state"] integerValue];
                _selected = [resposeObject[@"data"][@"advicer_selected"] integerValue];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetCliendInfo_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        //        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                if ([resposeObject[@"data"][@"basic"] isKindOfClass:[NSDictionary class]]) {
                    
                    [self setCustomModel:resposeObject[@"data"][@"basic"]];
                    _clientNeedId = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"need_id"]];
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)setCustomModel:(NSDictionary *)dic{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            
            tempDic[key] = @"";
            
        }
        
    }];
    _model = [[CustomerModel alloc] initWithDictionary:tempDic];
    
    _isHide = [_model.is_hide_tel boolValue];
    if (!_isHide) {
        
        _phoneTF4.userInteractionEnabled = NO;
        _phoneTF5.userInteractionEnabled = NO;
        _phoneTF6.userInteractionEnabled = NO;
        _phoneTF7.userInteractionEnabled = NO;
        
        _hideReportL.text = @"当前显号报备";
        _hideL.text = @"需要补全电话号码";
        _hideImg.image = [UIImage imageNamed:@"eye_2"];
    }else{
        
        _hideReportL.text = @"当前隐号报备";
    }
    _name.textfield.text = _model.name;
    if ([_model.sex integerValue] == 1) {
        
        _sex.content.text = @"男";
    }else if ([_model.sex integerValue] == 2){
        
        _sex.content.text = @"女";
    }
    if (_model.birth.length) {
        
        _birth.content.text = _model.birth;
    }
    NSArray *telArr = [_model.tel componentsSeparatedByString:@","];
    if (telArr.count) {
        
        _phoneTF1.text = [telArr[0] substringWithRange:NSMakeRange(0, 1)];
    }
    if (telArr.count) {
        
        _phoneTF2.text = [telArr[0] substringWithRange:NSMakeRange(1, 1)];
    }
    if (telArr.count) {
        
        _phoneTF3.text = [telArr[0] substringWithRange:NSMakeRange(2, 1)];
    }
    if (telArr.count) {
        
        _tel4 = [telArr[0] substringWithRange:NSMakeRange(3, 1)];

        if (_isHide) {
            
            _phoneTF4.text = @"*";
        }else{
            
            _phoneTF4.text = _tel4;
        }
    }else{
        
        if (_isHide) {
            
            _phoneTF4.text = @"*";
        }else{
            
            _phoneTF4.text = _tel4;
        }
    }
    
    if (telArr.count) {
        
        _tel5 = [telArr[0] substringWithRange:NSMakeRange(4, 1)];

        if (_isHide) {
            
            _phoneTF5.text = @"*";
        }else{
            
            _phoneTF5.text = _tel5;
        }
    }else{
        
        if (_isHide) {
            
            _phoneTF5.text = @"*";
        }else{
            
            _phoneTF5.text = _tel5;
        }
    }
    
    if (telArr.count) {
        
        _tel6 = [telArr[0] substringWithRange:NSMakeRange(5, 1)];
        
        if (_isHide) {
            
            _phoneTF6.text = @"*";
        }else{
            
            _phoneTF6.text = _tel6;
        }
    }else{
        
        if (_isHide) {
            
            _phoneTF6.text = @"*";
        }else{
            
            _phoneTF6.text = _tel6;
        }
    }
    
    if (telArr.count) {
        
        _tel7 = [telArr[0] substringWithRange:NSMakeRange(6, 1)];

        if (_isHide) {
            
            _phoneTF7.text = @"*";
        }else{
            
            _phoneTF7.text = _tel7;
        }
    }else{
        
        if (_isHide) {
            
            _phoneTF7.text = @"*";
        }else{
            
            _phoneTF7.text = _tel7;
        }
    }
    
    if (telArr.count) {
        
        _phoneTF8.text = [telArr[0] substringWithRange:NSMakeRange(7, 1)];
    }
    if (telArr.count) {
        
        _phoneTF9.text = [telArr[0] substringWithRange:NSMakeRange(8, 1)];
    }
    if (telArr.count) {
        
        _phoneTF10.text = [telArr[0] substringWithRange:NSMakeRange(9, 1)];
    }
    if (telArr.count) {
        
        _phoneTF11.text = [telArr[0] substringWithRange:NSMakeRange(10, 1)];
    }
    if (_model.card_type.length) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",2]];
        NSArray *typeArr = dic[@"param"];
        for (NSUInteger i = 0; i < typeArr.count; i++) {
            
            if ([typeArr[i][@"param"] isEqualToString:_model.card_type]) {
                
                _model.card_type = typeArr[i][@"id"];
                _numclass.content.text = typeArr[i][@"param"];
                break;
            }
        }
    }
    if (_model.card_id) {
        
        _num.textfield.text = _model.card_id;
    }
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&err];
    
    if (_model.province && _model.city && _model.district) {
        
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [_model.province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (NSUInteger j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [_model.city integerValue]){
                        
                        NSArray *area = city[j][@"district"];
                        
                        for (NSUInteger k = 0; k < area.count; k++) {
                            
                            if([area[k][@"code"] integerValue] == [_model.district integerValue]){
                                
                                _adress.content.text = [NSString stringWithFormat:@"%@-%@-%@",provice[i][@"name"],city[j][@"name"],area[k][@"name"]];
                                _model.province = _model.province;
                                _model.city = _model.city;
                                _model.district = _model.district;
                            }
                        }
                    }
                }
            }
        }
    }else if (_model.province && _model.city){
        
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [_model.province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (NSUInteger j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [_model.city integerValue]){
                        
                        _adress.content.text = [NSString stringWithFormat:@"%@-%@",provice[i][@"name"],city[j][@"name"]];
                        _model.province = _model.province;
//                        _model.city = _model.city;
                    }
                }
            }
        }
    }else if (_model.province){
        
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [_model.province integerValue]){
                
                _adress.content.text = [NSString stringWithFormat:@"%@",provice[i][@"name"]];
//                _model.province = _model.province;
            }
        }
    }else{
        
        
    }
    if (_model.address) {
        
        _detailadress.text = _model.address;
    }
}

- (void)ActionHideBtn:(UIButton *)btn{
    
    _isHide = !_isHide;
    if (!_isHide) {
        
        _phoneTF4.userInteractionEnabled = YES;
        _phoneTF5.userInteractionEnabled = YES;
        _phoneTF6.userInteractionEnabled = YES;
        _phoneTF7.userInteractionEnabled = YES;
        
        _phoneTF4.text = _tel4;
        _phoneTF5.text = _tel5;
        _phoneTF6.text = _tel6;
        _phoneTF7.text = _tel7;
        _hideReportL.text = @"当前显号报备";
        _hideImg.image = [UIImage imageNamed:@"eye_2"];
        _hideL.text = @"需要补全电话号码";
    }else{
        
        _phoneTF4.userInteractionEnabled = NO;
        _phoneTF5.userInteractionEnabled = NO;
        _phoneTF6.userInteractionEnabled = NO;
        _phoneTF7.userInteractionEnabled = NO;
        
        _phoneTF4.text = @"*";
        _phoneTF5.text = @"*";
        _phoneTF6.text = @"*";
        _phoneTF7.text = @"*";
        _hideReportL.text = @"当前隐号报备";
        _hideL.text = @"只需输入手机号前三位后四位";
        _hideImg.image = [UIImage imageNamed:@"eye"];
    }
}

- (void)ActionProBtn:(UIButton *)btn{
    
    QuickRoomVC *nextVC = [[QuickRoomVC alloc] init];
    nextVC.ways = @"quickAdd";
    nextVC.quickRoomVCSelectBlock = ^(NSString *projectId, NSString *projectName) {

        _projectBtn.content.text = projectName;
        _projectId = [NSString stringWithFormat:@"%@",projectId];
        _projectBtn->str = [NSString stringWithFormat:@"%@",projectId];
        [self WorkSelectRequest];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionWorkerBtn:(UIButton *)btn{
    
    if (_projectId.length) {
        
        if (_workArr.count) {
            
            WorkerPickView *view = [[WorkerPickView alloc] initWithFrame:self.view.bounds WithData:_workArr];
            view.workerPickBlock = ^(NSString *GSMC, NSString *ID, NSString *RYBH, NSString *RYDH, NSString *RYXM, NSString *RYTP) {
                
                _selectWorkerBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",GSMC,RYXM,RYDH];
                _workId = [NSString stringWithFormat:@"%@",ID];

            };
            [self.view addSubview:view];
        }else{
            
            
        }

    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择项目"];
    }
}

#pragma mark -- TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length) {
        
        if ([string isEqualToString:@""]) {
            
            if (textField == _phoneTF1) {
                
                [_phoneTF1 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                if (_phoneTF2.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF1 becomeFirstResponder];
                }
            }else if (textField == _phoneTF3) {
                
                if (_phoneTF3.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF2 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                if (_phoneTF4.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF3 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF5) {
                
                if (_phoneTF5.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF6) {
                
                if (_phoneTF6.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF5 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF7) {
                
                if (_phoneTF7.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF6 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF8) {
                
                if (_phoneTF8.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF7 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF9) {
                
                if (_phoneTF9.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF8 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF10) {
                
                if (_phoneTF10.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF9 becomeFirstResponder];
                }
            }else if (textField == _phoneTF11) {
                
                if (_phoneTF11.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF10 becomeFirstResponder];
                }
            }
        }else{
            
            if (textField == _phoneTF1) {
                
                _phoneTF1.text = string;
                [_phoneTF2 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                _phoneTF2.text = string;
                [_phoneTF3 becomeFirstResponder];
            }else if (textField == _phoneTF3) {
                
                _phoneTF3.text = string;
                if (_isHide) {
                    
                    [_phoneTF8 becomeFirstResponder];
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                _phoneTF4.text = string;
                _tel4 = string;
                [_phoneTF5 becomeFirstResponder];
            }
            else if (textField == _phoneTF5) {
                
                _phoneTF5.text = string;
                _tel5 = string;
                [_phoneTF6 becomeFirstResponder];
            }
            else if (textField == _phoneTF6) {
                
                _phoneTF6.text = string;
                _tel6 = string;
                [_phoneTF7 becomeFirstResponder];
            }
            else if (textField == _phoneTF7) {
                
                _phoneTF7.text = string;
                _tel7 = string;
                [_phoneTF8 becomeFirstResponder];
            }
            else if (textField == _phoneTF8) {
                
                _phoneTF8.text = string;
                [_phoneTF9 becomeFirstResponder];
            }
            else if (textField == _phoneTF9) {
                
                _phoneTF9.text = string;
                [_phoneTF10 becomeFirstResponder];
            }
            else if (textField == _phoneTF10) {
                
                _phoneTF10.text = string;
                [_phoneTF11 becomeFirstResponder];
            }else if (textField == _phoneTF11) {
                
                _phoneTF11.text = string;
                [_phoneTF11 endEditing:YES];
            }
        }
    }else{
        
        if ([string isEqualToString:@""]) {
            
            if (textField == _phoneTF1) {
                
                [_phoneTF1 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                if (_phoneTF2.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF1 becomeFirstResponder];
                }
            }else if (textField == _phoneTF3) {
                
                if (_phoneTF3.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF2 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                if (_phoneTF4.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF3 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF5) {
                
                if (_phoneTF5.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF6) {
                
                if (_phoneTF6.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF5 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF7) {
                
                if (_phoneTF7.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF6 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF8) {
                
                if (_phoneTF8.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF7 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF9) {
                
                if (_phoneTF9.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF8 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF10) {
                
                if (_phoneTF10.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF9 becomeFirstResponder];
                }
            }else if (textField == _phoneTF11) {
                
                if (_phoneTF11.text.length) {
                    
                    
                }else{
                    
                    [_phoneTF10 becomeFirstResponder];
                }
            }
        }else{
            
            if (textField == _phoneTF1) {
                
                _phoneTF1.text = string;
                [_phoneTF2 becomeFirstResponder];
            }else if (textField == _phoneTF2) {
                
                _phoneTF2.text = string;
                [_phoneTF3 becomeFirstResponder];
            }else if (textField == _phoneTF3) {
                
                _phoneTF3.text = string;
                if (_isHide) {
                    
                    [_phoneTF8 becomeFirstResponder];
                }else{
                    
                    [_phoneTF4 becomeFirstResponder];
                }
            }
            else if (textField == _phoneTF4) {
                
                _phoneTF4.text = string;
                _tel4 = string;
                [_phoneTF5 becomeFirstResponder];
            }
            else if (textField == _phoneTF5) {
                
                _phoneTF5.text = string;
                _tel5 = string;
                [_phoneTF6 becomeFirstResponder];
            }
            else if (textField == _phoneTF6) {
                
                _phoneTF6.text = string;
                _tel6 = string;
                [_phoneTF7 becomeFirstResponder];
            }
            else if (textField == _phoneTF7) {
                
                _phoneTF7.text = string;
                _tel7 = string;
                [_phoneTF8 becomeFirstResponder];
            }
            else if (textField == _phoneTF8) {
                
                _phoneTF8.text = string;
                [_phoneTF9 becomeFirstResponder];
            }
            else if (textField == _phoneTF9) {
                
                _phoneTF9.text = string;
                [_phoneTF10 becomeFirstResponder];
            }
            else if (textField == _phoneTF10) {
                
                _phoneTF10.text = string;
                [_phoneTF11 becomeFirstResponder];
            }else if (textField == _phoneTF11) {
                
                _phoneTF11.text = string;
                [_phoneTF11 endEditing:YES];
            }
        }
    }

    return YES;
}


-(void)initUI
{
    
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollview.contentSize = CGSizeMake(360*SIZE, 680*SIZE);
    _scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollview];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    // 顶部
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = YJBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = YJTitleLabColor;
    title.text = @"客户信息";
    [backview addSubview:title];
    [_scrollview addSubview:backview];
    
    //姓名
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    namelab.text = @"姓名:";
    namelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    namelab.textColor = YJTitleLabColor;
    [_scrollview addSubview:namelab];
    _name = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 46*SIZE, 116.7*SIZE, 33.3*SIZE)];
    _name.textfield.placeholder = @"必填";
    [_scrollview addSubview:_name];
    
    //性别
    UILabel *sexlab = [[UILabel alloc]initWithFrame:CGRectMake(208.7*SIZE, 56*SIZE, 100*SIZE, 14*SIZE)];
    sexlab.text = @"性别:";
    sexlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    sexlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:sexlab];
    _sex = [[DropDownBtn alloc]initWithFrame:CGRectMake(251.3*SIZE, 46*SIZE, 86.7*SIZE, 33.3*SIZE)];

    [_sex addTarget:self action:@selector(action_sex) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_sex];
    
    //出生日期
    UILabel *brithlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 106*SIZE, 100*SIZE, 14*SIZE)];
    brithlab.text = @"出生日期:";
    brithlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    brithlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:brithlab];
    _birth = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 96*SIZE, 257.7*SIZE, 33.3*SIZE)];

    [_birth addTarget:self action:@selector(action_brith) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_birth];
    
    //电话
    UILabel *tellab1 = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 169*SIZE, 100*SIZE, 14*SIZE)];
    tellab1.text = @"联系号码:";
    tellab1.font = [UIFont systemFontOfSize:13.3*SIZE];
    tellab1.textColor = YJTitleLabColor;
    [_scrollview addSubview:tellab1];
    
    for (int i = 0; i < 11; i++) {
        
        UITextField *borderTF = [[UITextField alloc] initWithFrame:CGRectMake(80 *SIZE, 75 *SIZE, 19 *SIZE, 24 *SIZE)];
        borderTF.textColor = YJContentLabColor;
        borderTF.keyboardType = UIKeyboardTypePhonePad;
        borderTF.font = [UIFont systemFontOfSize:13.3*SIZE];
        borderTF.layer.cornerRadius = 5*SIZE;
        borderTF.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        borderTF.layer.borderWidth = 1*SIZE;
        borderTF.textAlignment = NSTextAlignmentCenter;
     
        switch (i) {
            case 0:
            {
                _phoneTF1 = borderTF;
                _phoneTF1.delegate = self;

                [_scrollview addSubview:_phoneTF1];
                break;
            }
            case 1:
            {
                _phoneTF2 = borderTF;
                _phoneTF2.delegate = self;

                [_scrollview addSubview:_phoneTF2];
                break;
            }
            case 2:
            {
                _phoneTF3 = borderTF;
                _phoneTF3.delegate = self;

                [_scrollview addSubview:_phoneTF3];
                break;
            }
            case 3:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF4 = borderTF;
                _phoneTF4.delegate = self;
                
                [_scrollview addSubview:_phoneTF4];
                break;
            }
            case 4:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF5 = borderTF;
                _phoneTF5.delegate = self;
                
                [_scrollview addSubview:_phoneTF5];
                break;
            }
            case 5:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF6 = borderTF;
                _phoneTF6.delegate = self;
                
                [_scrollview addSubview:_phoneTF6];
                break;
            }
            case 6:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF7 = borderTF;
                _phoneTF7.delegate = self;
                
                [_scrollview addSubview:_phoneTF7];
                break;
            }
            case 7:
            {
                _phoneTF8 = borderTF;
                _phoneTF8.delegate = self;
                
                [_scrollview addSubview:_phoneTF8];
                break;
            }
            case 8:
            {
                _phoneTF9 = borderTF;
                _phoneTF9.delegate = self;
                
                [_scrollview addSubview:_phoneTF9];
                break;
            }
            case 9:
            {
                _phoneTF10 = borderTF;
                _phoneTF10.delegate = self;
                
                [_scrollview addSubview:_phoneTF10];
                break;
            }
            case 10:
            {
                _phoneTF11 = borderTF;
                _phoneTF11.delegate = self;
                
                [_scrollview addSubview:_phoneTF11];
                break;
            }
            default:
                break;
        }
    }
    
    for(int i = 0; i < 2; i++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                
                _hideL = label;
                _hideL.font = [UIFont systemFontOfSize:11 *SIZE];
                _hideL.textColor = YJ170Color;
                _hideL.text = @"只需输入手机号前三位后四位";
                [_scrollview addSubview:_hideL];
                break;
            }
            case 1:
            {
                _hideReportL = label;
                _hideReportL.font = [UIFont systemFontOfSize:10 *SIZE];
                _hideReportL.textColor = COLOR(255, 165, 29, 1);
                _hideReportL.text = @"当前隐号报备";
                [_scrollview addSubview:_hideReportL];
                break;
            }
        }
    }
    
    _hideImg = [[UIImageView alloc] init];
    _hideImg.image = [UIImage imageNamed:@"eye"];
    [_scrollview addSubview:_hideImg];
    
    _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hideBtn addTarget:self action:@selector(ActionHideBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_hideBtn];
    
    //证件类型
    _numclasslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 306*SIZE, 100*SIZE, 14*SIZE)];
    _numclasslab.text = @"证件类型:";
    _numclasslab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _numclasslab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_numclasslab];
    
    _numclass = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 296*SIZE, 257.7*SIZE, 33.3*SIZE)];
    
    [_numclass addTarget:self action:@selector(action_numclass) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_numclass];
    
    //证件号
    _numlab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 356*SIZE, 100*SIZE, 14*SIZE)];
    
    _numlab.text = @"证件号:";
    _numlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _numlab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_numlab];
    
    _num = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 346*SIZE, 257.7*SIZE, 33.3*SIZE)];

    _num.textfield.keyboardType = UIKeyboardTypeDefault;
    [_scrollview addSubview:_num];
    
    //地址
    _adresslab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 406*SIZE, 100*SIZE, 14*SIZE)];
    _adresslab.text = @"地址:";
    _adresslab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _adresslab.textColor = YJTitleLabColor;
    [_scrollview addSubview:_adresslab];
    
    _adress = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 396*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_adress addTarget:self action:@selector(action_address) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollview addSubview:_adress];
    
    
    _detailadress = [[UITextView alloc]initWithFrame:CGRectMake(90.3*SIZE,456*SIZE, 237.7*SIZE, 66.7*SIZE)];
    _detailadress.textColor = YJTitleLabColor;
    _detailadress.layer.cornerRadius = 5 *SIZE;
    _detailadress.clipsToBounds = YES;
    _detailadress.layer.borderWidth = SIZE;
    _detailadress.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _detailadress.font = [UIFont systemFontOfSize:13.3*SIZE];
    
    [_scrollview addSubview:_detailadress];
    
    [_scrollview addSubview:self.surebtn];
    
    _projectL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 556*SIZE, 100*SIZE, 14*SIZE)];
    _projectL.text = @"项目名称:";
    _projectL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _projectL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_projectL];
    
    _projectBtn = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 546*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_projectBtn addTarget:self action:@selector(ActionProBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_projectId.length) {
        
        _projectBtn.backgroundColor = YJBackColor;
        _projectBtn.userInteractionEnabled = NO;
        _projectBtn.content.text = self.projectName;
    }
    [_scrollview addSubview:_projectBtn];
    
    _selectWorkerL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 556*SIZE, 100*SIZE, 14*SIZE)];
    _selectWorkerL.text = @"置业顾问:";
    _selectWorkerL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _selectWorkerL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_selectWorkerL];
    
    _selectWorkerBtn = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 546*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_selectWorkerBtn addTarget:self action:@selector(ActionWorkerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_selectWorkerBtn];
    
    [_scrollview addSubview:self.surebtn];
    
    _markL = [[UILabel alloc] init];
    _markL.textColor = YJTitleLabColor;
    _markL.font = [UIFont systemFontOfSize:13 *SIZE];
    _markL.text = @"备注";
    [_scrollview addSubview:_markL];
    
    _markTV = [[UITextView alloc] init];
    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markTV.layer.borderWidth = 1 *SIZE;
    _markTV.layer.cornerRadius = 5 *SIZE;
    _markTV.clipsToBounds = YES;
    [_scrollview addSubview:_markTV];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_phoneTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(81 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF1.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF2.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF3.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF4.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF5.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF6.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF7.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF9 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF8.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF10 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF9.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF11 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneTF10.mas_right).offset(4 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_hideL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_hideImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(251 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(6 *SIZE);
    }];
    
    [_hideReportL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(279 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(266 *SIZE);
        make.top.equalTo(_phoneTF1.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_numclasslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_hideReportL.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_numclass mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_hideReportL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(257 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_numclass.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_numclass.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_adresslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_num.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_adress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_num.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_detailadress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_adress.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(77 *SIZE));
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_detailadress.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_projectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_detailadress.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_selectWorkerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_projectBtn.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_selectWorkerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_projectBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_selectWorkerBtn.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_selectWorkerBtn.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(77 *SIZE));
    }];
    
    [self.surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(22 *SIZE);
        make.top.equalTo(_markTV.mas_bottom).offset(43 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollview.mas_bottom).offset(-53 *SIZE);
    }];
}

-(void)action_sex
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"男";
        _model.sex = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"女";
        _model.sex =@"2";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

-(void)action_brith
{
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
        //        NSLog(@"%@",[self gettime:date]);
        _birth.content.text = [self gettime:date];
        _model.birth =_birth.content.text;
//        _Customerinfomodel.birth = _birth.content.text;
    };
    [self.view addSubview:view];
}

-(void)action_numclass
{
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:CARD_TYPE]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        _numclass.content.text = MC;
//        _Customerinfomodel.card_type = ID;
        _model.card_type = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

-(void)action_address
{
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        self.adress.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
        
        _model.province = proviceid;
        _model.city = cityid;
        _model.district = areaid;
    };
}

-(void)action_sure
{
    if (_name.textfield.text.length == 0 || [self isEmpty:_name.textfield.text]) {
        
        [self showContent:@"请输入姓名！"];
        return;
    }
    
    NSString *tel;
    if (!_phoneTF1.text.length || !_phoneTF2.text.length || !_phoneTF3.text.length || !_phoneTF8.text.length || !_phoneTF9.text.length || !_phoneTF10.text.length || !_phoneTF11.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"电话号码不完整"];
    }else{
        
        if (!_phoneTF4.text.length) {
            
            _phoneTF4.text = @"*";
        }
        if (!_phoneTF5.text.length){
            
            _phoneTF5.text = @"*";
        }
        if (!_phoneTF6.text.length){
            
            _phoneTF6.text = @"*";
        }
        if (!_phoneTF7.text.length){
            
            _phoneTF7.text = @"*";
        }
        
        if ([_phoneTF4.text isEqualToString:@"*"] || [_phoneTF5.text isEqualToString:@"*"] || [_phoneTF6.text isEqualToString:@"*"] || [_phoneTF7.text isEqualToString:@"*"]) {
            
            _phoneTF4.text = @"*";
            _phoneTF5.text = @"*";
            _phoneTF6.text = @"*";
            _phoneTF7.text = @"*";
            
            if (!_tel4.length) {
                
                _tel4 = @"0";
            }
            if (!_tel5.length) {
                
                _tel5 = @"0";
            }
            if (!_tel6.length) {
                
                _tel6 = @"0";
            }
            if (!_tel7.length) {
                
                _tel7 = @"0";
            }
        }
        
        tel = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",_phoneTF1.text,_phoneTF2.text,_phoneTF3.text,_tel4,_tel5,_tel6,_tel7,_phoneTF8.text,_phoneTF9.text,_phoneTF10.text,_phoneTF11.text];

    }
    
    _model.name = _name.textfield.text;
    _model.birth = _birth.content.text;
    _model.tel = tel;
    _model.card_id = _num.textfield.text;
    _model.address = _detailadress.text;
    _model.is_hide_tel = [NSString stringWithFormat:@"%ld",[[NSNumber numberWithBool:_isHide] integerValue]];
    if (_state == 0 && _isHide) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"此项目需要显号报备，请补全电话号码"];
        return;
    }else{
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_model modeltodic]];
        if (_clientId.length) {
            
            [dic setObject:_clientId forKey:@"client_id"];
            [dic setObject:_clientNeedId forKey:@"client_need_id"];
        }
        if (_workId.length) {
            
            [dic setObject:_workId forKey:@"consultant_advicer_id"];
        }
        if (_projectId.length) {
            
            [dic setObject:_projectId forKey:@"project_id"];
        }
        if (![self isEmpty:_markTV.text]) {
            
            [dic setObject:_markTV.text forKey:@"comment"];
        }
        
        [dic removeObjectForKey:@"client_property_type"];
        [dic removeObjectForKey:@"client_type"];
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            NSString *str = [NSString stringWithFormat:@"%@",obj];
            if (!str.length) {
                
                [dic removeObjectForKey:key];
            }
        }];
//        NSString *birthStr = ;
        if ([dic[@"birth"] isEqualToString:@"0000-00-00"]) {
            
            [dic removeObjectForKey:@"birth"];
        }
////        if (![dic[@"birth"] length]) {
////
////            [dic removeObjectForKey:@"birth"];
////        }

        [BaseRequest POST:AddAndRecommend_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"恭喜" And:@"推荐成功" WithDefaultBlack:^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"matchReload" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }
}


-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame =  CGRectMake(20*SIZE, 566*SIZE, 320*SIZE, 40*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = 1.7*SIZE;
        
        [_surebtn setTitle:@"下一步" forState:UIControlStateNormal];
        
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:15.3*SIZE];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}

@end
