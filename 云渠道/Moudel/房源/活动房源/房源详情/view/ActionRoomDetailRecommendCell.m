//
//  ActionRoomDetailRecommendCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ActionRoomDetailRecommendCell.h"

@interface ActionRoomDetailRecommendCell ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation ActionRoomDetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textFieldDidChange{
    
    if (self.actionRoomDetailRecommendCellBlock) {
        
        self.actionRoomDetailRecommendCellBlock(_titleTF.textfield.text, _contentTV.text);
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (self.actionRoomDetailRecommendCellBlock) {
        
        self.actionRoomDetailRecommendCellBlock(_titleTF.textfield.text, _contentTV.text);
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.adjustsFontSizeToFitWidth = YES;
    _titleL.font = [UIFont systemFontOfSize:11 *SIZE];
    _titleL.text = @"推荐标题：";
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJTitleLabColor;
    _contentL.adjustsFontSizeToFitWidth = YES;
    _contentL.text = @"推荐理由：";
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_contentL];
    
    _titleTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _titleTF.textfield.delegate = self;
    [_titleTF.textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_titleTF];
    
    _contentTV = [[UITextView alloc] init];
    _contentTV.clipsToBounds = YES;
    _contentTV.layer.cornerRadius = 5*SIZE;
    _contentTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _contentTV.layer.borderWidth = 1*SIZE;
    _contentTV.delegate = self;
    [self.contentView addSubview:_contentTV];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleTF.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_titleTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(70 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
