//
//  DealedCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "DealedCell.h"

@implementation DealedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _dealTimeL.text = [NSString stringWithFormat:@"成交时间：%@",dataDic[@"state_change_time"]];
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.dealedCellPhoneBtnBlock) {
        
        self.dealedCellPhoneBtnBlock(self.tag);
    }
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 16 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 45 *SIZE, 300 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 66 *SIZE, 300 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 16 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _dealTimeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 87 *SIZE, 300 *SIZE, 11 *SIZE)];
    _dealTimeL.textColor = YJBlueBtnColor;
    _dealTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_dealTimeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 112 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
