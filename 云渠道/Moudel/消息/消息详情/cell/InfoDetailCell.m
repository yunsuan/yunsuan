//
//  InfoDetailCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InfoDetailCell.h"

@implementation InfoDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    _contentlab = [[UILabel alloc]init];
    _contentlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _contentlab.numberOfLines = 0;
    _contentlab.lineBreakMode = NSLineBreakByCharWrapping;
//    [_contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _contentlab.textColor = YJContentLabColor;
    [self.contentView addSubview:_contentlab];

    [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28.3*SIZE);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(300*SIZE);
        make.bottom.equalTo(self.contentView).offset(-15*SIZE);
    }];
}

-(void)SetCellContentbystring:(NSString *)str
{
    _contentlab.text = str;
}

-(CGFloat)calculateTextHeight
{
    return self.contentlab.frame.size.height +15*SIZE;
}

@end
