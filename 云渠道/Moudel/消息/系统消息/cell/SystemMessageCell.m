//
//  SystemMessageCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SystemMessageCell.h"

@implementation SystemMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = YJBackColor;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 340*SIZE, 100*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backview];
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(11.3*SIZE, 14.7*SIZE, 300*SIZE, 14*SIZE)];
    _titlelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _titlelab.textColor = YJTitleLabColor;
    [backview addSubview:_titlelab];
    _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(11*SIZE, 41.7*SIZE, 300*SIZE, 14*SIZE)];
    _contentlab.font = [UIFont systemFontOfSize:12*SIZE];
    _contentlab.textColor = YJContentLabColor;
    [backview addSubview:_contentlab];
    _timelab = [[UILabel alloc]initWithFrame:CGRectMake(11*SIZE, 69.7*SIZE, 300*SIZE, 14*SIZE)];
    _timelab.font = [UIFont systemFontOfSize:12*SIZE];
    _timelab.textColor = YJContentLabColor;
    [backview addSubview:_timelab];
    _messageimg = [[UIImageView alloc]initWithFrame:CGRectMake(317.3*SIZE, 16.7*SIZE, 16.3*SIZE, 16.3*SIZE)];
    [backview addSubview:_messageimg];
}

-(void)SetCellbytitle:(NSString *)title content:(NSString *)content time:(NSString *)time messageimg:(BOOL)isopen
{
    _titlelab.text = title;
    _contentlab.text =content;
    _timelab.text = time;
    if (isopen == 0) {
        _messageimg.image = [UIImage imageNamed:@"news_unread"];
    }else{
        _messageimg.image = [UIImage imageNamed:@"news_read"];
    }
    
}


@end
