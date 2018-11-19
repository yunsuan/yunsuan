//
//  PersonalTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PersonalTableCell.h"

@implementation PersonalTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionSwitch:(UISwitch *)onOff{
    
    if (self.personalSwitchBlock) {
        
        self.personalSwitchBlock();
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 70 *SIZE, 13 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(290 *SIZE, 6 *SIZE, 40 *SIZE, 40 *SIZE)];
    _headImg.layer.cornerRadius = 20 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    _headImg.hidden = YES;
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(85 *SIZE, 19 *SIZE, 255 *SIZE, 13 *SIZE)];
    _contentL.textColor = YJTitleLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentL];
    
    _OnOff = [[UISwitch alloc] initWithFrame:CGRectMake(300 *SIZE, 10 *SIZE, 80 *SIZE, 20 *SIZE)];
    _OnOff.hidden = YES;
    [_OnOff addTarget:self action:@selector(ActionSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_OnOff];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 19 *SIZE, 12 *SIZE, 12 *SIZE)];
    _rightView.image = [UIImage imageNamed:@"rightarrow"];
    [self.contentView addSubview:_rightView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
