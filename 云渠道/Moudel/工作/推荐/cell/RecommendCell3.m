//
//  RecommendCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell3.h"

@implementation RecommendCell3

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
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"到访时间：%@",dataDic[@"visit_time"]];
    _statusL.text = dataDic[@"current_state"];
    _statusL.textColor = YJBlueBtnColor;
}

- (void)setInValidDic:(NSMutableDictionary *)inValidDic{
    
    _nameL.text = inValidDic[@"name"];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",inValidDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",inValidDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",inValidDic[@"state_change_time"]];
    _statusL.text = inValidDic[@"current_state"];
    
    _statusL.textColor = YJ170Color;
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 17 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 42 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 61 *SIZE, 200 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
//    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 82 *SIZE, 200 *SIZE, 10 *SIZE)];
//    _confirmL.textColor = YJ86Color;
//    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
//    [self.contentView addSubview:_confirmL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 82 *SIZE, 300 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJ170Color;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.frame = CGRectMake(335 *SIZE, 16 *SIZE, 19 *SIZE, 19 *SIZE);
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(300 *SIZE, 45 *SIZE, 50 *SIZE, 10 *SIZE)];
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 106 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
