//
//  MineCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(15*SIZE,13*SIZE, 19*SIZE, 19*SIZE)];
        [self.contentView addSubview:_icon];
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(43*SIZE, 15*SIZE, 200*SIZE, 15*SIZE)];
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont systemFontOfSize:13*SIZE];
        [self.contentView addSubview:_titlelab];
        _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(210*SIZE, 16*SIZE, 116*SIZE, 13*SIZE)];
        _contentlab.textAlignment = NSTextAlignmentRight;
        _contentlab.textColor = YJContentLabColor;
        _contentlab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_contentlab];
        UIImageView *tagview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightarrow"]];
        tagview.frame = CGRectMake(343*SIZE, (CGFloat) (15.7*SIZE),(CGFloat) 6.7*SIZE, (CGFloat)12.3*SIZE);
        [self.contentView addSubview:tagview];
        UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 44*SIZE, 360*SIZE, 1*SIZE)];
        lane.backgroundColor = YJBackColor;
        [self.contentView addSubview:lane];

    }
    return self;
}

-(void)SetTitle:(NSString *)title icon:(NSString *)iconname contentlab:(NSString *)content
{
    _titlelab.text = title;
    _icon.image = [UIImage imageNamed:iconname];
    _contentlab.text = content;
}
@end
