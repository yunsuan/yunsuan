//
//  StoreAuthStatusVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "StoreAuthStatusVC.h"

#import "BaseFrameHeader.h"

@interface StoreAuthStatusVC ()
{
    
    NSDictionary *_data;
}

@property (nonatomic, strong) UIView *statusView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *detailView;

@property (nonatomic, strong) UILabel *permitL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation StoreAuthStatusVC

- (instancetype)initWithData:(NSDictionary *)data;
{
    self = [super init];
    if (self) {
        
        _data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionPhoneTap{
    
    NSString *phone = [NSString stringWithFormat:@"%@",_data[@"contact_tel"]];
    if (phone.length) {
        
        //获取目标号码字符串,转换成URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
        //调用系统方法拨号
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
    }
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [BaseRequest GET:@"agent/personal/store/auth/cancel" parameters:@{@"id":_data[@"id"]} success:^(id resposeObject) {
        
        [self showContent:resposeObject[@"msg"]];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"取消认证成功" And:nil WithDefaultBlack:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        //        NSLog(@"%@",error);
    }];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"审核状态";
    
    _statusView = [[UIView alloc] init];
    _statusView.backgroundColor = YJBlueBtnColor;
    [self.view addSubview:_statusView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 31 *SIZE, SCREEN_Width, 17 *SIZE)];
    label.textColor = CH_COLOR_white;;
    label.font = [UIFont systemFontOfSize:19 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"审核中";
    [_statusView addSubview:label];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CH_COLOR_white;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.numberOfLines = 0;
    _nameL.text = [NSString stringWithFormat:@"门店名称：%@",_data[@"store_name"]];
    [_statusView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CH_COLOR_white;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _codeL.numberOfLines = 0;
    _codeL.text = [NSString stringWithFormat:@"门店编号：%@",_data[@"store_code"]];
    [_statusView addSubview:_codeL];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = CH_COLOR_white;
    _contactL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contactL.numberOfLines = 0;
    _contactL.text = [NSString stringWithFormat:@"门店负责人：%@",_data[@"contact"]];
    [_statusView addSubview:_contactL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CH_COLOR_white;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.numberOfLines = 0;
    
    NSString *str = [NSString stringWithFormat:@"负责人电话：%@",_data[@"contact_tel"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:CH_COLOR_white range:NSMakeRange(6, str.length - 6)];
    _phoneL.attributedText = attr;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionPhoneTap)];
    [_phoneL addGestureRecognizer:tap];
    _phoneL.userInteractionEnabled = YES;
    [_statusView addSubview:_phoneL];
    
    _detailView = [[UIView alloc] init];
    _detailView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_detailView];
    
    BaseFrameHeader *header = [[BaseFrameHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"申请信息";
    header.lineView.hidden = YES;
    [_detailView addSubview:header];
    
    _permitL = [[UILabel alloc] init];
    _permitL.textColor = YJContentLabColor;
    _permitL.font = [UIFont systemFontOfSize:13 *SIZE];
    _permitL.numberOfLines = 0;
    _permitL.text = [NSString stringWithFormat:@"申请权限：%@",_data[@"role"]];
    [_detailView addSubview:_permitL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.numberOfLines = 0;
    _timeL.text = [NSString stringWithFormat:@"申请时间：%@",_data[@"entry_time"]];
    [_detailView addSubview:_timeL];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 2 *SIZE;
    _cancelBtn.backgroundColor = YJLoginBtnColor;
    [_cancelBtn setTitle:@"取消认证" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_statusView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_statusView).offset(29 *SIZE);
        make.top.equalTo(_statusView).offset(69 *SIZE);
        make.right.equalTo(_statusView).offset(-29 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_statusView).offset(29 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_statusView).offset(-29 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_statusView).offset(29 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_statusView).offset(-29 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_statusView).offset(29 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_statusView).offset(-29 *SIZE);
        make.bottom.equalTo(_statusView.mas_bottom).offset(-22 *SIZE);
    }];
    
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(_statusView.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
    }];

    [_permitL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_detailView).offset(29 *SIZE);
        make.top.equalTo(_detailView).offset(54 *SIZE);
        make.right.equalTo(_detailView).offset(-29 *SIZE);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_detailView).offset(29 *SIZE);
        make.top.equalTo(_permitL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(_detailView).offset(-29 *SIZE);
        make.bottom.equalTo(_detailView).offset(-29 *SIZE);
    }];
}

@end
