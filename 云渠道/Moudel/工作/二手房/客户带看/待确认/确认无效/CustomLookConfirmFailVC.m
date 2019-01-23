//
//  CustomLookConfirmFailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookConfirmFailVC.h"

#import "SinglePickView.h"

#import "DropDownBtn.h"

@interface CustomLookConfirmFailVC ()
{
    
    NSString *_type;
    NSString *_surveyId;
}
@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation CustomLookConfirmFailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initDataSource];
}

- (void)initDataSource{
    
    _typeL.text = @":";
    _reasonL.text = @"申诉描述:";
    //    _timeL.text = @"申诉时间：2017/12/12  13:00";
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_type.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"选择申诉类型"];
        return;
    }
    
    //    if ([self isEmpty:_reasonTV.text]) {
    //
    //        [self alertControllerWithNsstring:@"温馨提示" And:@"输入申诉描述"];
    //        return;
    //    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"survey_id":_surveyId,
                                                                               @"type":_type,
                                                                               @"appeal_type":@"2"
                                                                               }];
    if (![self isEmpty:_reasonTV.text]) {
        
        [dic setObject:_reasonTV.text forKey:@"comment"];
    }
    [BaseRequest POST:HouseRecordAppeal_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"申诉成功" WithDefaultBlack:^{
                
                [self.navigationController popViewControllerAnimated:YES];
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
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:24]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_type = [NSString stringWithFormat:@"%@",ID];
        strongSelf.typeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"申诉";
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = YJBackColor;
    [self.view addSubview:_infoView];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = YJContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_infoView addSubview:_contactL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_infoView addSubview:_phoneL];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i < 2) {
            
            label.numberOfLines = 0;
            label.textColor = YJTitleLabColor;
            if (i == 0) {
                
                _typeL = label;
                [_contentView addSubview:_typeL];
            }else{
                
                _reasonL = label;
                [_contentView addSubview:_reasonL];
            }
        }else{
            
            label.textColor = YJContentLabColor;
            _timeL = label;
            [_contentView addSubview:_timeL];
        }
    }
    
    _typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 17 *SIZE, 257 *SIZE, 33 *SIZE)];
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
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(27 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_contentView).offset(17 *SIZE);
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
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_reasonTV.mas_bottom).offset(24 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
        make.bottom.equalTo(_contentView).offset(-19 *SIZE);
    }];
}
@end
