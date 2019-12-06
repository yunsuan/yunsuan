//
//  AddAreaCustomVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddAreaCustomVC.h"

#import "AddAreaNeedVC.h"
#import "CustomerListVC.h"

#import "BaseFrameHeader.h"
#import "AddAreaCustomView.h"

#import "SinglePickView.h"
#import "AdressChooseView.h"
#import "DateChooseView.h"

@interface AddAreaCustomVC ()<UIScrollViewDelegate>
{
    
    NSInteger _idx;
    
    NSMutableArray *_cityArr;
    NSMutableArray *_districtArr;
    
    NSString *_img1;
    NSString *_img2;
    NSString *_img3;
    
    NSDateFormatter *_dateFormatter;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) BaseFrameHeader *header;

@property (nonatomic, strong) BaseFrameHeader *ruleHeader;

@property (nonatomic, strong) AddAreaCustomView *addAreaCustomView;

@property (nonatomic, strong) UILabel *ruleL;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddAreaCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _cityArr = [@[] mutableCopy];
    _districtArr = [@[] mutableCopy];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    _img1 = @"";
    _img2 = @"";
    _img3 = @"";
}

- (void)RuleRequest{
    
    [BaseRequest GET:DistrictRuleDetail_URL parameters:@{@"district":_addAreaCustomView.regionBtn1->str} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _ruleL.text = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"recommend_desc"]];
        }else{
            
//            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择客户" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *new = [UIAlertAction actionWithTitle:@"新房客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        CustomerListVC *nextVC = [[CustomerListVC alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.status = 0;
        nextVC.isSelect = YES;
        nextVC.customerListVCCustomBlock = ^(CustomerTableModel * _Nonnull model) {
            
            [BaseRequest GET:GetCliendInfo_URL parameters:@{@"client_id":model.client_id} success:^(id resposeObject) {

                if ([resposeObject[@"code"] integerValue] == 200) {
                        
                    _addAreaCustomView.nameTF.textfield.text = model.name;
                    if ([model.sex integerValue] == 1) {
                        
                        _addAreaCustomView.genderBtn.content.text = @"男";
                        _addAreaCustomView.genderBtn->str = @"1";
                    }else if ([model.sex integerValue] == 2){
                        
                        _addAreaCustomView.genderBtn.content.text = @"女";
                        _addAreaCustomView.genderBtn->str = @"2";
                    }else{
                        
                        _addAreaCustomView.genderBtn.content.text = @"";
                        _addAreaCustomView.genderBtn->str = @"";
                    }
                    _addAreaCustomView.phoneTF1.textfield.text = model.tel;
                    _addAreaCustomView.phoneTF2.hidden = YES;
                    _addAreaCustomView.phoneTF3.hidden = YES;
                    _addAreaCustomView.cardTypeBtn.content.text = model.card_type;
                    for (int i = 0; i < [[self getDetailConfigArrByConfigState:CARD_TYPE] count]; i++) {
                        
                        NSDictionary *dic = [self getDetailConfigArrByConfigState:CARD_TYPE][i];
                        if ([model.card_type isEqualToString:dic[@"param"]]) {
                            
                            _addAreaCustomView.cardTypeBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        }
                    }
                    _addAreaCustomView.cardNumTF.textfield.text = model.card_id;
                    _addAreaCustomView.birthBtn.content.text = resposeObject[@"data"][@"basic"][@"birth"];
                    _addAreaCustomView.addressTF.textfield.text = resposeObject[@"data"][@"basic"][@"address"];
                    _addAreaCustomView.addressBtn.content.text = [NSString stringWithFormat:@"%@%@%@",resposeObject[@"data"][@"basic"][@"province_name"]?resposeObject[@"data"][@"basic"][@"province_name"]:@"",resposeObject[@"data"][@"basic"][@"city_name"]?resposeObject[@"data"][@"basic"][@"city_name"]:@"",resposeObject[@"data"][@"basic"][@"district_name"]?resposeObject[@"data"][@"basic"][@"district_name"]:@""];
                    _addAreaCustomView.addressBtn->str = [NSString stringWithFormat:@"%@,%@,%@",resposeObject[@"data"][@"basic"][@"province"]?resposeObject[@"data"][@"basic"][@"province"]:@"",resposeObject[@"data"][@"basic"][@"city"]?resposeObject[@"data"][@"basic"][@"city"]:@"",resposeObject[@"data"][@"basic"][@"district"]?resposeObject[@"data"][@"basic"][@"district"]:@""];
                    
                    if ([resposeObject[@"data"][@"need_info"][0][@"region"] count]) {
                        
                        _addAreaCustomView.regionBtn.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city_name"];
                        _addAreaCustomView.regionBtn->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"]];
                        _addAreaCustomView.regionBtn1.content.text = @"";
                        if (_districtArr.count) {
                            
                            for (int i = 0; i < [_districtArr count]; i++) {
                                
                                if ([resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"] integerValue] == [_districtArr[i][@"id"] integerValue]) {
                                    
                                
                                    _addAreaCustomView.regionBtn1.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district_name"];
                                    _addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district"]];
                                }
                            }
                            if (!_addAreaCustomView.regionBtn1.content.text.length) {
                                
                                _addAreaCustomView.regionBtn1.content.text = @"不限";
                                _addAreaCustomView.regionBtn1->str = @"0";
                            }
                        }else{
                            
                            [BaseRequest GET:ForumOpenDistrictList_URL parameters:@{@"city":resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"]} success:^(id resposeObject) {
                                
                            
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                                        
                                        if ([resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"] integerValue] == [resposeObject[@"data"][i][@"code"] integerValue]) {
                                            
                                        
                                            _addAreaCustomView.regionBtn1.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district_name"];
                                            _addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district"]];
                                        }
                                    }
                                    if (!_addAreaCustomView.regionBtn1.content.text.length) {
                                        
                                        _addAreaCustomView.regionBtn1.content.text = @"不限";
                                        _addAreaCustomView.regionBtn1->str = @"0";
                                    }

                                }else{
                                    

                                }
                            } failure:^(NSError *error) {
                                
                                
                            }];
                        }
                    }else{
                        
                        _addAreaCustomView.regionBtn.content.text = @"";
                        _addAreaCustomView.regionBtn->str = @"";
                        _addAreaCustomView.regionBtn1.content.text = @"";
                        _addAreaCustomView.regionBtn1->str = @"";
                    }
                    [_addAreaCustomView.cardTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_addAreaCustomView).offset(10 *SIZE);
                        make.top.equalTo(_addAreaCustomView.phoneTF1.mas_bottom).offset(14 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [_addAreaCustomView.cardTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                       
                        make.left.equalTo(_addAreaCustomView).offset(80 *SIZE);
                        make.top.equalTo(_addAreaCustomView.phoneTF1.mas_bottom).offset(10 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }else{
                        
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                   
            //        NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"二手房客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CustomerListVC *nextVC = [[CustomerListVC alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.status = 1;
        nextVC.isSelect = YES;
        nextVC.customerListVCCustomBlock = ^(CustomerTableModel * _Nonnull model) {
            
            [BaseRequest GET:GetCliendInfo_URL parameters:@{@"client_id":model.client_id} success:^(id resposeObject) {

                if ([resposeObject[@"code"] integerValue] == 200) {
                        
                    _addAreaCustomView.nameTF.textfield.text = model.name;
                    if ([model.sex integerValue] == 1) {
                        
                        _addAreaCustomView.genderBtn.content.text = @"男";
                        _addAreaCustomView.genderBtn->str = @"1";
                    }else if ([model.sex integerValue] == 2){
                        
                        _addAreaCustomView.genderBtn.content.text = @"女";
                        _addAreaCustomView.genderBtn->str = @"2";
                    }else{
                        
                        _addAreaCustomView.genderBtn.content.text = @"";
                        _addAreaCustomView.genderBtn->str = @"";
                    }
                    _addAreaCustomView.phoneTF1.textfield.text = model.tel;
                    _addAreaCustomView.phoneTF2.hidden = YES;
                    _addAreaCustomView.phoneTF3.hidden = YES;
                    _addAreaCustomView.cardTypeBtn.content.text = model.card_type;
                    for (int i = 0; i < [[self getDetailConfigArrByConfigState:CARD_TYPE] count]; i++) {
                        
                        NSDictionary *dic = [self getDetailConfigArrByConfigState:CARD_TYPE][i];
                        if ([model.card_type isEqualToString:dic[@"param"]]) {
                            
                            _addAreaCustomView.cardTypeBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        }
                    }
                    _addAreaCustomView.cardNumTF.textfield.text = model.card_id;
                    _addAreaCustomView.birthBtn.content.text = resposeObject[@"data"][@"basic"][@"birth"];
                    _addAreaCustomView.addressTF.textfield.text = resposeObject[@"data"][@"basic"][@"address"];
                    _addAreaCustomView.addressBtn.content.text = [NSString stringWithFormat:@"%@%@%@",resposeObject[@"data"][@"basic"][@"province_name"]?resposeObject[@"data"][@"basic"][@"province_name"]:@"",resposeObject[@"data"][@"basic"][@"city_name"]?resposeObject[@"data"][@"basic"][@"city_name"]:@"",resposeObject[@"data"][@"basic"][@"district_name"]?resposeObject[@"data"][@"basic"][@"district_name"]:@""];
                    _addAreaCustomView.addressBtn->str = [NSString stringWithFormat:@"%@%@%@",resposeObject[@"data"][@"basic"][@"province"]?resposeObject[@"data"][@"basic"][@"province"]:@"",resposeObject[@"data"][@"basic"][@"city"]?resposeObject[@"data"][@"basic"][@"city"]:@"",resposeObject[@"data"][@"basic"][@"district"]?resposeObject[@"data"][@"basic"][@"district"]:@""];
                    
                    if ([resposeObject[@"data"][@"need_info"][0][@"region"] count]) {
                        
                        _addAreaCustomView.regionBtn.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city_name"];
                        _addAreaCustomView.regionBtn->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"]];
                        _addAreaCustomView.regionBtn1.content.text = @"";
                        if (_districtArr.count) {
                            
                            for (int i = 0; i < [_districtArr count]; i++) {
                                
                                if ([resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"] integerValue] == [_districtArr[i][@"id"] integerValue]) {
                                    
                                
                                    _addAreaCustomView.regionBtn1.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district_name"];
                                    _addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district"]];
                                }
                            }
                            if (!_addAreaCustomView.regionBtn1.content.text.length) {
                                
                                _addAreaCustomView.regionBtn1.content.text = @"不限";
                                _addAreaCustomView.regionBtn1->str = @"0";
                            }
                        }else{
                            
                            [BaseRequest GET:ForumOpenDistrictList_URL parameters:@{@"city":resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"]} success:^(id resposeObject) {
                                
                            
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                                        
                                        if ([resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"] integerValue] == [resposeObject[@"data"][i][@"code"] integerValue]) {
                                            
                                        
                                            _addAreaCustomView.regionBtn1.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district_name"];
                                            _addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district"]];
                                        }
                                    }
                                    if (!_addAreaCustomView.regionBtn1.content.text.length) {
                                        
                                        _addAreaCustomView.regionBtn1.content.text = @"不限";
                                        _addAreaCustomView.regionBtn1->str = @"0";
                                    }

                                }else{
                                    

                                }
                            } failure:^(NSError *error) {
                                
                                
                            }];
                        }
                    }else{
                        
                        _addAreaCustomView.regionBtn.content.text = @"";
                        _addAreaCustomView.regionBtn->str = @"";
                        _addAreaCustomView.regionBtn1.content.text = @"";
                        _addAreaCustomView.regionBtn1->str = @"";
                    }
                    [_addAreaCustomView.cardTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_addAreaCustomView).offset(10 *SIZE);
                        make.top.equalTo(_addAreaCustomView.phoneTF1.mas_bottom).offset(14 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [_addAreaCustomView.cardTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                       
                        make.left.equalTo(_addAreaCustomView).offset(80 *SIZE);
                        make.top.equalTo(_addAreaCustomView.phoneTF1.mas_bottom).offset(10 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }else{
                        
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                   
            //        NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *rent = [UIAlertAction actionWithTitle:@"租房客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CustomerListVC *nextVC = [[CustomerListVC alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.status = 2;
        nextVC.isSelect = YES;
        nextVC.customerListVCCustomBlock = ^(CustomerTableModel * _Nonnull model) {
            
            [BaseRequest GET:GetCliendInfo_URL parameters:@{@"client_id":model.client_id} success:^(id resposeObject) {

                if ([resposeObject[@"code"] integerValue] == 200) {
                        
                    _addAreaCustomView.nameTF.textfield.text = model.name;
                    if ([model.sex integerValue] == 1) {
                        
                        _addAreaCustomView.genderBtn.content.text = @"男";
                        _addAreaCustomView.genderBtn->str = @"1";
                    }else if ([model.sex integerValue] == 2){
                        
                        _addAreaCustomView.genderBtn.content.text = @"女";
                        _addAreaCustomView.genderBtn->str = @"2";
                    }else{
                        
                        _addAreaCustomView.genderBtn.content.text = @"";
                        _addAreaCustomView.genderBtn->str = @"";
                    }
                    _addAreaCustomView.phoneTF1.textfield.text = model.tel;
                    _addAreaCustomView.phoneTF2.hidden = YES;
                    _addAreaCustomView.phoneTF3.hidden = YES;
                    _addAreaCustomView.cardTypeBtn.content.text = model.card_type;
                    for (int i = 0; i < [[self getDetailConfigArrByConfigState:CARD_TYPE] count]; i++) {
                        
                        NSDictionary *dic = [self getDetailConfigArrByConfigState:CARD_TYPE][i];
                        if ([model.card_type isEqualToString:dic[@"param"]]) {
                            
                            _addAreaCustomView.cardTypeBtn->str = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        }
                    }
                    _addAreaCustomView.cardNumTF.textfield.text = model.card_id;
                    _addAreaCustomView.birthBtn.content.text = resposeObject[@"data"][@"basic"][@"birth"];
                    _addAreaCustomView.addressTF.textfield.text = resposeObject[@"data"][@"basic"][@"address"];
                    _addAreaCustomView.addressBtn.content.text = [NSString stringWithFormat:@"%@%@%@",resposeObject[@"data"][@"basic"][@"province_name"]?resposeObject[@"data"][@"basic"][@"province_name"]:@"",resposeObject[@"data"][@"basic"][@"city_name"]?resposeObject[@"data"][@"basic"][@"city_name"]:@"",resposeObject[@"data"][@"basic"][@"district_name"]?resposeObject[@"data"][@"basic"][@"district_name"]:@""];
                    _addAreaCustomView.addressBtn->str = [NSString stringWithFormat:@"%@%@%@",resposeObject[@"data"][@"basic"][@"province"]?resposeObject[@"data"][@"basic"][@"province"]:@"",resposeObject[@"data"][@"basic"][@"city"]?resposeObject[@"data"][@"basic"][@"city"]:@"",resposeObject[@"data"][@"basic"][@"district"]?resposeObject[@"data"][@"basic"][@"district"]:@""];
                    
                    if ([resposeObject[@"data"][@"need_info"][0][@"region"] count]) {
                        
                        _addAreaCustomView.regionBtn.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city_name"];
                        _addAreaCustomView.regionBtn->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"]];
                        _addAreaCustomView.regionBtn1.content.text = @"";
                        if (_districtArr.count) {
                            
                            for (int i = 0; i < [_districtArr count]; i++) {
                                
                                if ([resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"] integerValue] == [_districtArr[i][@"id"] integerValue]) {
                                    
                                
                                    _addAreaCustomView.regionBtn1.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district_name"];
                                    _addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district"]];
                                }
                            }
                            if (!_addAreaCustomView.regionBtn1.content.text.length) {
                                
                                _addAreaCustomView.regionBtn1.content.text = @"不限";
                                _addAreaCustomView.regionBtn1->str = @"0";
                            }
                        }else{
                            
                            [BaseRequest GET:ForumOpenDistrictList_URL parameters:@{@"city":resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"]} success:^(id resposeObject) {
                                
                            
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                                        
                                        if ([resposeObject[@"data"][@"need_info"][0][@"region"][0][@"city"] integerValue] == [resposeObject[@"data"][i][@"code"] integerValue]) {
                                            
                                        
                                            _addAreaCustomView.regionBtn1.content.text = resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district_name"];
                                            _addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"need_info"][0][@"region"][0][@"district"]];
                                        }
                                    }
                                    if (!_addAreaCustomView.regionBtn1.content.text.length) {
                                        
                                        _addAreaCustomView.regionBtn1.content.text = @"不限";
                                        _addAreaCustomView.regionBtn1->str = @"0";
                                    }

                                }else{
                                    

                                }
                            } failure:^(NSError *error) {
                                
                                
                            }];
                        }
                    }else{
                        
                        _addAreaCustomView.regionBtn.content.text = @"";
                        _addAreaCustomView.regionBtn->str = @"";
                        _addAreaCustomView.regionBtn1.content.text = @"";
                        _addAreaCustomView.regionBtn1->str = @"";
                    }
                    [_addAreaCustomView.cardTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_addAreaCustomView).offset(10 *SIZE);
                        make.top.equalTo(_addAreaCustomView.phoneTF1.mas_bottom).offset(14 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [_addAreaCustomView.cardTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                       
                        make.left.equalTo(_addAreaCustomView).offset(80 *SIZE);
                        make.top.equalTo(_addAreaCustomView.phoneTF1.mas_bottom).offset(10 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }else{
                        
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                   
            //        NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:new];
    [alert addAction:second];
    [alert addAction:rent];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_addAreaCustomView.regionBtn.content.text && !_addAreaCustomView.regionBtn1.content.text) {
        
        [self showContent:@"请选择区域"];
        return;
    }
    if (!_addAreaCustomView.nameTF.textfield.text) {
        
        [self showContent:@"请输入名称"];
        return;
    }
    if (!_addAreaCustomView.genderBtn.content.text) {
        
        [self showContent:@"请选择性别"];
        return;
    }
    if (!_addAreaCustomView.phoneTF1.textfield.text) {
        
        [self showContent:@"请输入联系电话"];
        return;
    }
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    [tempDic setValue:_addAreaCustomView.regionBtn->str forKey:@"recommend_city"];
    [tempDic setValue:_addAreaCustomView.regionBtn1->str forKey:@"recommend_district"];
    [tempDic setValue:_addAreaCustomView.regionBtn.content.text forKey:@"recommend_city_name"];
    [tempDic setValue:_addAreaCustomView.regionBtn1.content.text forKey:@"recommend_district_name"];
    [tempDic setValue:_addAreaCustomView.nameTF.textfield.text forKey:@"name"];
    [tempDic setValue:_addAreaCustomView.phoneTF1.textfield.text forKey:@"tel"];
    [tempDic setValue:_addAreaCustomView.genderBtn->str forKey:@"sex"];
    if (_addAreaCustomView.cardTypeBtn.content.text.length || _addAreaCustomView.cardNumTF.textfield.text.length) {
        
        [tempDic setValue:_addAreaCustomView.cardTypeBtn->str forKey:@"card_type"];
        [tempDic setValue:_addAreaCustomView.cardNumTF.textfield.text forKey:@"card_id"];
    }
    if (_addAreaCustomView.birthBtn.content.text.length) {
        
        [tempDic setValue:_addAreaCustomView.birthBtn.content.text forKey:@"birth"];
    }
    if (_addAreaCustomView.addressBtn.content.text.length) {
        
        [tempDic setValue:[_addAreaCustomView.addressBtn->str componentsSeparatedByString:@","][0] forKey:@"province"];
        [tempDic setValue:[_addAreaCustomView.addressBtn->str componentsSeparatedByString:@","][1] forKey:@"city"];
        [tempDic setValue:[_addAreaCustomView.addressBtn->str componentsSeparatedByString:@","][2] forKey:@"district"];
        if (_addAreaCustomView.addressTF.textfield.text.length) {
            
            [tempDic setValue:_addAreaCustomView.addressTF.textfield.text forKey:@"address"];
        }
    }
    
    NSString *img = @"";
    
    if (_img1.length) {
        
        img = [NSString stringWithFormat:@"%@",_img1];
    }
    if (_img2.length) {
        
        if (img.length) {
            
            img = [NSString stringWithFormat:@"%@,%@",img,_img2];
        }else{
            
            img = [NSString stringWithFormat:@"%@",_img2];
        }
    }
    if (_img3.length) {
        
        if (img.length) {
            
            img = [NSString stringWithFormat:@"%@,%@",img,_img3];
        }else{
            
            img = [NSString stringWithFormat:@"%@",_img3];
        }
    }
    if (img.length) {
        
        [tempDic setValue:img forKey:@"card_img"];
    }
    AddAreaNeedVC *nextVC = [[AddAreaNeedVC alloc] initWithDataDic:tempDic];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)updateheadimgbyimg:(UIImage *)img
{
    NSData *data = [self resetSizeOfImageData:img maxSize:150];
    
    [BaseRequest Updateimg:UploadFile_URL parameters:@{
                                                @"file_name":@"img"
                                                    }
          constructionBody:^(id<AFMultipartFormData> formData) {
              [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
    } success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            NSDictionary *dic = @{@"head_img":resposeObject[@"data"]};
            [BaseRequest POST:RentSurveyUpdateImg_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (_idx == 0) {
                        
                        _img1 = resposeObject[@"data"];
                        [_addAreaCustomView.positiveImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_img1]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            
                            if (error) {
                                
                                _addAreaCustomView.positiveImg.image = [UIImage imageNamed:@"banner_default_2"];
                            }
                        }];
                    }else if (_idx == 1){
                        
                        _img2 = resposeObject[@"data"];
                        [_addAreaCustomView.positiveImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_img2]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            
                            if (error) {
                                
                                _addAreaCustomView.positiveImg.image = [UIImage imageNamed:@"banner_default_2"];
                            }
                        }];
                    }else{
                        
                        _img3 = resposeObject[@"data"];
                        [_addAreaCustomView.positiveImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_img3]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            
                            if (error) {
                                
                                _addAreaCustomView.positiveImg.image = [UIImage imageNamed:@"banner_default_2"];
                            }
                        }];
                    }
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
               

                [self showContent:@"网络错误"];
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
    self.titleLabel.text = @"添加客户";
    
    _scroll = [[UIScrollView alloc] init];//WithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    _header = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _header.titleL.text = @"基本信息";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270 *SIZE, 5 *SIZE, 80 *SIZE, 30 *SIZE);
    [btn setTitle:@"选择已有客户" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [btn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:btn];
    [_scroll addSubview:_header];
    
    SS(strongSelf);
    _addAreaCustomView = [[AddAreaCustomView alloc] initWithFrame:CGRectZero];
    _addAreaCustomView.addAreaCustomViewStrBlock = ^(NSString * _Nonnull str) {
      
        if (str.length) {
            
            if (![strongSelf validateIDCardNumber:str]) {
            
                [strongSelf showContent:@"请输入正确的身份证号"];
            }
        }
    };
    _addAreaCustomView.addAreaCustomViewImgBlock = ^(NSInteger idx) {
      
        [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {

            if (image) {
                
                if (idx == 0) {
                    
                    strongSelf->_addAreaCustomView.positiveImg.image = image;
                }else if (idx == 1){
                    
                    strongSelf->_addAreaCustomView.backImg.image = image;
                }else{
                    
                    strongSelf->_addAreaCustomView.otherImg.image = image;
                }
            }
        }];
    };
    _addAreaCustomView.addAreaCustomViewTagBlock = ^(NSInteger idx) {
      
        if (idx == 0) {
            
            if (strongSelf->_cityArr.count) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_cityArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    strongSelf->_addAreaCustomView.regionBtn.content.text = MC;
                    strongSelf->_addAreaCustomView.regionBtn->str = [NSString stringWithFormat:@"%@",ID];
                    strongSelf->_addAreaCustomView.regionBtn1.content.text = @"";
                    strongSelf->_addAreaCustomView.regionBtn1->str = @"";
                    strongSelf->_ruleL.text = @"";
                };
                [strongSelf.view addSubview:view];
            }else{
                
                [BaseRequest GET:ForunOpenCityList_URL parameters:@{} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                            
                            [strongSelf->_cityArr addObject:@{@"param":resposeObject[@"data"][i][@"city_name"],@"id":resposeObject[@"data"][i][@"city_code"]}];
                        }
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_cityArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            strongSelf->_addAreaCustomView.regionBtn.content.text = MC;
                            strongSelf->_addAreaCustomView.regionBtn->str = [NSString stringWithFormat:@"%@",ID];
                            strongSelf->_addAreaCustomView.regionBtn1.content.text = @"";
                            strongSelf->_addAreaCustomView.regionBtn1->str = @"";
                            strongSelf->_ruleL.text = @"";
                        };
                        [strongSelf.view addSubview:view];
                    }else{
                        
                        [strongSelf showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [strongSelf showContent:@"网络错误"];
                }];
            }
        }else if (idx == 1){
            
            if (!strongSelf->_addAreaCustomView.regionBtn.content.text.length) {
                
                [strongSelf showContent:@"请先选择城市"];
            }else{
                
                [BaseRequest GET:ForumOpenDistrictList_URL parameters:@{@"city":strongSelf->_addAreaCustomView.regionBtn->str} success:^(id resposeObject) {
                    
                    [strongSelf->_districtArr removeAllObjects];
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                            
                            [strongSelf->_districtArr addObject:@{@"param":resposeObject[@"data"][i][@"name"],@"id":resposeObject[@"data"][i][@"code"]}];
                        }
                        [strongSelf->_districtArr insertObject:@{@"param":@"不限",@"id":@"0"} atIndex:0];
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_districtArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            strongSelf->_addAreaCustomView.regionBtn1.content.text = MC;
                            strongSelf->_addAreaCustomView.regionBtn1->str = [NSString stringWithFormat:@"%@",ID];
                            [strongSelf RuleRequest];
                        };
                        [strongSelf.view addSubview:view];
                    }else{
                        
                        [strongSelf showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [strongSelf showContent:@"网络错误"];
                }];
            }
        }else if (idx == 2){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                strongSelf->_addAreaCustomView.genderBtn.content.text = @"男";
                strongSelf->_addAreaCustomView.genderBtn->str = @"1";
            }];
            
            UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                strongSelf->_addAreaCustomView.genderBtn.content.text = @"女";
                strongSelf->_addAreaCustomView.genderBtn->str = @"2";
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
               
            }];
            
            [alert addAction:male];
            [alert addAction:female];
            [alert addAction:cancel];
            
            [strongSelf.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
        }else if (idx == 3){
            
            SinglePickView *view = [[SinglePickView alloc]initWithFrame:strongSelf.view.frame WithData:[strongSelf getDetailConfigArrByConfigState:CARD_TYPE]];
            
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
                strongSelf->_addAreaCustomView.cardTypeBtn.content.text = MC;
                strongSelf->_addAreaCustomView.cardTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [strongSelf.view addSubview:view];
        }else if (idx == 4){
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_addAreaCustomView.birthBtn.content.text = [strongSelf->_dateFormatter stringFromDate:date];
            };
            [strongSelf.view addSubview:view];
        }else if (idx == 5){
            
            AdressChooseView *view = [[AdressChooseView alloc]initWithFrame:strongSelf.view.frame withdata:@[]];
            view.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
                
                strongSelf->_addAreaCustomView.addressBtn.content.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
                strongSelf->_addAreaCustomView.addressBtn->str = [NSString stringWithFormat:@"%@,%@,%@",proviceid,cityid,areaid];
            };
            [strongSelf.view addSubview:view];
        }
    };
    [_scroll addSubview:_addAreaCustomView];
    
    _ruleHeader = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _ruleHeader.titleL.text = @"区域公示规则";
    [_scroll addSubview:_ruleHeader];
    
    _ruleL = [[UILabel alloc] init];
    _ruleL.textColor = YJTitleLabColor;
    _ruleL.numberOfLines = 0;
    _ruleL.adjustsFontSizeToFitWidth = YES;
    _ruleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_scroll addSubview:_ruleL];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 360 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_scroll addSubview:_nextBtn];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }];
    
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scroll).offset(0);
        make.top.equalTo(self->_scroll).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_addAreaCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scroll).offset(0);
        make.top.equalTo(self->_header.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
//        make.bottom.equalTo(_scroll.mas_bottom).offset(0);
    }];
    
    [_ruleHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scroll).offset(0);
        make.top.equalTo(self->_addAreaCustomView.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_ruleHeader.mas_bottom).offset(0);
        make.width.mas_equalTo(340 *SIZE);
//        make.bottom.equalTo(_scroll.mas_bottom).offset(0);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scroll).offset(40 *SIZE);
        make.top.equalTo(self->_ruleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self->_scroll.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
