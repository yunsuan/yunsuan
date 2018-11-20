//
//  ReportCustomSuccessView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportCustomSuccessView.h"

@implementation ReportCustomSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.reportCustomSuccessViewBlock) {
        
        self.reportCustomSuccessViewBlock();
    }
    [self removeFromSuperview];
}


- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = @"恭喜您推荐成功";
    
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project"]];
    _nameL.text = [NSString stringWithFormat:@"姓名：%@",dataDic[@"name"]];
    
    _sexImg.image = [dataDic[@"sex"] integerValue] == 2?[UIImage imageNamed:@"girl"]:[UIImage imageNamed:@"man"];
    _phoneL.text = @"联系电话：";
    _phone1.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(0, 1)];
    _phone2.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(1, 1)];
    _phone3.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(2, 1)];
    
    _phone8.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(7, 1)];
    _phone9.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(8, 1)];
    _phone10.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(9, 1)];
    _phone11.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(10, 1)];
    
    if (_state == 0) {
        
        _phone4.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(3, 1)];
        _phone5.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(4, 1)];
        _phone6.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(5, 1)];
        _phone7.text = [dataDic[@"tel"] substringWithRange:NSMakeRange(6, 1)];
        _hideL.hidden = YES;
        _hideReportL.hidden = YES;
        _hideReportImg.hidden = YES;
    }else{
        
        _phone4.text = @"X";
        _phone5.text = @"X";
        _phone6.text = @"X";
        _phone7.text = @"X";
        _hideL.hidden = NO;
        _hideReportL.hidden = NO;
        _hideReportImg.hidden = NO;
    }
    [_phoneL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(15 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(_phoneL.mj_textWith + 5 *SIZE);
    }];
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(15 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}


- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.frame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CH_COLOR_white;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _backImg1 = [[UIImageView alloc] init];
    _backImg1.image = [UIImage imageNamed:@"a"];
    [_whiteView addSubview:_backImg1];
    
    _backImg2 = [[UIImageView alloc] init];
    _backImg2.image = [UIImage imageNamed:@"a_1"];
    [_whiteView addSubview:_backImg2];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.numberOfLines = 0;
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_titleL];
    
    _lineView = [[DashesLineView alloc] initWithFrame:CGRectMake(23 *SIZE, 61 *SIZE, 203 *SIZE, 2 *SIZE)];
    [_whiteView addSubview:_lineView];
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = YJTitleLabColor;
    _projectL.font = [UIFont systemFontOfSize:13 *SIZE];
    _projectL.numberOfLines = 0;
    [_whiteView addSubview:_projectL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.numberOfLines = 0;
    [_whiteView addSubview:_nameL];
    
    _sexImg = [[UIImageView alloc] init];
    [_whiteView addSubview:_sexImg];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJTitleLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _phoneL.numberOfLines = 0;
//    _phoneL.adjustsFontSizeToFitWidth = YES;
    [_whiteView addSubview:_phoneL];
    
    _phone1 = [[UILabel alloc] init];
    _phone1.textColor = YJContentLabColor;
    _phone1.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone1.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone1.layer.borderWidth = SIZE;
    _phone1.layer.cornerRadius = 2 *SIZE;
    _phone1.clipsToBounds = YES;
    _phone1.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone1];
    
    _phone2 = [[UILabel alloc] init];
    _phone2.textColor = YJContentLabColor;
    _phone2.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone2.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone2.layer.borderWidth = SIZE;
    _phone2.layer.cornerRadius = 2 *SIZE;
    _phone2.clipsToBounds = YES;
    _phone2.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone2];
    
    _phone3 = [[UILabel alloc] init];
    _phone3.textColor = YJContentLabColor;
    _phone3.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone3.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone3.layer.borderWidth = SIZE;
    _phone3.layer.cornerRadius = 2 *SIZE;
    _phone3.clipsToBounds = YES;
    _phone3.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone3];
    
    _phone4 = [[UILabel alloc] init];
    _phone4.textColor = YJContentLabColor;
    _phone4.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone4.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone4.layer.borderWidth = SIZE;
    _phone4.layer.cornerRadius = 2 *SIZE;
    _phone4.clipsToBounds = YES;
    _phone4.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone4];
    
    _phone5 = [[UILabel alloc] init];
    _phone5.textColor = YJContentLabColor;
    _phone5.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone5.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone5.layer.borderWidth = SIZE;
    _phone5.layer.cornerRadius = 2 *SIZE;
    _phone5.clipsToBounds = YES;
    _phone5.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone5];
    
    _phone6 = [[UILabel alloc] init];
    _phone6.textColor = YJContentLabColor;
    _phone6.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone6.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone6.layer.borderWidth = SIZE;
    _phone6.layer.cornerRadius = 2 *SIZE;
    _phone6.clipsToBounds = YES;
    _phone6.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone6];
    
    _phone7 = [[UILabel alloc] init];
    _phone7.textColor = YJContentLabColor;
    _phone7.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone7.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone7.layer.borderWidth = SIZE;
    _phone7.layer.cornerRadius = 2 *SIZE;
    _phone7.clipsToBounds = YES;
    _phone7.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone7];
    
    _phone8 = [[UILabel alloc] init];
    _phone8.textColor = YJContentLabColor;
    _phone8.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone8.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone8.layer.borderWidth = SIZE;
    _phone8.layer.cornerRadius = 2 *SIZE;
    _phone8.clipsToBounds = YES;
    _phone8.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone8];
    
    _phone9 = [[UILabel alloc] init];
    _phone9.textColor = YJContentLabColor;
    _phone9.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone9.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone9.layer.borderWidth = SIZE;
    _phone9.layer.cornerRadius = 2 *SIZE;
    _phone9.clipsToBounds = YES;
    _phone9.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone9];
    
    _phone10 = [[UILabel alloc] init];
    _phone10.textColor = YJContentLabColor;
    _phone10.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone10.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone10.layer.borderWidth = SIZE;
    _phone10.layer.cornerRadius = 2 *SIZE;
    _phone10.clipsToBounds = YES;
    _phone10.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone10];
    
    _phone11 = [[UILabel alloc] init];
    _phone11.textColor = YJContentLabColor;
    _phone11.font = [UIFont systemFontOfSize:9 *SIZE];
    _phone11.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _phone11.layer.borderWidth = SIZE;
    _phone11.layer.cornerRadius = 2 *SIZE;
    _phone11.clipsToBounds = YES;
    _phone11.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_phone11];
    
    _hideL = [[UILabel alloc] init];
    _hideL.textColor = YJ170Color;
    _hideL.font = [UIFont systemFontOfSize:10 *SIZE];
    _hideL.text = @"中间四位已隐藏";
    [_whiteView addSubview:_hideL];
    
    
    _hideReportL = [[UILabel alloc] init];
    _hideReportL.textColor = COLOR(255, 165, 29, 1);
    _hideReportL.font = [UIFont systemFontOfSize:10 *SIZE];
    _hideReportL.text = @"隐号报备";
    [_whiteView addSubview:_hideReportL];
    
    _hideReportImg = [[UIImageView alloc] init];
    _hideReportImg.image = [UIImage imageNamed:@"eye"];
    [_whiteView addSubview:_hideReportImg];
    
    _cancenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancenBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_cancenBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancenBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [_cancenBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [_cancenBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
    [_whiteView addSubview:_cancenBtn];
    

    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(55 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
        make.center.equalTo(self);
    }];
    
    [_backImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(50 *SIZE);
        make.top.equalTo(_whiteView).offset(21 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.width.mas_equalTo(17 *SIZE);
    }];
    
    [_backImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(187 *SIZE);
        make.top.equalTo(_whiteView).offset(21 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.width.mas_equalTo(17 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(10 *SIZE);
        make.top.equalTo(_whiteView).offset(25 *SIZE);
        make.right.equalTo(_whiteView).offset(-10 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(15 *SIZE);
        make.top.equalTo(_whiteView).offset(81 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(15 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(18 *SIZE);
        make.width.height.mas_equalTo(14 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(15 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(19 *SIZE);
//        make.width.mas_equalTo(100 *SIZE);
        make.width.mas_equalTo(_phoneL.mj_textWith + 5 *SIZE);
    }];
    
    [_phone1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phoneL.mas_right).offset(3 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone1.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone2.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone3.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone4.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone5.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone6.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone8 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone7.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone9 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone8.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone10 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone9.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_phone11 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_phone10.mas_right).offset(SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(13 *SIZE);
        make.height.mas_equalTo(16 *SIZE);
    }];
    
    [_hideL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(16 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_hideReportImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(173 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(6 *SIZE);
    }];
    
    [_hideReportL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(191 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
        make.height.mas_equalTo(9 *SIZE);
    }];
    
    [_cancenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_hideL.mas_bottom).offset(38 *SIZE);
        make.bottom.equalTo(_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
}

@end
