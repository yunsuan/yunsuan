//
//  WorkMessageCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WorkMessageCell.h"

@implementation WorkMessageCell

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
    
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 340*SIZE, 117*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backview];
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(10.7*SIZE, 18*SIZE, 300*SIZE, 14*SIZE)];
    _titlelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _titlelab.textColor = YJTitleLabColor;
    [backview addSubview:_titlelab];
    _numlab = [[UILabel alloc]initWithFrame:CGRectMake(11*SIZE, 45*SIZE, 300*SIZE, 14*SIZE)];
    _numlab.font = [UIFont systemFontOfSize:12*SIZE];
    _numlab.textColor = YJContentLabColor;
    [backview addSubview:_numlab];
    _namelab = [[UILabel alloc]initWithFrame:CGRectMake(11*SIZE, 69*SIZE, 300*SIZE, 14*SIZE)];
    _namelab.font = [UIFont systemFontOfSize:12*SIZE];
    _namelab.textColor = YJContentLabColor;
    [backview addSubview:_namelab];
    _projectlab = [[UILabel alloc]initWithFrame:CGRectMake(11*SIZE, 92.7*SIZE, 300*SIZE, 14*SIZE)];
    _projectlab.font = [UIFont systemFontOfSize:12*SIZE];
    _projectlab.textColor = YJContentLabColor;
    [backview addSubview:_projectlab];
    _timelab = [[UILabel alloc]initWithFrame:CGRectMake(100*SIZE, 92.7*SIZE, 234*SIZE, 14*SIZE)];
    _timelab.font = [UIFont systemFontOfSize:12*SIZE];
    _timelab.textColor = YJContentLabColor;
    _timelab.textAlignment = NSTextAlignmentRight;
    [backview addSubview:_timelab];
    _messageimg = [[UIImageView alloc]initWithFrame:CGRectMake(317.3*SIZE, 16.7*SIZE, 16.3*SIZE, 16.3*SIZE)];
    [backview addSubview:_messageimg];
}

-(void)SetCellbytitle:(NSString *)title
                  num:(NSString *)num
                 name:(NSString *)name
              project:(NSString *)project
                 time:(NSString *)time
           messageimg:(BOOL)isopen
{
    _titlelab.text = title;
    _numlab.text = num;
    _namelab.text =name;
    _projectlab.text = project;
    _timelab.text = time;
    if (isopen == 0) {
        _messageimg.image = [UIImage imageNamed:@"news_unread"];
    }else{
        _messageimg.image = [UIImage imageNamed:@"news_read"];
    }
    
}



@end
