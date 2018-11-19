//
//  TitleContentBaseCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TitleContentBaseCell.h"

@implementation TitleContentBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title content:(NSString *)content{
    
    _titleL.text = title;
    _contentL.text = content;
    if (title.length > content.length) {
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(0);
            make.top.equalTo(_titleL.mas_bottom).offset(15 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.bottom.equalTo(self.contentView).offset(0);
        }];
    }else{
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(0);
            make.top.equalTo(_contentL.mas_bottom).offset(15 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.bottom.equalTo(self.contentView).offset(0);
        }];
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _contentL.numberOfLines = 0;
    _contentL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_contentL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10*SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(95 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(110*SIZE);
        make.top.equalTo(self.contentView).offset(14*SIZE);
        make.width.mas_equalTo(230*SIZE);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_titleL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
