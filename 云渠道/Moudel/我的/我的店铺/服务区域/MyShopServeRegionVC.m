//
//  MyShopServeRegionVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopServeRegionVC.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

#import "SinglePickView.h"

@interface MyShopServeRegionVC ()<UITextFieldDelegate>
{
    
    NSMutableArray *_cityArr;
    NSMutableArray *_districtArr;
}
@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) DropDownBtn *regionBtn;

@property (nonatomic, strong) DropDownBtn *regionBtn1;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation MyShopServeRegionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _cityArr = [@[] mutableCopy];
    _districtArr = [@[] mutableCopy];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    SS(strongSelf);
    if (btn.tag == 0) {
        
        if (strongSelf->_cityArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_cityArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                strongSelf->_regionBtn.content.text = MC;
                strongSelf->_regionBtn->str = [NSString stringWithFormat:@"%@",ID];
                strongSelf->_regionBtn.placeL.hidden = YES;
                strongSelf->_regionBtn1.content.text = @"";
                strongSelf->_regionBtn1->str = @"";
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
                        
                        strongSelf->_regionBtn.content.text = MC;
                        strongSelf->_regionBtn->str = [NSString stringWithFormat:@"%@",ID];
                        strongSelf->_regionBtn.placeL.hidden = YES;
                        strongSelf->_regionBtn1.content.text = @"";
                        strongSelf->_regionBtn1->str = @"";
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    [strongSelf showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [strongSelf showContent:@"网络错误"];
            }];
        }
    }else if (btn.tag == 1){
        
        if (!strongSelf->_regionBtn.content.text.length) {
            
            [strongSelf showContent:@"请先选择城市"];
        }else{
            
            [strongSelf->_districtArr removeAllObjects];
            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
            
            NSError *err;
            NSArray *pro = [NSJSONSerialization JSONObjectWithData:JSONData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
            NSMutableArray * tempArr = [@[] mutableCopy];
            for (NSDictionary *proDic in pro) {
                
                for (NSDictionary *cityDic in proDic[@"city"]) {
                    
                    if ([cityDic[@"code"] integerValue] == [strongSelf->_regionBtn->str integerValue]) {
                        
//                        tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                        for (int i = 0 ; i < [cityDic[@"district"] count]; i++) {
                            
                            [tempArr addObject:@{@"id":cityDic[@"district"][i][@"code"],@"param":cityDic[@"district"][i][@"name"]}];
                        }
                        break;
                    }
                }
            }
            [tempArr insertObject:@{@"id":@"0",@"param":@"不限"} atIndex:0];
            _districtArr = [NSMutableArray arrayWithArray:tempArr];
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_districtArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                strongSelf->_regionBtn1.content.text = MC;
                strongSelf->_regionBtn1->str = [NSString stringWithFormat:@"%@",ID];
                strongSelf->_regionBtn1.placeL.hidden = YES;
            };
            [strongSelf.view addSubview:view];
        }
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_regionBtn.content.text) {
        
        [self showContent:@"请选择城市"];
        return;
    }
    NSString *str = _regionBtn.content.text;
    if ([_regionBtn1->str integerValue]) {
        
        str = [NSString stringWithFormat:@"%@%@",str,_regionBtn1.content.text];
    }
    if (![self isEmpty:_nameTF.textfield.text]) {
        
        str = [NSString stringWithFormat:@"%@%@",str,_nameTF.textfield.text];
    }
    
    if (self.myShopServeRegionVCBlock) {
        
        self.myShopServeRegionVCBlock(str);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"新增服务区域";
    
    self.view.backgroundColor = CLWhiteColor;
    
    NSArray *arr = @[@"城市区域：",@""];
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = arr[i];
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            
            case 0:
            {
                  
                _regionL = label;
                [self.view addSubview:_regionL];
                
                _regionBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                _regionBtn.tag = i;
                _regionBtn.placeL.hidden = NO;
                _regionBtn.placeL.text = @"请选择城市";
                [_regionBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_regionBtn];
                
                _nameTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                _nameTF.textfield.delegate = self;
                _nameTF.textfield.placeholder = @"请输入详细地址";
                [self.view addSubview:_nameTF];
                break;
            }
            case 1:
            {
                
                _regionBtn1 = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                _regionBtn1.tag = i;
                _regionBtn1.placeL.text = @"请选择区/县";
                _regionBtn1.placeL.hidden = NO;
                [_regionBtn1 addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:_regionBtn1];
                
                break;
            }
        }
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [_nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{

    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self.view).offset(14 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_regionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(self.view).offset(10 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];

    [_regionBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(218 *SIZE);
        make.top.equalTo(self.view).offset(10 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(_regionBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
}

@end
