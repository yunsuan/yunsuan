//
//  RoomDetailTableCell1.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell1.h"

@implementation RoomDetailTableCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 65 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"项目动态";
    [self.contentView addSubview:label];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 3 *SIZE, 15 *SIZE, 120 *SIZE, 15 *SIZE)];
    _numL.textColor = COLOR(27, 152, 255, 1);
    _numL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_numL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 13 *SIZE, 65 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *sIZE];
    //    [_moreBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _contentL = [[UILabel alloc] init];
//    _contentL.numberOfLines = 2;
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.numberOfLines = 2;
    [self.contentView addSubview:self.contentL];
    
    [self MasonyUI];
}

- (void)MasonyUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(56 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.bottom.equalTo(_timeL.mas_top).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.bottom.equalTo(_contentL.mas_top).offset(-15 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.height.equalTo(@(32 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
