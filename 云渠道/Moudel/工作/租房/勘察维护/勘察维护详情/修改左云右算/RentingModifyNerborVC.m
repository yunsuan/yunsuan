//
//  RentingModifyNerborVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/20.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingModifyNerborVC.h"

#import "BaseHeader.h"
#import "BorderTF.h"
#import "DropDownBtn.h"

#import "SinglePickView.h"

@interface RentingModifyNerborVC (){
    
    NSMutableDictionary *_dataDic;
    NSString *_checkWay;
}

@property (nonatomic, strong) UIView *nearView;

@property (nonatomic, strong) BaseHeader *nearHeader;

@property (nonatomic, strong) UILabel *leftL;

@property (nonatomic, strong) BorderTF *leftTF;

@property (nonatomic, strong) UILabel *rightL;

@property (nonatomic, strong) BorderTF *rightTF;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) DropDownBtn *seeWayBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingModifyNerborVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    [dic setObject:self.houseId forKey:@"house_id"];
    [dic setObject:self.type forKey:@"type"];
    if (![self isEmpty:_leftTF.textfield.text]) {
        
        if ([self.type integerValue] == 2) {
            
            [dic setObject:_leftTF.textfield.text forKey:@"left_shop"];
        }else{
            
            [dic setObject:_leftTF.textfield.text forKey:@"left_office"];
        }
    }else{
        
        if ([self.type integerValue] == 2) {
            
            [dic setObject:@" " forKey:@"left_shop"];
        }else{
            
            [dic setObject:@" " forKey:@"left_office"];
        }
    }
    
    if (![self isEmpty:_rightTF.textfield.text]) {
        
        if ([self.type integerValue] == 2) {
            
            [dic setObject:_rightTF.textfield.text forKey:@"right_shop"];
        }else{
            
            [dic setObject:_rightTF.textfield.text forKey:@"right_office"];
        }
    }else{
        
        if ([self.type integerValue] == 2) {
            
            [dic setObject:@" " forKey:@"right_shop"];
        }else{
            
            [dic setObject:@" " forKey:@"right_office"];
        }
    }
    
    
    if (_checkWay.length) {
        
        [dic setObject:_checkWay forKey:@"check_way"];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择看房方式"];
        return;
    }
    
    if (![self isEmpty:_markView.text]) {
        
        [dic setObject:_markView.text forKey:@"comment"];
    }else{
        
        [dic setObject:@" " forKey:@"right_shop"];
    }
    
    [BaseRequest POST:RentSurveyUpdateHouseInfo_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.rentingModifyNerborVCBlock) {
                
                self.rentingModifyNerborVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionSeeWayBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:31]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_checkWay = [NSString stringWithFormat:@"%@",ID];
        strongSelf.seeWayBtn.content.text = MC;
        strongSelf.seeWayBtn->str = [NSString stringWithFormat:@"%@", ID];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    _nearView = [[UIView alloc] init];
    _nearView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_nearView];
    
    _nearHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _nearHeader.titleL.text = @"左云右算";
    [_nearView addSubview:_nearHeader];
    
    NSArray *nearArr = @[@"左边店铺：",@"右边店铺：",@"看房方式：",@"其他要求："];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 20 *SIZE, 70 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = nearArr[i];
        switch (i) {
            case 0:
            {
                _leftL = label;
                [_nearView addSubview:_leftL];
                break;
            }
            case 1:
            {
                _rightL = label;
                [_nearView addSubview:_rightL];
                break;
            }
            case 2:
            {
                _seeWayL = label;
                [_nearView addSubview:_seeWayL];
                break;
            }
            case 3:
            {
                _markL = label;
                [_nearView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        BorderTF *textFeild = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        if (i == 0) {
            
            if ([self.type integerValue] == 2) {
                
                if (_dataDic[@"left_shop"]) {
                    
                    textFeild.textfield.text = _dataDic[@"left_shop"];
                }
            }else{
                
                if (_dataDic[@"left_office"]) {
                    
                    textFeild.textfield.text = _dataDic[@"left_office"];
                }
            }
            _leftTF = textFeild;
            [_nearView addSubview:_leftTF];
        }else{
            
            if ([self.type integerValue] == 2) {
                
                if (_dataDic[@"right_shop"]) {
                    
                    textFeild.textfield.text = _dataDic[@"right_shop"];
                }else{
                    
                    if (_dataDic[@"right_office"]) {
                        
                        textFeild.textfield.text = _dataDic[@"right_office"];
                    }
                }
            }
            _rightTF = textFeild;
            [_nearView addSubview:_rightTF];
        }
    }
    
    _seeWayBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 118 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_seeWayBtn addTarget:self action:@selector(ActionSeeWayBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.seeWay.length) {
        
        NSArray *arr = [self getDetailConfigArrByConfigState:31];
        for (int i = 0; i < arr.count; i++) {
            
            if ([self.seeWay isEqualToString:arr[i][@"param"]]) {
                
                _checkWay = [NSString stringWithFormat:@"%@",arr[i][@"id"]];
            }
        }
        _seeWayBtn.content.text = self.seeWay;
        
    }
    [_nearView addSubview:_seeWayBtn];
    
    _markView = [[UITextView alloc] initWithFrame:CGRectMake(79 *SIZE, 171 *SIZE, 258 *SIZE, 100 *SIZE)];
    _markView.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markView.layer.borderWidth = SIZE;
    _markView.layer.cornerRadius = 5 *SIZE;
    _markView.clipsToBounds = YES;
    if (_dataDic[@"comment"]) {
        
        _markView.text = _dataDic[@"comment"];
    }
    [_nearView addSubview:_markView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"左云右算";
    
    [_nearView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(360 *SIZE);
    }];
    
    [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(8 *SIZE);
        make.top.equalTo(_nearView).offset(60 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_leftTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(81 *SIZE);
        make.top.equalTo(_nearView).offset(50 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(8 *SIZE);
        make.top.equalTo(_leftTF.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(81 *SIZE);
        make.top.equalTo(_leftTF.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(8 *SIZE);
        make.top.equalTo(_rightTF.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_seeWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(81 *SIZE);
        make.top.equalTo(_rightTF.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(8 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(30 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nearView).offset(81 *SIZE);
        make.top.equalTo(_seeWayBtn.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(_nearView.mas_bottom).offset(-29 *SIZE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(_nearView.mas_bottom).offset(32 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 + TAB_BAR_MORE);
        make.bottom.equalTo(self.view).offset(0);
    }];
}

@end
