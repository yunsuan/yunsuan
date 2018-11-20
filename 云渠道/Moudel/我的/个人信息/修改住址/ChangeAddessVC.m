//
//  ChangeAddessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangeAddessVC.h"
#import "AdressChooseView.h"

@interface ChangeAddessVC ()
{
    
    NSString *_provinceId;
    NSString *_cityId;
    NSString *_areaId;
    NSString *_address;
}
@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *addressBtn;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *dropImg;

@property (nonatomic, strong) UITextView *detailTV;

@end

@implementation ChangeAddessVC

- (instancetype)initWithAddress:(NSString *)address
{
    self = [super init];
    if (self) {
        
        _address = address;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (!_provinceId && !_cityId && !_areaId) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择地址"];
    }else if ([self isEmpty:_detailTV.text]){
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请填写详细地址"];
    }else{
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        
        if (_provinceId) {
            
            [tempDic setObject:_provinceId forKey:@"province"];
        }
        if (_cityId) {
            
            [tempDic setObject:_cityId forKey:@"city"];
        }
        if (_areaId) {
            
            [tempDic setObject:_areaId forKey:@"district"];
        }
        if (![self isEmpty:_detailTV.text]) {
            
            [tempDic setObject:_detailTV.text forKey:@"absolute_address"];
        }
        [BaseRequest POST:UpdatePersonal_URL parameters:tempDic success:^(id resposeObject) {
            
            //            NSLog(@"%@",resposeObject);
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (_provinceId) {
                    
                    [UserInfoModel defaultModel].province = _provinceId;
                }
                if (_cityId) {
                    
                    [UserInfoModel defaultModel].city = _cityId;
                }
                if (_areaId) {
                    
                    [UserInfoModel defaultModel].district = _areaId;
                }
                if (![self isEmpty:_detailTV.text]) {
                    
                    [UserInfoModel defaultModel].absolute_address = _detailTV.text;
                }
                [UserModelArchiver infoArchive];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            //            NSLog(@"%@",error);
        }];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 50 *SIZE)];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_whiteView];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 200 *SIZE, 13 *SIZE)];
    _addressL.textColor = YJTitleLabColor;
    _addressL.font = [UIFont systemFontOfSize:13 *SIZE];
    _addressL.text = @"请选择地址";
    if ([UserInfoModel defaultModel].province.length && [UserInfoModel defaultModel].city.length && [UserInfoModel defaultModel].district.length) {
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
        
        NSError *err;
        NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
        for (int i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [[UserInfoModel defaultModel].province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (int j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [[UserInfoModel defaultModel].city integerValue]){
                        
                        NSArray *area = city[j][@"district"];
                        
                        for (int k = 0; k < area.count; k++) {
                            
                            if([area[k][@"code"] integerValue] == [[UserInfoModel defaultModel].district integerValue]){
                                
                                _provinceId = [UserInfoModel defaultModel].province;
                                _cityId = [UserInfoModel defaultModel].city;
                                _areaId = [UserInfoModel defaultModel].district;
                                _addressL.text = [NSString stringWithFormat:@"%@-%@-%@",provice[i][@"name"],city[0][@"name"],area[k][@"name"]];
                            }
                        }
                    }
                }
            }
        }
    }
    [_whiteView addSubview:_addressL];
    
    _whiteView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_address)];
    [_whiteView addGestureRecognizer:tap];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(342 *SIZE, 23 *SIZE, 8 *SIZE, 8 *SIZE)];
    _dropImg.image = [UIImage imageNamed:@"downarrow1"];
    [_whiteView addSubview:_dropImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 60 *SIZE + NAVIGATION_BAR_HEIGHT, 100 *SIZE, 12 *SIZE)];
    label.textColor = YJContentLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"具体地址";
    [self.view addSubview:label];
    
    _detailTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 85 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, 117 *SIZE)];
    _detailTV.contentInset = UIEdgeInsetsMake(13 *SIZE, 10 *SIZE, 13 *SIZE, 10 *SIZE);
    _detailTV.font = [UIFont systemFontOfSize:13 *SIZE];
    if ([UserInfoModel defaultModel].absolute_address.length) {
        
        _detailTV.text = [UserInfoModel defaultModel].absolute_address;
    }
    [self.view addSubview:_detailTV];
}

-(void)action_address
{
    AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:self.view.frame withdata:@[]];
    [self.view addSubview:view];
    view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        
        _provinceId = proviceid;
        _cityId = cityid;
        _areaId = areaid;
        _addressL.text = [NSString stringWithFormat:@"%@/%@/%@",province,city,area];
    };
}

@end
