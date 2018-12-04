//
//  RentingCompleteSurveyInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyInfoVC.h"

//#import "CompleteSurveyStoreVC.h"
//#import "CompleteSurveyOfficeVC.h"
#import "RentingCompleteSurveyHouseVC.h"

//#import "SinglePickView.h"

//#import "SingleContentCell.h"
#import "BaseFrameHeader.h"
//#import "CompleteSurveyCollCell.h"

#import "BorderTF.h"
#import "DropDownBtn.h"

@interface RentingCompleteSurveyInfoVC ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSString *_titleStr;
    
    NSArray *_titleArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *codeView;

@property (nonatomic, strong) BaseFrameHeader *codeHeader;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseFrameHeader *titleHeader;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropDownBtn *addressBtn;

@property (nonatomic, strong) DropDownBtn *addressBtn1;

@property (nonatomic, strong) BorderTF *addressTF;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) BorderTF *roomNumTF;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTF *areaTF;

@property (nonatomic, strong) UILabel *buildYearL;

@property (nonatomic, strong) BorderTF *buildYearTF;

@property (nonatomic, strong) UILabel *proLimitL;

@property (nonatomic, strong) BorderTF *proLimitTF;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) BorderTF *intentTF;

@property (nonatomic, strong) UISlider *intentSlider;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) BorderTF *urgentTF;

@property (nonatomic, strong) UISlider *urgentSlider;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingCompleteSurveyInfoVC

- (instancetype)initWithTitle:(NSString *)titleStr
{
    self = [super init];
    if (self) {
        
        _titleStr = titleStr;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"项目地址",@"房号",@"物业类型",@"面积",@"建成年代",@"产权年限",@"卖房意愿度",@"卖房急迫度"];
    
    if (self.surveyId) {
        
        [self RequestMethod];
    }else{
        
        [self RequestAddressMethod];
    }
}

