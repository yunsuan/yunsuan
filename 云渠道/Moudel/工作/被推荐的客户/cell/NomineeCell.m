//
//  NomineeCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NomineeCell.h"

@implementation NomineeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMessBtn:(UIButton *)btn{
    
    if (self.messBtnBlock) {
        
        self.messBtnBlock(self.tag);
    }
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.phoneBtnBlock) {
        
        self.phoneBtnBlock(self.tag);
    }
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.confirmBtnBlock) {
        
        self.confirmBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"项目名称：%@",dataDic[@"project_name"]];
    _reportTimeL.text = [NSString stringWithFormat:@"报备日期：%@",dataDic[@"create_time"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间：%@",dataDic[@"timsLimit"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(0, 5)];
    _timeL.attributedText = attr;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 100 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 38 *SIZE, 200 *SIZE, 13 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 61 *SIZE, 200 *SIZE, 13 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_projectL];

    _reportTimeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 81 *SIZE, 200 *SIZE, 10 *SIZE)];
    _reportTimeL.textColor = YJ86Color;
    _reportTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_reportTimeL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 101 *SIZE, 200 *SIZE, 10 *SIZE)];
    _timeL.textColor = COLOR(255, 165, 29, 1);
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 19 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 127 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
