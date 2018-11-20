//
//  UnpaidCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "UnpaidCell.h"

@implementation UnpaidCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionExpediteBtn:(UIButton *)btn{
    
    if (self.moneybtnBlook) {
        
        self.moneybtnBlook(btn.tag);
    }
}

- (void)initUI{
    
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 70 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(75 *SIZE, 16 *SIZE, 100 *SIZE, 10 *SIZE)];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _unitL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 38 *SIZE, 230 *SIZE, 14 *SIZE)];
    _unitL.textColor = YJTitleLabColor;
    _unitL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_unitL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 62 *SIZE, 200 *SIZE, 11 *SIZE)];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 85 *SIZE, 100 *SIZE, 11 *SIZE)];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 109 *SIZE, 200 *SIZE, 11 *SIZE)];
    _timeL.textColor = COLOR(86, 86, 86, 1);
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 38 *SIZE, 100 *SIZE, 14 *SIZE)];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceL];
    
    _expediteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _expediteBtn.frame = CGRectMake(273 *SIZE, 65 *SIZE, 77 *SIZE, 30 *SIZE);
    _expediteBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_expediteBtn addTarget:self action:@selector(ActionExpediteBtn:) forControlEvents:UIControlEventTouchUpInside];
    _expediteBtn.layer.cornerRadius = 2 *SIZE;
    _expediteBtn.clipsToBounds = YES;
    [_expediteBtn setTitle:@"催佣" forState:UIControlStateNormal];
    [_expediteBtn setBackgroundColor:YJBlueBtnColor];
    [_expediteBtn setTitleColor:CH_COLOR_white forState:UIControlStateNormal];
    [self.contentView addSubview:_expediteBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 133 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
