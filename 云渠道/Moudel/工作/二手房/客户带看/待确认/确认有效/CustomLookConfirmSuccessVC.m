//
//  CustomLookConfirmSuccessVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomLookConfirmSuccessVC.h"

#import "CustomLookVC.h"
#import "LookWorkVC.h"

#import "DropDownBtn.h"
#import "DateChooseView.h"

@interface CustomLookConfirmSuccessVC ()
{
    
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *dateL;

@property (nonatomic, strong) DropDownBtn *dateBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation CustomLookConfirmSuccessVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _dataDic = dataDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initDataSource];
}

- (void)initDataSource{
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_dateBtn.content.text.length) {

        [self alertControllerWithNsstring:@"温馨提示" And:@"选择预约带看时间"];
        return;
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"take_id":_dataDic[@"take_id"],
                                                                               @"take_time":_dateBtn.content.text
                                                                               }];
    if (![self isEmpty:_reasonTV.text]) {

        [dic setObject:_reasonTV.text forKey:@"take_comment"];
    }
    [BaseRequest GET:TakeConfirmValue_URL parameters:dic success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self alertControllerWithNsstring:@"温馨提示" And:@"确认成功" WithDefaultBlack:^{

                if (self.customLookConfirmSuccessVCBlock) {

                    self.customLookConfirmSuccessVCBlock();
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

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
    [view.pickerView setMinimumDate:[NSDate date]];
    [view.pickerView setCalendar:[NSCalendar currentCalendar]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:15];//设置最大时间为：当前时间推后10天
    [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
    
    SS(strongSelf);
    view.dateblock = ^(NSDate *date) {
        
        strongSelf.dateBtn.content.text = [NSString stringWithFormat:@"%@",[self.dateFormatter stringFromDate:date]];
    };
    [self.view addSubview:view];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"带看计划";
    
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
    
    _dateL = [[UILabel alloc] init];
    _dateL.font = [UIFont systemFontOfSize:13 *SIZE];
    _dateL.textColor = YJTitleLabColor;
    _dateL.adjustsFontSizeToFitWidth = YES;
    _dateL.text = @"预约带看时间：";
    [_contentView addSubview:_dateL];
    
    
    _dateBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 257 *SIZE, 33 *SIZE)];
    [_dateBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_dateBtn];
    
    _markL = [[UILabel alloc] init];
    _markL.font = [UIFont systemFontOfSize:13 *SIZE];
    _markL.textColor = YJTitleLabColor;
    _markL.text = @"带看备注：";
    [_contentView addSubview:_markL];
    
    _reasonTV = [[UITextView alloc] init];
    _reasonTV.layer.cornerRadius = 2 *SIZE;
    _reasonTV.layer.borderWidth = SIZE;
    _reasonTV.layer.borderColor = YJBackColor.CGColor;
    _reasonTV.clipsToBounds = YES;
    [_contentView addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 494 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
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
        make.top.equalTo(_infoView.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_dateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(17 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_contentView).offset(11 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_dateBtn.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_reasonTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(80 *SIZE);
        make.top.equalTo(_dateBtn.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(70 *SIZE);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-10 *SIZE);
    }];
}
@end
