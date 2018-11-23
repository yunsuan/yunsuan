//
//  ReleaseDirectVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/23.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "ReleaseDirectVC.h"
#import "CompleteSurveyInfoVC.h"

#import "BaseFrameHeader.h"
#import "BorderTF.h"
#import "DropDownBtn.h"

#import "SinglePickView.h"

@interface ReleaseDirectVC ()
{
    
    NSString *_gender;
    NSString *_tel;
    NSString *_reporterType;
}

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) BorderTF *contactTF;

@property (nonatomic, strong) UILabel *sexL;

@property (nonatomic, strong) DropDownBtn *sexBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTF *phoneTF;

@property (nonatomic, strong) UILabel *shipL;

@property (nonatomic, strong) DropDownBtn *shipBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation ReleaseDirectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionSexBtn:(UIButton *)btn{
    
    [_contactTF.textfield endEditing:YES];
    [_phoneTF.textfield endEditing:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _gender = @"1";
        _sexBtn.content.text = @"男";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _gender = @"2";
        _sexBtn.content.text = @"女";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)ActionShipBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:30]];
    
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        _reporterType = [NSString stringWithFormat:@"%@",ID];
        _shipBtn.content.text = [NSString stringWithFormat:@"%@",MC];
    };
    [self.view addSubview:view];
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    
    if ([self isEmpty:_contactTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入姓名"];
        return;
    }
    
    if (!_gender.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择性别"];
        return;
    }
    
    if (![self checkTel:_phoneTF.textfield.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入正确的电话号码"];
        return;
    }else{
        
        _tel = _phoneTF.textfield.text;
    }
    
    
    if (!_reporterType.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择与业主的关系"];
        return;
    }
    
    NSDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
    [dic setValue:_contactTF.textfield.text forKey:@"name"];
    [dic setValue:_gender forKey:@"sex"];
    [dic setValue:_phoneTF.textfield.text forKey:@"tel"];
    [dic setValue:_reporterType forKey:@"report_type"];
    
    CompleteSurveyInfoVC *nextVC = [[CompleteSurveyInfoVC alloc] initWithTitle:@"完成勘察信息"];
    nextVC.status = @"direct";
    nextVC.dataDic = dic;
    nextVC.projectID = self.projectID;
    nextVC.buildId = self.buildId;
    nextVC.unitId = self.unitId;
    nextVC.comName = self.comName;
    nextVC.completeSurveyInfoVCBlock = ^{
        
        if (self.releaseDirectVCBlock) {
            
            self.releaseDirectVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"联系人信息";
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_whiteView];
    
    BaseFrameHeader *header = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"联系人";
    [_whiteView addSubview:header];
    
    NSArray *titleArr = @[@"联系人：",@"性别：",@"联系电话：",@"与业主的关系："];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = titleArr[i];
        switch (i) {
            case 0:
            {
                _contactL = label;
                [_whiteView addSubview:_contactL];
                _contactTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 117 *SIZE, 33 *SIZE)];
                [_whiteView addSubview:_contactTF];
                break;
            }
            case 1:
            {
                _sexL = label;
                [_whiteView addSubview:_sexL];
                _sexBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 87 *SIZE, 33 *SIZE)];
                [_sexBtn addTarget:self action:@selector(ActionSexBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_sexBtn];
                break;
            }
            case 2:
            {
                _phoneL = label;
                [_whiteView addSubview:_phoneL];
                _phoneTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                _phoneTF.textfield.keyboardType = UIKeyboardTypePhonePad;
                [_whiteView addSubview:_phoneTF];
                break;
            }
            case 3:
            {
                _shipL = label;
                [_whiteView addSubview:_shipL];
                _shipBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                [_shipBtn addTarget:self action:@selector(ActionShipBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_whiteView addSubview:_shipBtn];
                break;
            }
            default:
                break;
        }

    }
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    _commitBtn.layer.cornerRadius = 4 *SIZE;
    _commitBtn.clipsToBounds = YES;
    [_commitBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_commitBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_whiteView).offset(17 *SIZE + 40 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contactTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(80 *SIZE);
        make.top.equalTo(_whiteView).offset(7 *SIZE + 40 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sexL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(209 *SIZE);
        make.top.equalTo(_whiteView).offset(17 *SIZE + 40 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(251 *SIZE);
        make.top.equalTo(_whiteView).offset(7 *SIZE + 40 *SIZE);
        make.width.mas_equalTo(87 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_contactTF.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(80 *SIZE);
        make.top.equalTo(_contactTF.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_shipL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(9 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(29 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_shipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(80 *SIZE);
        make.top.equalTo(_phoneTF.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-24 *SIZE);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(22 *SIZE);
        make.top.equalTo(_whiteView.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

@end
