//
//  MessageTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MessageTableCell.h"

@implementation MessageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 17 *SIZE, 50 *SIZE, 50 *SIZE)];
    _headImg.layer.cornerRadius = 3 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(77 *SIZE, 25 *SIZE, 200 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15];

    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(77 *SIZE, 44 *SIZE, 200 *SIZE, 11 *SIZE)];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
   
    [self.contentView addSubview:_contentL];
    
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 36 *SIZE, 7 *SIZE, 12 *SIZE)];
    rightView.image = [UIImage imageNamed:@"rightarrow"];
    [self.contentView addSubview:rightView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 82 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

-(void)SetCellContentbyimg:(NSString *)imgname title:(NSString *)title content:(NSString *)content
{
    _headImg.image = [UIImage imageNamed:imgname];
    _titleL.text = title;
    _contentL.text = content;
}


@end
