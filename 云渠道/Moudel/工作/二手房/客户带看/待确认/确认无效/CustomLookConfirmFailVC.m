//
//  CustomLookConfirmFailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookConfirmFailVC.h"

#import "CustomLookVC.h"
#import "LookWorkVC.h"

#import "SinglePickView.h"

#import "DropDownBtn.h"

@interface CustomLookConfirmFailVC ()
{
    
    NSString *_type;
    NSString *_surveyId;
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *typeContentL;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UIView *reasonView;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation CustomLookConfirmFailVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
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
    

}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_type.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"选择失效类型"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"take_id":_dataDic[@"take_id"],
                                                                               @"disabled_state":_type}];
    if (![self isEmpty:_reasonTV.text]) {
        
        [dic setObject:_reasonTV.text forKey:@"disabled_reason"];
    }
    [BaseRequest GET:TakeConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"失效成功" WithDefaultBlack:^{
                
                if (self.customLookConfirmFailVCBlock) {
                    
                    self.customLookConfirmFailVCBlock();
                }
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CustomLookVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                    if ([vc isKindOfClass:[LookWorkVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
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
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:53]];
    SS(strongSelf);
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        strongSelf->_type = [NSString stringWithFormat:@"%@",ID];
        strongSelf.typeContentL.text = [NSString stringWithFormat:@"%@",MC];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客源无效申请";
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = YJBackColor;
    [self.view addSubview:_infoView];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = YJContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contactL.text = [NSString stringWithFormat:@"联系人：%@",_dataDic[@"client_name"]];
    [_infoView addSubview:_contactL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",_dataDic[@"client_tel"]];
    [_infoView addSubview:_phoneL];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    _typeL = [[UILabel alloc] init];
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _typeL.numberOfLines = 0;
    _typeL.textColor = YJTitleLabColor;
    _typeL.text = @"无效类型";
    [_contentView addSubview:_typeL];
    
    _typeContentL = [[UILabel alloc] init];
    _typeContentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _typeContentL.numberOfLines = 0;
    _typeContentL.textColor = YJTitleLabColor;
    _typeContentL.textAlignment = NSTextAlignmentRight;
    [_contentView addSubview:_typeContentL];
    
    _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_typeBtn];
    
    _reasonView = [[UIView alloc] init];
    _reasonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_reasonView];
    
    _reasonTV = [[UITextView alloc] init];
    [_reasonView addSubview:_reasonTV];
    
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
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_infoView).offset(14 *SIZE);
        make.right.equalTo(_infoView).offset(-9 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_infoView).offset(-9 *SIZE);
        make.bottom.equalTo(_infoView.mas_bottom).offset(-14 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(_infoView.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_typeContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100 *SIZE);
        make.top.equalTo(_contentView).offset(15 *SIZE);
        make.right.equalTo(_contentView).offset(-10 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(0 *SIZE);
        make.top.equalTo(_contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width *SIZE);
        make.height.mas_equalTo(43 *SIZE);
        make.bottom.equalTo(_contentView.mas_bottom).offset(0 *SIZE);
    }];
    
    [_reasonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(_contentView.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_reasonTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_reasonView).offset(10 *SIZE);
        make.top.equalTo(_reasonView).offset(13 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(90 *SIZE);
        make.bottom.equalTo(_reasonView.mas_bottom).offset(-10 *SIZE);
    }];
}
@end
