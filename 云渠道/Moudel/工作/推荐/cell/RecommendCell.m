//
//  RecommendCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.confirmBtnBlock) {
        
        self.confirmBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
//    _confirmL.text = [NSString stringWithFormat:@"到访确认人：%@",dataDic[@"butter_name"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"失效时间：%@",dataDic[@"timsLimit"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(0, 5)];
    _timeL.attributedText = attr;

    _addressL.text = dataDic[@"absolute_address"];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 21 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 44 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 65 *SIZE, 200 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 86 *SIZE, 300 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJBlueBtnColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
//    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 107 *SIZE, 170 *SIZE, 10 *SIZE)];
//    _confirmL.textColor = YJ170Color;
//    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
//    [self.contentView addSubview:_confirmL];

    _statusImg = [[UIImageView alloc] init];
    _statusImg.layer.cornerRadius = 10 *SIZE;
    _statusImg.clipsToBounds = YES;
    [self.contentView addSubview:_statusImg];
    
//    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 107 *SIZE, 170 *SIZE, 10 *SIZE)];
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 107 *SIZE, 300 *SIZE, 10 *SIZE)];
    _addressL.textColor = YJ170Color;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _addressL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_addressL];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 132 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(273 *SIZE, 61 *SIZE, 77 *SIZE, 30 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:COLOR(255, 165, 29, 1)];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        _confirmBtn.hidden = YES;
    }else{
        
        _confirmBtn.hidden = NO;
    }
}




@end
