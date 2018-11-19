//
//  RoomDetailTableCell7.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell7.h"

@implementation RoomDetailTableCell7

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 19 *SIZE, 200 *SIZE, 14 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"佣金规则";
    [self.contentView addSubview:label];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 21 *SIZE, 167 *SIZE, 12 *SIZE)];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(28 *SIZE, 50 *SIZE + i * 69 *SIZE, 22 *SIZE, 22 *SIZE)];
        img.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(69 *SIZE, 54 *SIZE + i * 70 *SIZE, 280 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = @"到访确认保护期：60 分钟";
        if (i == 0) {
            
            _proTime = label;
            [self.contentView addSubview:_proTime];
        }else if (i == 1){
            
            _proTime1 = label;
            [self.contentView addSubview:_proTime1];
        }else{
            
            _proTime2 = label;
            [self.contentView addSubview:_proTime2];
        }
        
        if (i != 0) {
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(39 *SIZE, 50 *SIZE + i * 22 *SIZE + 48 *SIZE * (i - 1), SIZE, 48 *SIZE)];
            line.backgroundColor = COLOR(255, 188, 88, 1);
            [self.contentView addSubview:line];
        }
    }
    
    [_proTime2 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(69 *SIZE);
        make.top.equalTo(self.contentView).offset(194 *SIZE);
        make.width.equalTo(@(280 *SIZE));
        make.height.equalTo(@(13 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-37 *SIZE);
    }];
}

@end
