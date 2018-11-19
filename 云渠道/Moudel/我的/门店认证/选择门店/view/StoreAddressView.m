//
//  StoreAddressView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "StoreAddressView.h"

#define PICKERHEIGHT 216
#define BGHEIGHT     256

#define KEY_WINDOW_HEIGHT [UIApplication sharedApplication].keyWindow.frame.size.height

@interface StoreAddressView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSMutableArray *_nextArr;
}
/**
 pickerView
 */
@property(nonatomic, strong) UIPickerView * pickerView;
/**
 bgView
 */
@property(nonatomic, strong) UIView * bgView;

/**
 toolBar
 */
@property(nonatomic, strong) UIView * toolBar;

/**
 取消按钮
 */
@property(nonatomic, strong) UIButton * cancleBtn;

/**
 确定按钮
 */
@property(nonatomic, strong) UIButton * sureBtn;

/**
 所有数据
 */
@property(nonatomic, strong) NSArray * dataSource;

/**
 记录省选中的位置
 */
@property(nonatomic, assign) NSInteger selected;

/**
 选中的省/市/区
 */
@property(nonatomic, copy) NSString * name;

@property(nonatomic , copy)NSString *codeId;

@end


@implementation StoreAddressView

#pragma mark -- lazy

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleBtn setTitleColor:COLOR(18, 183, 245, 1) forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:COLOR(18, 183, 245, 1) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.backgroundColor = [UIColor clearColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BGHEIGHT - PICKERHEIGHT)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, BGHEIGHT - PICKERHEIGHT, self.frame.size.width, PICKERHEIGHT)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data
{
    if (self = [super initWithFrame:frame]) {
        self.selected = 0;
        
        _nextArr = [@[] mutableCopy];
        _dataSource = data;
        _name = _dataSource[0][@"name"];
        _codeId = _dataSource[0][@"code"];
        if (_dataSource[0][@"city"]) {
            
            _nextArr = [NSMutableArray arrayWithArray: _dataSource[0][@"city"]];
        }else if (_dataSource[0][@"district"]){
            
            _nextArr = [NSMutableArray arrayWithArray: _dataSource[0][@"district"]];
        }
//        [self loadDatas];
        [self initSuViews];
    }
    return self;
}


#pragma mark -- 从plist里面读数据
//- (void)loadDatas
//{
//    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
//
//    NSError *err;
//    _dataSource = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                  options:NSJSONReadingMutableContainers
//                                                    error:&err];
//    [self getprovincearray];
//    [self getCityArrayByprovince:0];
//    [self getAreaArrayBycity:0];
//    self.provinceStr = self.provinceArray[0][@"name"];
//    self.provinceid = self.provinceArray[0][@"code"];
//    self.cityStr = self.cityArray[0][@"name"];
//    self.cityid = self.cityArray[0][@"code"];
//
//    if ([self.areaArray isKindOfClass:[NSNull class]]) {
//        self.areaStr = self.cityStr;
//        self.areaid = self.cityid;
//    }else{
//        self.areaStr = self.areaArray[0][@"name"];
//        self.areaid = self.areaArray[0][@"code"];
//    }
//}

//-(void)getprovincearray
//{
//    _provinceArray = _dataSource;
//}

//-(void)getCityArrayByprovince:(NSInteger)num
//{
//    _cityArray = _provinceArray[num][@"city"];
//}
//
//
//-(void)getAreaArrayBycity:(NSInteger )num
//{
//    _areaArray = _cityArray[num][@"district"];
//}





#pragma mark -- loadSubViews
- (void)initSuViews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self.pickerView];
    [self.toolBar addSubview:self.cancleBtn];
    [self.toolBar addSubview:self.sureBtn];
    [self showPickerView];
}

#pragma mark -- showPickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _bgView.frame = CGRectMake(0, self.frame.size.height - BGHEIGHT, self.frame.size.width, BGHEIGHT);
    }];
}


- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT);
        
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _dataSource.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _dataSource[row][@"name"];

    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    self.name = _dataSource[row][@"name"];
    self.codeId = _dataSource[row][@"code"];
    if (_dataSource[row][@"city"]) {
        
        _nextArr = [NSMutableArray arrayWithArray:_dataSource[row][@"city"]];
    }else{
        
        _nextArr = [NSMutableArray arrayWithArray:_dataSource[row][@"district"]];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
//    self.storeAddressViewBlock(self.codeId, self.name);
    if (self.storeAddressViewBlock) {
        
        self.storeAddressViewBlock(self.codeId, self.name, _nextArr);
    }
//    if (self.selectedBlock != nil) {
//        self.selectedBlock(self.provinceStr,self.cityStr,self.areaStr,self.provinceid,self.cityid,self.areaid);
//    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}

@end
