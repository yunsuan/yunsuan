//
//  RecommendCell5.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendCell5.h"

@implementation RecommendCell5

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
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"project_client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _confirmL.text = [NSString stringWithFormat:@"置业顾问：%@",dataDic[@"project_client_id"]];
    _recomTimeL.text = [NSString stringWithFormat:@"推荐日期：%@",dataDic[@"recommend_time"]];
    _timeL.text = [NSString stringWithFormat:@"申诉日期：%@",dataDic[@"create_time"]];
    _statusL.text = dataDic[@"state"];
    if ([_statusL.text isEqualToString:@"处理完成"]) {
        
        _statusL.textColor = YJBlueBtnColor;
    }else{
        
        _statusL.textColor = COLOR(255, 88, 88, 1);
    }
}

- (void)initUI{
    
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 12 *SIZE, 100 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 40 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _projectL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 60 *SIZE, 200 *SIZE, 11 *SIZE)];
    _projectL.textColor = YJ86Color;
    _projectL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_projectL];
    
//    _confirmL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 81 *SIZE, 150 *SIZE, 10 *SIZE)];
//    _confirmL.textColor = YJ86Color;
//    _confirmL.font = [UIFont systemFontOfSize:11 *SIZE];
//    [self.contentView addSubview:_confirmL];
    
    _recomTimeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 81 *SIZE, 170 *SIZE, 10 *SIZE)];
    _recomTimeL.textColor = YJContentLabColor;
    _recomTimeL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _recomTimeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_recomTimeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(290 *SIZE, 40 *SIZE, 59 *SIZE, 10 *SIZE)];
    _statusL.textColor = YJBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 81 *SIZE, 170 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 103 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}


@end
