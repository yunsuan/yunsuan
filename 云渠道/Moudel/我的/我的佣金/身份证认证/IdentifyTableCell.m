//
//  IdentifyTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/7.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "IdentifyTableCell.h"

@implementation IdentifyTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 150 *SIZE, 12 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(170 *SIZE, 19 *SIZE, 180 *SIZE, 12 *SIZE)];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentL];
}

@end
