//
//  BuildinginfoCell.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildinginfoCell.h"

@implementation BuildinginfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titlelab = [[UILabel alloc]init];//WithFrame:CGRectMake(9.7*SIZE, 14*SIZE  , 80*SIZE, 14*SIZE)];
        _titlelab.textColor = YJContentLabColor;
        _titlelab.font = [UIFont systemFontOfSize:13 *SIZE];
        [self.contentView addSubview:_titlelab];
        
        [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10 *SIZE);
            make.top.equalTo(self.contentView).offset(14 *SIZE);
            make.width.mas_equalTo(80 *SIZE);
            make.bottom.equalTo(self.contentView).offset(-9 *SIZE);
        }];
        
        _contentlab = [[UILabel alloc]init];
        _contentlab.font = [UIFont systemFontOfSize:13*SIZE];
        _contentlab.numberOfLines = 0;
        //        _contentlab.lineBreakMode = NSLineBreakByCharWrapping;
        //    [_contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _contentlab.textColor = YJTitleLabColor;
        [self.contentView addSubview:_contentlab];
        //    __weak typeof(self)weakSelf=self;
        [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(92 *SIZE);
            make.top.equalTo(self.contentView).offset(14 *SIZE);
            make.width.mas_equalTo(245 *SIZE);
            make.bottom.equalTo(self.contentView).offset(- 9*SIZE);
        }];
        
    }
    
    return self;
}

-(void)settitle:(NSString *)title content:(NSString *)content
{
    _titlelab.text = title;
    _contentlab.text = content;
    if (content.length) {
        
        [_contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(92 *SIZE);
            make.top.equalTo(self.contentView).offset(14 *SIZE);
            make.width.mas_equalTo(245 *SIZE);
            make.bottom.equalTo(self.contentView).offset(- 9*SIZE);
        }];
    }else{
        
        [_titlelab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10 *SIZE);
            make.top.equalTo(self.contentView).offset(14 *SIZE);
            make.width.mas_equalTo(80 *SIZE);
            make.bottom.equalTo(self.contentView).offset(-9 *SIZE);
        }];
    }
}

@end
