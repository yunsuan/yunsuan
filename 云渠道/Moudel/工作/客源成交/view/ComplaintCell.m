//
//  ComplaintCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ComplaintCell.h"

@implementation ComplaintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.complaintCellCellPhoneBtnBlock) {
        
        self.complaintCellCellPhoneBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"project_client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _recomTimeL.text = [NSString stringWithFormat:@"推荐日期：%@",dataDic[@"recommend_time"]];
    _complainL.text = [NSString stringWithFormat:@"申诉日期：%@",dataDic[@"state_change_time"]];
    _statusL.text = dataDic[@"state"];
    if ([_statusL.text isEqualToString:@"处理完成"]) {
        
        _statusL.textColor = YJBlueBtnColor;
    }else{
        
        _statusL.textColor = COLOR(255, 88, 88, 1);
    }
}

- (void)initUI{
    
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 42 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 63 *SIZE, 200 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 16 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _recomTimeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 88 *SIZE, 170 *SIZE, 10 *SIZE)];
    _recomTimeL.textColor = YJContentLabColor;
    _recomTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
    //    _recomTimeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_recomTimeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(290 *SIZE, 43 *SIZE, 59 *SIZE, 10 *SIZE)];
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _complainL = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 88 *SIZE, 170 *SIZE, 10 *SIZE)];
    _complainL.textColor = YJContentLabColor;
    _complainL.font = [UIFont systemFontOfSize:11 *SIZE];
    _complainL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_complainL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 113 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}


@end
