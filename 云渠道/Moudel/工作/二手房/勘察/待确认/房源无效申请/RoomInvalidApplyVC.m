//
//  RoomInvalidApplyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomInvalidApplyVC.h"
#import "RoomSurveyVC.h"
#import "SystemoWorkVC.h"

#import "SinglePickView.h"

#import "DropDownBtn.h"

@interface RoomInvalidApplyVC ()
{
    
    NSString *_type;
    NSDictionary *_dataDic;
    NSString *_surveyId;
}

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;


@end

@implementation RoomInvalidApplyVC

- (instancetype)initWithData:(NSDictionary *)data SurveyId:(NSString *)surveyId
{
    self = [super init];
    if (self) {
        
        _surveyId = surveyId;
        _dataDic = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initDataSource];
}

- (void)initDataSource{
    
    _roomL.text = [NSString stringWithFormat:@"%@",_dataDic[@"house"]];
    _codeL.text = [NSString stringWithFormat:@"房源编号：%@",_dataDic[@"house_code"]];
    _storeL.text = [NSString stringWithFormat:@"归属门店：%@",_dataDic[@"store_name"]];
    _typeL.text = @"无效类型:";
    _reasonL.text = @"无效描述:";
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_type.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择无效类型"];
        return;
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"survey_id":_surveyId,
                                                                               @"disabled_state":_type
                                                                               }];
    if (![self isEmpty:_reasonTV.text]) {
        
        [dic setObject:_reasonTV.text forKey:@"disabled_reason"];
    }
    [BaseRequest GET:HouseRecordDisabled_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"房源失效成功" WithDefaultBlack:^{
                
                if (self.roomInvalidApplyVCBlock) {
                    
                    self.roomInvalidApplyVCBlock();
                }
                NSLog(@"%@",self.navigationController.viewControllers);
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[RoomSurveyVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                        break;
                    }
                    if ([vc isKindOfClass:[SystemoWorkVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                        break;
                    }
                }
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:32]];
    
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_type = [NSString stringWithFormat:@"%@",ID];
        strongSelf.typeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房源无效申请";
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i < 3) {
            
            label.numberOfLines = 0;
            label.textColor = YJTitleLabColor;
            if (i == 0) {
                
                _roomL = label;
                [_contentView addSubview:_roomL];
            }else if (i == 1){
                
                _codeL = label;
                [_contentView addSubview:_codeL];
            }else{
                
                _storeL = label;
                [_contentView addSubview:_storeL];
            }
        }else{
            
            label.textColor = YJ86Color;
            if (i == 3) {
                
                _typeL = label;
                [_contentView addSubview:_typeL];
            }else{
                
                _reasonL = label;
                [_contentView addSubview:_reasonL];
            }
        }
    }
    
    _typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 114 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_typeBtn];
    
    _reasonTV = [[UITextView alloc] init];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.clipsToBounds = YES;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    [_contentView addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 494 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT *SIZE);
        make.right.equalTo(self.view).offset(0 *SIZE);
        //        make.width.mas_equalTo(SCREEN_Width);
        //        make.height.mas_equalTo(SIZE);
        //        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(14 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(34 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(35 *SIZE);
        make.right.equalTo(_contentView).offset(-280 *SIZE);
        make.bottom.equalTo(_contentView).offset(-72 *SIZE);
    }];
    
    [_reasonTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
}


@end
