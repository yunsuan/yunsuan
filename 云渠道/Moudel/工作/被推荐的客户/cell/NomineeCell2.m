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

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"项目名称：%@",dataDic[@"project_name"]];
    _contactL.text = [NSString stringWithFormat:@"置业顾问：%@",dataDic[@"property_advicer_wish"]];
    _reportTimeL.text = [NSString stringWithFormat:@"报备日期：%@",dataDic[@"allot_time"]];
    _statusL.text = dataDic[@"current_state"];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 41 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 62 *SIZE, 200 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _contactL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 82 *SIZE, 170 *SIZE, 11 *SIZE)];
    _contactL.textColor = YJ86Color;
    _contactL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contactL];
    
    _reportTimeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 103 *SIZE, 200 *SIZE, 10 *SIZE)];
    _reportTimeL.textColor = YJ170Color;
    _reportTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_reportTimeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 13 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(230 *SIZE, 36 *SIZE, 119 *SIZE, 10 *SIZE)];
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 127 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