- (void)RequestAddressMethod{
    
    [BaseRequest GET:HouseProjectAddressInfo_URL parameters:@{@"project_id":self.projectID} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _addressBtn.content.text = resposeObject[@"data"][@"city_name"];
            _addressBtn1.content.text = resposeObject[@"data"][@"district_name"];
            _addressTF.textfield.text = resposeObject[@"data"][@"absolute_address"];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseRecordSurveyNeedInfo_URL parameters:@{@"survey_id":self.surveyId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSDictionary *)dic{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }else{
            
            [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }
    }];
    _addressBtn.content.text = tempDic[@"city_name"];
    _addressBtn1.content.text = tempDic[@"district_name"];
    _addressTF.textfield.text = tempDic[@"absolute_address"];
    _roomNumTF.textfield.text = [NSString stringWithFormat:@"%@%@%@",tempDic[@"build_name"],tempDic[@"unit_name"],tempDic[@"house_name"]];
    _typeBtn.content.text = tempDic[@"property_type"];
    _areaTF.textfield.text = tempDic[@"build_area"];
    _buildYearTF.textfield.text = tempDic[@""];
    _proLimitTF.textfield.text = tempDic[@""];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    [_intentTF endEditing:YES];
    [_urgentTF endEditing:YES];
    
    if (!_intentTF.textfield.text) {
        
        return;
    }
    if (!_urgentTF.textfield.text) {
        
        return;
    }
    
    NSMutableDictionary *tempDic;
    if (self.surveyId) {
        tempDic = [NSMutableDictionary dictionaryWithDictionary:@{@"survey_id":self.surveyId,
                                                                  @"intent":_intentTF.textfield.text,
                                                                  @"urgency":_urgentTF.textfield.text,
                                                                  @"property_limit":@"60"
                                                                  }];
    }else{
        
        NSString *str;
        if ([self.dataDic[@"JZMJ"] length]) {
            
            str = self.dataDic[@"JZMJ"];
        }else{
            
            str = @"0";
        }
        NSDictionary *dic = @{@"project_id":self.projectID,
                              @"build_id":self.buildId,
                              @"build_name":self.dataDic[@"LDMC"],
                              @"unit_id":self.unitId,
                              @"unit_name":self.dataDic[@"DYMC"],
                              @"house_id":self.dataDic[@"FJID"],
                              @"house_name":self.dataDic[@"FJMC"],
                              @"property_type":self.dataDic[@"WYMC"],
                              @"house_type":self.dataDic[@"HXMC"],
                              @"floor_num":self.dataDic[@"FLOORNUM"],
                              @"orientation":@"1",
                              @"build_area":str,
                              @"intent":_intentTF.textfield.text,
                              @"urgency":_urgentTF.textfield.text,
                              @"property_limit":@"60",
                              @"name":self.dataDic[@"name"],
                              @"sex":self.dataDic[@"sex"],
                              @"tel":self.dataDic[@"tel"],
                              @"report_type":self.dataDic[@"report_type"]
                              };
        tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    
    NSString *str = self.dataDic[@"property_type"];
    if ([self.status isEqualToString:@"direct"]) {
        
        str = self.dataDic[@"WYMC"];
    }
    if ([str containsString:@"参数"]) {
        
        str = [str stringByReplacingOccurrencesOfString:@"参数" withString:@""];
    }
    if ([str isEqualToString:@"写字楼"]) {
        
//        CompleteSurveyOfficeVC *nextVC = [[CompleteSurveyOfficeVC alloc] initWithTitle:@"完成勘察信息"];
//        nextVC.completeSurveyOfficeBlock = ^{
//
//            if (self.completeSurveyInfoVCBlock) {
//
//                self.completeSurveyInfoVCBlock();
//            }
//        };
//        nextVC.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([str isEqualToString:@"商铺"]){
        
//        CompleteSurveyStoreVC *nextVC = [[CompleteSurveyStoreVC alloc] initWithTitle:@"完成勘察信息"];
//        nextVC.completeSurveyStoreVCBlock = ^{
//
//            if (self.completeSurveyInfoVCBlock) {
//
//                self.completeSurveyInfoVCBlock();
//            }
//        };
//        nextVC.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        RentingCompleteSurveyHouseVC *nextVC = [[RentingCompleteSurveyHouseVC alloc] initWithTitle:@"完成勘察信息"];
        nextVC.rentingCompleteSurveyHouseVCBlock = ^{
            
            if (self.rentingCompleteSurveyInfoVCBlock) {
                
                self.rentingCompleteSurveyInfoVCBlock();
            }
        };
        nextVC.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
}

- (void)ActionSliderChange:(UISlider *)slider{
    
    if (slider == _intentSlider) {
        
        _intentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }else{
        
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%.0f",slider.value];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _intentTF.textfield) {
        
        if ([_intentTF.textfield.text integerValue] > 100) {
            
            _intentTF.textfield.text = @"100";
        }
        _intentTF.textfield.text = [NSString stringWithFormat:@"%ld",[_intentTF.textfield.text integerValue]];
        _intentSlider.value =  [_intentTF.textfield.text floatValue] / 100.0 * 100;
    }else if (textField == _urgentTF.textfield){
        
        if ([_urgentTF.textfield.text integerValue] > 100) {
            
            _urgentTF.textfield.text = @"100";
        }
        _urgentTF.textfield.text = [NSString stringWithFormat:@"%ld",[_urgentTF.textfield.text integerValue]];
        _urgentSlider.value =  [_urgentTF.textfield.text floatValue] / 100.0 * 100;
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = _titleStr;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _codeView = [[UIView alloc] init];
    _codeView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_codeView];
    
    _codeHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    if ([self.status isEqualToString:@"direct"]) {
        
        _codeHeader.titleL.text = [NSString stringWithFormat:@"房源：%@%@%@",self.comName,self.dataDic[@"LDMC"],self.dataDic[@"FJMC"]];
        //        _codeHeader.titleL.text = [NSString stringWithFormat:@"房源编号：%@",_dataDic[@"house_code"]];
    }else{
        
        _codeHeader.titleL.text = [NSString stringWithFormat:@"房源编号：%@",_dataDic[@"house_code"]];
    }
    [_codeView addSubview:_codeHeader];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.font = [UIFont systemFontOfSize:13*SIZE];
    _sourceL.numberOfLines = 0;
    if ([self.dataDic[@"is_other"] integerValue] == 1) {
        
        _sourceL.text = @"来源：自行勘察";
    }else{
        
        if ([self.status isEqualToString:@"direct"]) {
            
            _sourceL.text = @"来源：自行勘察";
        }else{
            
            _sourceL.text = @"来源：勘察抢单";
        }
    }
    _sourceL.textColor = YJ86Color;
    [_codeView addSubview:_sourceL];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_contentView];
    
    _titleHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _titleHeader.titleL.text = @"房源信息";
    [_contentView addSubview:_titleHeader];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = _titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _addressL = label;
                [_contentView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _roomNumL = label;
                [_contentView addSubview:_roomNumL];
                break;
            }
            case 2:
            {
                _typeL = label;
                [_contentView addSubview:_typeL];
                break;
            }
            case 3:
            {
                _areaL = label;
                [_contentView addSubview:_areaL];
                break;
            }
            case 4:
            {
                _buildYearL = label;
                [_contentView addSubview:_buildYearL];
                break;
            }
            case 5:
            {
                _proLimitL = label;
                [_contentView addSubview:_proLimitL];
                break;
            }
            case 6:
            {
                _intentL = label;
                [_contentView addSubview:_intentL];
                break;
            }
            case 7:
            {
                _urgentL = label;
                [_contentView addSubview:_urgentL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        
        DropDownBtn *btn;
        if (i < 2) {
            
            btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
            btn.backgroundColor = COLOR(238 , 238, 238, 1);
            btn.userInteractionEnabled = NO;
            if (i == 0) {
                
                _addressBtn = btn;
                [_contentView addSubview:_addressBtn];
            }else{
                
                _addressBtn1 = btn;
                [_contentView addSubview:_addressBtn1];
            }
        }else{
            
            btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            btn.backgroundColor = COLOR(238 , 238, 238, 1);
            _typeBtn = btn;
            [_contentView addSubview:_typeBtn];
        }
    }
    
    for (int i = 0; i < 7; i++) {
        
        BorderTF *textField = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        textField.textfield.delegate = self;
        
        if (i < 5) {
            
            textField.backgroundColor = COLOR(238 , 238, 238, 1);
            textField.userInteractionEnabled = NO;
            if (i > 1) {
                
                if ( i == 2) {
                    
                    textField.unitL.text = @"㎡";
                }else{
                    
                    textField.unitL.text = @"年";
                }
            }
        }
        
        switch (i) {
            case 0:
            {
                _addressTF = textField;
                [_contentView addSubview:_addressTF];
                break;
            }
            case 1:
            {
                _roomNumTF = textField;
                [_contentView addSubview:_roomNumTF];
                break;
            }
            case 2:
            {
                _areaTF = textField;
                [_contentView addSubview:_areaTF];
                break;
            }
            case 3:
            {
                _buildYearTF = textField;
                [_contentView addSubview:_buildYearTF];
                break;
            }
            case 4:
            {
                _proLimitTF = textField;
                [_contentView addSubview:_proLimitTF];
                break;
            }
            case 5:
            {
                _intentTF = textField;
                _intentTF.textfield.text = @"0";
                [_contentView addSubview:_intentTF];
                break;
            }
            case 6:
            {
                _urgentTF = textField;
                _urgentTF.textfield.text = @"0";
                [_contentView addSubview:_urgentTF];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 300 *SIZE, 5 *SIZE)];
        slider.userInteractionEnabled = YES;
        slider.minimumValue = 0.0;
        slider.maximumValue = 100.0;
        slider.maximumTrackTintColor = YJBackColor;
        slider.minimumTrackTintColor = COLOR(255, 224, 177, 1);
        slider.thumbTintColor = COLOR(255, 224, 177, 1);
        [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        [slider setThumbImage:[UIImage imageNamed:@"point"] forState:UIControlStateHighlighted];
        [slider addTarget:self action:@selector(ActionSliderChange:) forControlEvents:UIControlEventValueChanged];
        if (i == 0) {
            
            _intentSlider = slider;
            
            [_contentView addSubview:_intentSlider];
        }else{
            
            _urgentSlider = slider;
            
            [_contentView addSubview:_urgentSlider];
        }
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [_scrollView addSubview:_nextBtn];
    
    
    if ([self.status isEqualToString:@"direct"]) {
        
        _addressBtn.content.text = self.dataDic[@"city_name"];
        _addressBtn1.content.text = self.dataDic[@"district_name"];
        _addressTF.textfield.text = self.dataDic[@"absolute_address"];
        _roomNumTF.textfield.text = [NSString stringWithFormat:@"%@%@%@",self.dataDic[@"LDMC"],self.dataDic[@"DYMC"],self.dataDic[@"FJMC"]];
        _typeBtn.content.text = self.dataDic[@"WYMC"];
        _areaTF.textfield.text = self.dataDic[@"TNMJ"];
        _buildYearTF.textfield.text = self.dataDic[@""];
        _proLimitTF.textfield.text = self.dataDic[@""];
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_codeView).offset(28 *SIZE);
        make.top.equalTo(_codeView).offset(56 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(_codeView).offset(-19 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_codeView.mas_bottom).offset(3 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_contentView).offset(60 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_contentView).offset(49 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(218 *SIZE);
        make.top.equalTo(_contentView).offset(49 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_addressBtn.mas_bottom).offset(7 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
    }];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_addressTF.mas_bottom).offset(33 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roomNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_addressTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_roomNumTF.mas_bottom).offset(33 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_roomNumTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(29 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_typeBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_buildYearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(33 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buildYearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_areaTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_proLimitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_buildYearTF.mas_bottom).offset(33 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_proLimitTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_buildYearTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_proLimitTF.mas_bottom).offset(40 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_intentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_proLimitTF.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(30 *SIZE);
        make.top.equalTo(_intentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_intentSlider.mas_bottom).offset(40 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
    }];
    
    [_urgentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_intentSlider.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_urgentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(30 *SIZE);
        make.top.equalTo(_urgentTF.mas_bottom).offset(24 *SIZE);
        make.width.equalTo(@(300 *SIZE));
        make.height.equalTo(@(5 *SIZE));
        make.bottom.equalTo(_contentView.mas_bottom).offset(-25 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(36 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-19 *SIZE);
    }];
}

@end
