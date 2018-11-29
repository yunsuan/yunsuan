//
//  QuickAddAndRecommendVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "QuickAddAndRecommendVC.h"
#import "DropDownBtn.h"
#import "BorderTF.h"
#import "CustomerInfoModel.h"
#import "SinglePickView.h"
#import "DateChooseView.h"
#import "AdressChooseView.h"
#import "QuickRoomVC.h"
#import "SelectWorkerView.h"
#import "ReportCustomConfirmView.h"
#import "ReportCustomSuccessView.h"

@interface QuickAddAndRecommendVC ()<UITextFieldDelegate>
{
    NSInteger _numAdd;
    //    CustomerModel *_model;
    NSInteger _state;
    NSInteger _selected;
}

@property (nonatomic, strong) SelectWorkerView *selectWorkerView;

@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *numclasslab;
@property (nonatomic, strong) UILabel *numlab;
@property (nonatomic, strong) UILabel *adresslab;
@property (nonatomic, strong) UILabel *projectL;
@property (nonatomic , strong) DropDownBtn *sex;
@property (nonatomic , strong) BorderTF *name;
@property (nonatomic , strong) DropDownBtn *birth;
@property (nonatomic , strong) BorderTF *tel1;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic , strong) BorderTF *tel2;
@property (nonatomic , strong) BorderTF *tel3;
@property (nonatomic , strong) DropDownBtn *numclass;
@property (nonatomic , strong) BorderTF *num;
@property (nonatomic , strong) DropDownBtn *adress;
@property (nonatomic, strong) DropDownBtn *projectBtn;
@property (nonatomic , strong) UITextView *detailadress;
@property (nonatomic , strong) UIButton *surebtn;
@property (nonatomic , strong) CustomerInfoModel *Customerinfomodel;

@end

@implementation QuickAddAndRecommendVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackgroundView.hidden = NO;
    
    self.titleLabel.text = @"添加客户";
    [self initDataSouce];
    [self initUI];
    
}

