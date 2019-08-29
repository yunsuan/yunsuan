//
//  NomineeCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeCell2.h"

@implementation NomineeCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.phoneBtnBlock) {
        
        self.phoneBtnBlock(self.tag);
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.nomineeCell2AddBlock) {
        
        self.nomineeCell2AddBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"项目名称：%@",dataDic[@"project_name"]];
    _contactL.text = [NSString stringWithFormat:@"置业顾问：%@",dataDic[@"property_advicer_wish"]];
    _reportTimeL.text = [NSString stringWithFormat:@"报备日期：%@",dataDic[@"allot_time"]];
    _statusL.text = dataDic[@"current_state"];
    
//    if ([dataDic[@"current_state"] isEqualToString:@"确认有效"] && [dataDic[@"is_sell_deal"] integerValue] == 1) {
//        
//        _addBtn.hidden = NO;
//    }else{
//        
//        _addBtn.hidden = YES;;
//    }
}

- (void)initUI{
    
    
    _nameL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 100 *SIZE, 14 *SIZE)];
    
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    
    _codeL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 41 *SIZE, 200 *SIZE, 11 *SIZE)];
    
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    
    _projectL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 62 *SIZE, 200 *SIZE, 11 *SIZE)];
    
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    
    _contactL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 82 *SIZE, 170 *SIZE, 11 *SIZE)];
    
    _contactL.textColor = YJ86Color;
    _contactL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contactL];
    
    
    _reportTimeL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 103 *SIZE, 200 *SIZE, 10 *SIZE)];
    
    _reportTimeL.textColor = YJ170Color;
    _reportTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_reportTimeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    
    _statusL = [[UILabel alloc] init];//WithFrame:CGRectMake(230 *SIZE, 36 *SIZE, 119 *SIZE, 10 *SIZE)];
    
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _addBtn.frame = CGRectMake(270 *SIZE, 65 *SIZE, 70 *SIZE, 23 *SIZE);
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"转成交" forState:UIControlStateNormal];
    _addBtn.hidden = YES;
    _addBtn.layer.cornerRadius = 2 *SIZE;
    _addBtn.clipsToBounds = YES;
    [_addBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    [self.contentView addSubview:_addBtn];
    
    _lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 106 *SIZE, SCREEN_Width, SIZE)];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_reportTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(335 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(19 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.bottom.equalTo(_lineView.mas_top).offset(-15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_reportTimeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
}

@end
