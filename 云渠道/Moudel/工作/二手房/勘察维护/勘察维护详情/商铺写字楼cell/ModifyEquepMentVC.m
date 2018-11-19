//
//  ModifyEquepMentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ModifyEquepMentVC.h"

#import "BorderTF.h"
#import "DropDownBtn.h"
#import "SinglePickView.h"

@interface ModifyEquepMentVC ()
{
    
    NSInteger _type;
}
@property (nonatomic, strong) UIView *nearView;

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

@implementation ModifyEquepMentVC

- (instancetype)initWithType:(NSInteger )type
{
    self = [super init];
    if (self) {
        
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    
}

- (void)ActionSeeWayBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:31]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf.seeWayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
        //        strongSelf->_seeWay = [NSString stringWithFormat:@"%@",ID];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"左云右算";
    
    _nearView = [[UIView alloc] init];
    _nearView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_nearView];
    
    NSArray *nearArr;
    if (_type == 2) {
        
         nearArr = @[@"左边商铺：",@"右边商铺：",@"看房方式：",@"其他要求："];
    }else{
        
         nearArr = @[@"左边公司：",@"右边公司：",@"看房方式：",@"其他要求："];
    }
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
            
            _leftTF = textFeild;
            [_nearView addSubview:_leftTF];
        }else{
            
            _rightTF = textFeild;
            [_nearView addSubview:_rightTF];
        }
    }
    
    _seeWayBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 118 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_seeWayBtn addTarget:self action:@selector(ActionSeeWayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nearView addSubview:_seeWayBtn];
    
    _markView = [[UITextView alloc] initWithFrame:CGRectMake(79 *SIZE, 171 *SIZE, 258 *SIZE, 100 *SIZE)];
    _markView.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markView.layer.borderWidth = SIZE;
    _markView.layer.cornerRadius = 5 *SIZE;
    _markView.clipsToBounds = YES;
    [_nearView addSubview:_markView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - TABBAR_Height - 40 *SIZE, SCREEN_Width, 40 *SIZE + TABBAR_Height);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_nextBtn];
    
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
    
}

@end
