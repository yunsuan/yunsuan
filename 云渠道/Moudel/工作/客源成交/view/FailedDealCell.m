//
//  FailedDealCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FailedDealCell.h"

@implementation FailedDealCell

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
    _recommendTimeL.text = [NSString stringWithFormat:@"推荐时间：%@",dataDic[@"create_time"]];
    _invalidTimeL.text = [NSString stringWithFormat:@"无效时间：%@",dataDic[@"state_change_time"]];
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.failedDealCellPhoneBtnBlock) {
        
        self.failedDealCellPhoneBtnBlock(self.tag);
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
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 65 *SIZE, 300 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _recommendTimeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 84 *SIZE, 300 *SIZE, 11 *SIZE)];
    _recommendTimeL.textColor = YJ86Color;
    _recommendTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendTimeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 16 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _invalidTimeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 105 *SIZE, 300 *SIZE, 11 *SIZE)];
    _invalidTimeL.textColor = YJBlueBtnColor;
    _invalidTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_invalidTimeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 132 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
