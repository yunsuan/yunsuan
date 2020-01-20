//
//  RoomSurveySuccessCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomSurveySuccessCell.h"

@implementation RoomSurveySuccessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneTap{
    
    if (self.roomSurveSuccessPhoneBlock) {
        
        self.roomSurveSuccessPhoneBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
//    _statusL.hidden = YES;
    if (dataDic[@"name"]) {
        
        _nameL.text = dataDic[@"name"];
    }else{
        
        _nameL.text = @"";
    }
    
    if ([dataDic[@"is_from_home"] integerValue] == 1) {
        
        _sourceL.text = @"(置业家)";
    }else{
        
        _sourceL.text = @"";
    }
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    if ([dataDic[@"sex"] integerValue] == 2) {
        
        _sexImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _sexImg.image = [UIImage imageNamed:@"man"];
    }
    
    if (dataDic[@"house"]) {
        
        _roomL.text = dataDic[@"house"];
    }else{
        
        _roomL.text = @"";
    }
    
    if (dataDic[@"house_code"]) {
        
        _codeL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@"house_code"]];
    }else{
        
        _codeL.text = @"房源编号：";
    }
    
    _statusL.text = dataDic[@"current_state"];
//    if ([dataDic[@"is_other"] integerValue] == 1) {
//
//        _statusL.text = @"自己";
//        _statusL.backgroundColor = COLOR(255, 237, 211, 1);
//        _statusL.textColor = COLOR(255, 188, 87, 1);
//    }else{
//
//        _statusL.text = @"他人";
//        _statusL.backgroundColor = COLOR(228, 240, 255, 1);
//        _statusL.textColor = YJBlueBtnColor;
//    }
    
    
    if (dataDic[@"survey_time"]) {
        
        _timeL.text = [NSString stringWithFormat:@"抢单日期：%@",dataDic[@"survey_time"]];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"抢单日期："];
    }
    
    if (dataDic[@"finish_time"]) {
        
        _doneTimeL.text = [NSString stringWithFormat:@"完成日期：%@",dataDic[@"finish_time"]];
    }else{
        
        _doneTimeL.text = [NSString stringWithFormat:@"完成日期："];
    }
    
    if (dataDic[@"tel"]) {
        
        NSArray *arr = [dataDic[@"tel"] componentsSeparatedByString:@","];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:arr[0]];
        [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, attr.length)];
        [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attr.length)];
        _phoneL.attributedText = attr;
    }else{
        
        _phoneL.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    }
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _sexImg = [[UIImageView alloc] init];
    _sexImg.image = [UIImage imageNamed:@"man"];
    [self.contentView addSubview:_sexImg];
    
    _roomL = [[UILabel alloc] init];
    _roomL.textColor = YJ86Color;
    _roomL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_roomL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJ86Color;
    _sourceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_sourceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ170Color;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _doneTimeL = [[UILabel alloc] init];
    _doneTimeL.textColor = YJ170Color;
    _doneTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_doneTimeL];
    
    _selfL = [[UILabel alloc] init];
    _selfL.textColor = YJ170Color;
    _selfL.textAlignment = NSTextAlignmentRight;
    _selfL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_selfL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textAlignment = NSTextAlignmentCenter;
    _statusL.backgroundColor = COLOR(228, 240, 255, 1);
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_statusL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionPhoneTap)];
    [_phoneL addGestureRecognizer:tap];
    _phoneL.userInteractionEnabled = YES;
    [self.contentView addSubview:_phoneL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_lessThanOrEqualTo(180 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sourceL.mas_right).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(14 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
//    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(_codeL.mas_bottom).offset(11 *SIZE);
//        make.right.equalTo(self.contentView).offset(-100 *SIZE);
//    }];
    
    [_doneTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    
    [_selfL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(310 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(290 *SIZE);
        make.top.equalTo(_selfL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_doneTimeL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
