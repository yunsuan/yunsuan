//
//  MakeDateLookVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MakeDateLookVC.h"

#import "LookMaintainDetailAddAppointVC.h"

#import "DateChooseView.h"

#import "DropDownBtn.h"
#import "BaseHeader.h"

@interface MakeDateLookVC ()
{
    
    LookMaintainDetailAddAppointRoomModel *_model;
}
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseHeader *header;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation MakeDateLookVC

- (instancetype)initWithModel:(LookMaintainDetailAddAppointRoomModel *)model
{
    self = [super init];
    if (self) {
        
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    
    [view.pickerView setMinimumDate:[NSDate date]];
    [view.pickerView setCalendar:[NSCalendar currentCalendar]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:15];//设置最大时间为：当前时间推后10天
    [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
    
    __weak __typeof(&*self)weakSelf = self;
    view.dateblock = ^(NSDate *date) {
        
        weakSelf.timeBtn.content.text = [weakSelf.formatter stringFromDate:date];
    };
    [self.view addSubview:view];
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    if (!_timeBtn.content.text) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择预约时间"];
        return;
    }
    
    if (self.makeDateLookVCBlock) {
        
        self.makeDateLookVCBlock(@{@"model":_model,@"take_time":_timeBtn.content.text});
    }
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[LookMaintainDetailAddAppointVC class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"预约看房";
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _header.titleL.text = @"预约看房";
    [_contentView addSubview:_header];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            _seeWayL = label;
            _seeWayL.text = [NSString stringWithFormat:@"看房方式：%@",_model.check_way];
            [_contentView addSubview:_seeWayL];
        }else if (i == 1){
            
            _contactL = label;
            _contactL.text = [NSString stringWithFormat:@"联系人：%@",_model.contact_name];
            [_contentView addSubview:_contactL];
        }else{
            
            _phoneL = label;
            _phoneL.text = [NSString stringWithFormat:@"联系电话：%@",_model.contact_tel];
            [_contentView addSubview:_phoneL];
        }
    }
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJTitleLabColor;
    _timeL.text = @"时间：";
    _timeL.adjustsFontSizeToFitWidth = YES;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_contentView addSubview:_timeL];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 291 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_timeBtn];
    
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_commitBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT + SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(27 *SIZE);
        make.top.equalTo(_contentView).offset(54 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(27 *SIZE);
        make.top.equalTo(_seeWayL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(27 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(10 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(45 *SIZE);
        make.width.mas_equalTo(35 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(47 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(291 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-33 *SIZE);
    }];
}

@end