-(void)initDataSouce
{
    _Customerinfomodel = [[CustomerInfoModel alloc]init];
    _Customerinfomodel.sex = @"0";
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    [_tel1.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    if (_numAdd == 0 ) {
        
        if ([self checkTel:_tel1.textfield.text]) {
            
            _numAdd += 1;
            [_tel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(80 *SIZE);
                make.top.equalTo(_tel1.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            _tel2.hidden = NO;
            
            
            [_numclasslab mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(9 *SIZE);
                make.top.equalTo(_tel2.mas_bottom).offset(30 *SIZE);
                make.width.equalTo(@(65 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_numclass mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_scrollview).offset(80 *SIZE);
                make.top.equalTo(_tel2.mas_bottom).offset(19 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }else{
            
            [self showContent:@"请填写正确的电话号码"];
        }
        
    }else{
        
        if ([_tel2.textfield.text isEqualToString:_tel1.textfield.text]) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请不要输入相同电话号码" WithDefaultBlack:^{
                
                
            }];
        }else{
            
            if ([self checkTel:_tel2.textfield.text]) {
                
                _numAdd += 1;
                [_tel3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(80 *SIZE);
                    make.top.equalTo(_tel2.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                _tel3.hidden = NO;
                
                
                [_numclasslab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(9 *SIZE);
                    make.top.equalTo(_tel3.mas_bottom).offset(30 *SIZE);
                    make.width.equalTo(@(65 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
                
                [_numclass mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(_scrollview).offset(80 *SIZE);
                    make.top.equalTo(_tel3.mas_bottom).offset(19 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
            }else{
                
                [self showContent:@"请填写正确的电话号码"];
            }
        }
    }
}


#pragma mark -- TextFieldDelegate


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
    _name.textfield.placeholder = @"必填(少于5字)";
    _name.textfield.delegate = self;
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
    _tel1 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 146*SIZE, 257.7*SIZE, 33.3*SIZE)];
    _tel1.textfield.placeholder = @"必填";
    _tel1.textfield.keyboardType = UIKeyboardTypePhonePad;
    [_scrollview addSubview:_tel1];
    
    //    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _addBtn.frame = CGRectMake(313 *SIZE, 162 *SIZE, 25 *SIZE, 25 *SIZE);
    //    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    //    [_scrollview addSubview:_addBtn];
    
    _tel2 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 196*SIZE, 257.7*SIZE, 33.3*SIZE)];
    _tel2.textfield.placeholder = @"选填";
    _tel2.hidden = YES;
    _tel2.textfield.keyboardType = UIKeyboardTypePhonePad;
    [_scrollview addSubview:_tel2];
    
    
    _tel3 = [[BorderTF alloc]initWithFrame:CGRectMake(80.3*SIZE, 246*SIZE, 257.7*SIZE, 33.3*SIZE)];
    _tel3.textfield.placeholder = @"选填";
    _tel3.hidden = YES;
    _tel3.textfield.keyboardType = UIKeyboardTypePhonePad;
    [_scrollview addSubview:_tel3];
    
    
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
    
    _projectL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 556*SIZE, 100*SIZE, 14*SIZE)];
    _projectL.text = @"项目名称:";
    _projectL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _projectL.textColor = YJTitleLabColor;
    [_scrollview addSubview:_projectL];
    
    _projectBtn = [[DropDownBtn alloc]initWithFrame:CGRectMake(80.3*SIZE, 546*SIZE, 257.7*SIZE, 33.3*SIZE)];
    [_projectBtn addTarget:self action:@selector(ActionProBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_projectBtn];
    
    [_scrollview addSubview:self.surebtn];
    
    [self masonryUI];
    
}

- (void)masonryUI{
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_tel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(81 *SIZE);
        make.top.equalTo(_scrollview).offset(158 *SIZE);
        //        make.width.equalTo(@(217 *SIZE));
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_numclasslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(9 *SIZE);
        make.top.equalTo(_tel1.mas_bottom).offset(30 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_numclass mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(80 *SIZE);
        make.top.equalTo(_tel1.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(258 *SIZE));
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
    
    [self.surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollview).offset(22 *SIZE);
        make.top.equalTo(_projectBtn.mas_bottom).offset(43 *SIZE);
        make.width.equalTo(@(317 *SIZE));
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollview.mas_bottom).offset(-53 *SIZE);
    }];
}

-(void)action_sex
{
    
    [_tel1.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"男";
        _Customerinfomodel.sex = @"1";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sex.content.text = @"女";
        _Customerinfomodel.sex =@"2";
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
    [_tel1.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    DateChooseView *view = [[DateChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    view.dateblock = ^(NSDate *date) {
        
        _birth.content.text = [self gettime:date];
        _Customerinfomodel.birth = _birth.content.text;
    };
    [self.view addSubview:view];
}

-(void)action_numclass
{
    [_tel1.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:CARD_TYPE]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        _numclass.content.text = MC;
        _Customerinfomodel.card_type = ID;
        
    };
    [self.view addSubview:view];
}

-(void)action_address
{
    [_tel1.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        self.adress.content.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
        _Customerinfomodel.province = proviceid;
        _Customerinfomodel.city = cityid;
        _Customerinfomodel.district = areaid;
    };
}

- (void)ActionProBtn:(UIButton *)btn{
    
    QuickRoomVC *nextVC = [[QuickRoomVC alloc] init];
    nextVC.ways = @"quickAdd";
    nextVC.quickRoomVCSelectBlock = ^(NSString *projectId, NSString *projectName) {
        
        if (!self.roomDetailModel) {
            
            self.roomDetailModel = [[RoomDetailModel alloc] init];
            self.roomDetailModel.project_name = projectName;
        }
        _projectBtn.content.text = projectName;
        _projectBtn->str = [NSString stringWithFormat:@"%@",projectId];
    };
    
    //    nextVC.quickRoomVCRoomBlock = ^(RoomListModel *model) {
    //
    //        self.roomDetailModel.project_name = model.project_name;
    //    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)action_sure
{
    [_tel1.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_tel3.textfield endEditing:YES];
    [_name.textfield endEditing:YES];
    [_tel2.textfield endEditing:YES];
    [_num.textfield endEditing:YES];
    [_detailadress endEditing:YES];
    if (_name.textfield.text.length == 0 || [self isEmpty:_name.textfield.text]) {
        
        [self showContent:@"请输入姓名！"];
        return;
    }
    if (![self checkTel:_tel1.textfield.text]) {
        
        [self showContent:@"请输入正确的电话号码"];
        return;
    }
    
    if (((_tel1.textfield.text.length && _tel2.textfield.text.length) && [_tel1.textfield.text isEqualToString:_tel2.textfield.text]) || ((_tel3.textfield.text.length && _tel2.textfield.text.length) && [_tel3.textfield.text isEqualToString:_tel2.textfield.text]) || ((_tel3.textfield.text.length && _tel1.textfield.text.length) && [_tel1.textfield.text isEqualToString:_tel3.textfield.text])) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请不要输入相同电话号码" WithDefaultBlack:^{
            
            return ;
        }];
    }
    
    if (_name.textfield.text.length > 5) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"姓名不能超过5个字" WithDefaultBlack:^{
            
            return ;
        }];
    }
    
    
    _Customerinfomodel.name = _name.textfield.text;
    
    if ([self checkTel:_tel1.textfield.text]) {
        
        _Customerinfomodel.tel = _tel1.textfield.text;
    }else{
        
        [self showContent:@"请填写正确的电话号码"];
        return;
    }
    if (_numAdd == 1 && [self checkTel:_tel2.textfield.text]) {
        
        _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@",_tel1.textfield.text,_tel2.textfield.text];
    }
    if (_numAdd > 1 && [self checkTel:_tel2.textfield.text]) {
        
        _Customerinfomodel.tel = [NSString stringWithFormat:@"%@,%@,%@",_tel1.textfield.text,_tel2.textfield.text,_tel3.textfield.text];
    }
    _Customerinfomodel.card_id = _num.textfield.text;
    _Customerinfomodel.address = _detailadress.text;
    
    if (!_projectBtn->str.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择项目" WithDefaultBlack:^{
            
            QuickRoomVC *nextVC = [[QuickRoomVC alloc] init];
            nextVC.ways = @"quickAdd";
            nextVC.quickRoomVCSelectBlock = ^(NSString *projectId, NSString *projectName) {
                
                if (!self.roomDetailModel) {
                    
                    self.roomDetailModel = [[RoomDetailModel alloc] init];
                    self.roomDetailModel.project_name = projectName;
                }
                _projectBtn.content.text = projectName;
                _projectBtn->str = [NSString stringWithFormat:@"%@",projectId];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_Customerinfomodel modeltodic]];
    
    [dic setObject:_projectBtn->str forKey:@"project_id"];
    
    self.selectWorkerView = [[SelectWorkerView alloc] initWithFrame:self.view.bounds];
    SS(strongSelf);
    WS(weakSelf);
    self.selectWorkerView.selectWorkerRecommendBlock = ^{
        
        if (weakSelf.selectWorkerView.nameL.text) {
            
            [dic setObject:weakSelf.selectWorkerView.ID forKey:@"consultant_advicer_id"];
        }
        
        ReportCustomConfirmView *reportCustomConfirmView = [[ReportCustomConfirmView alloc] initWithFrame:weakSelf.view.frame];
        NSDictionary *tempDic = @{@"project":weakSelf.roomDetailModel.project_name,
                                  @"sex":strongSelf->_Customerinfomodel.sex,
                                  @"tel":strongSelf->_Customerinfomodel.tel,
                                  @"name":strongSelf->_Customerinfomodel.name
                                  };
        reportCustomConfirmView.state = strongSelf->_state;
        reportCustomConfirmView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        reportCustomConfirmView.reportCustomConfirmViewBlock = ^{
            
            [BaseRequest POST:AddAndRecommend_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    
                    ReportCustomSuccessView *reportCustomSuccessView = [[ReportCustomSuccessView alloc] initWithFrame:weakSelf.view.frame];
                    NSDictionary *tempDic = @{@"project":weakSelf.roomDetailModel.project_name,
                                              @"sex":strongSelf->_Customerinfomodel.sex,
                                              @"tel":strongSelf->_Customerinfomodel.tel,
                                              @"name":strongSelf->_Customerinfomodel.name
                                              };
                    reportCustomSuccessView.state = strongSelf->_state;
                    reportCustomSuccessView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
                    reportCustomSuccessView.reportCustomSuccessViewBlock = ^{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"matchReload" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    };
                    [weakSelf.view addSubview:reportCustomSuccessView];
                }
                else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [weakSelf showContent:@"网络错误"];
            }];
        };
        [weakSelf.view addSubview:reportCustomConfirmView];
        
    };
    [BaseRequest GET:ProjectAdvicer_URL parameters:@{@"project_id":_projectBtn->str} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"rows"] count]) {
                weakSelf.selectWorkerView.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"rows"]];
                _state = [resposeObject[@"data"][@"tel_complete_state"] integerValue];
                _selected = [resposeObject[@"data"][@"advicer_selected"] integerValue];
                weakSelf.selectWorkerView.advicerSelect = _selected;
                [weakSelf.view addSubview:weakSelf.selectWorkerView];
            }else{
                
                ReportCustomConfirmView *reportCustomConfirmView = [[ReportCustomConfirmView alloc] initWithFrame:weakSelf.view.frame];
                NSDictionary *tempDic = @{@"project":weakSelf.roomDetailModel.project_name,
                                          @"sex":strongSelf->_Customerinfomodel.sex,
                                          @"tel":strongSelf->_Customerinfomodel.tel,
                                          @"name":strongSelf->_Customerinfomodel.name
                                          };
                reportCustomConfirmView.state = strongSelf->_state;
                reportCustomConfirmView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
                reportCustomConfirmView.reportCustomConfirmViewBlock = ^{
                    
                    [weakSelf RequestRecommend:dic];
                };
                [weakSelf.view addSubview:reportCustomConfirmView];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestRecommend:(NSDictionary *)dic{
    
    [BaseRequest POST:AddAndRecommend_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            ReportCustomSuccessView *reportCustomSuccessView = [[ReportCustomSuccessView alloc] initWithFrame:self.view.frame];
            NSDictionary *tempDic = @{@"project":self.roomDetailModel.project_name,
                                      @"sex":_Customerinfomodel.sex,
                                      @"tel":_Customerinfomodel.tel,
                                      @"name":_Customerinfomodel.name
                                      };
            reportCustomSuccessView.state = _state;
            reportCustomSuccessView.dataDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
            reportCustomSuccessView.reportCustomSuccessViewBlock = ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"matchReload" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustom" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            };
            [self.view addSubview:reportCustomSuccessView];
        }
        else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

-(UIButton *)surebtn
{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.frame = CGRectMake(20*SIZE, 566*SIZE, 320*SIZE, 40*SIZE);
        _surebtn.backgroundColor = YJBlueBtnColor;
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = 1.7*SIZE;
        
        [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _surebtn.titleLabel.font = [UIFont systemFontOfSize:15.3*SIZE];
        [_surebtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surebtn;
}

@end
