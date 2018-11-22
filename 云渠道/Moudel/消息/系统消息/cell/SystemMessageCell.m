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
    
    _whiteView = [[UIView alloc]init];//WithFrame:CGRectMake(10*SIZE, 10*SIZE, 340*SIZE, 100*SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_whiteView];
    
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(11.3*SIZE, 14.7*SIZE, 300*SIZE, 14*SIZE)];
    _titlelab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _titlelab.textColor = YJTitleLabColor;
    [_whiteView addSubview:_titlelab];
    
    _contentlab = [[UILabel alloc]init];//WithFrame:CGRectMake(11*SIZE, 41.7*SIZE, 300*SIZE, 14*SIZE)];
    _contentlab.font = [UIFont systemFontOfSize:12*SIZE];
    _contentlab.textColor = YJContentLabColor;
    _contentlab.numberOfLines = 0;
    [_whiteView addSubview:_contentlab];
    
    _timelab = [[UILabel alloc]init];//WithFrame:CGRectMake(11*SIZE, 69.7*SIZE, 300*SIZE, 14*SIZE)];
    _timelab.font = [UIFont systemFontOfSize:12*SIZE];
    _timelab.textColor = YJContentLabColor;
    [_whiteView addSubview:_timelab];
    
    _messageimg = [[UIImageView alloc]init];//WithFrame:CGRectMake(317.3*SIZE, 16.7*SIZE, 16.3*SIZE, 16.3*SIZE)];
    [_whiteView addSubview:_messageimg];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(11 *SIZE);
        make.top.equalTo(_whiteView).offset(42 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
    }];
    
    [_timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(11 *SIZE);
        make.top.equalTo(_contentlab.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-15 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-15 *SIZE);
    }];
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
