//
//  SurveyingDetailCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveyingDetailCell.h"

@implementation SurveyingDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }
    return self;
}

- (void)ActionChangeBtn:(UIButton *)btn{
    
    if (self.surveyingDetailChangeBlock) {
        
        self.surveyingDetailChangeBlock();
    }
}

- (void)initUI{
    
    self.contentL = [[UILabel alloc]init];
    self.contentL.font = [UIFont systemFontOfSize:13.3*SIZE];
    self.contentL.numberOfLines = 0;
    self.contentL.textColor = YJTitleLabColor;
    [self.contentView addSubview:self.contentL];
    
    _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_changeBtn addTarget:self action:@selector(ActionChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_changeBtn setTitle:@"变更预约时间" forState:UIControlStateNormal];
    [_changeBtn setBackgroundColor:COLOR(145, 205, 255, 1)];
    [self.contentView addSubview:_changeBtn];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:self.lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27*SIZE);
        make.top.equalTo(self.contentView).offset(9*SIZE);
        make.right.equalTo(self.contentView).offset(-27*SIZE);
        //        make.width.mas_equalTo(230*SIZE);
        //
    }];
    
    [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(280 *SIZE);
        make.top.equalTo(self.contentView).offset(4*SIZE);
        make.height.mas_equalTo(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
