//
//  MaintainDetailFollowCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MaintainDetailFollowCell.h"

@implementation MaintainDetailFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 2 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _wayL = [[UILabel alloc] init];
    _wayL.textColor = YJBlueBtnColor;
    _wayL.font = [UIFont systemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_wayL];
    
//    _intentionL = [[UILabel alloc] init];
//    _intentionL.textColor = YJBlueBtnColor;
//    _intentionL.font = [UIFont systemFontOfSize:13 *SIZE];
//    [_whiteView addSubview:_intentionL];
    
//    _urgentL = [[UILabel alloc] init];
//    _urgentL.textColor = YJ86Color;
//    _urgentL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _urgentL.text = @"跟进内容：";
//    [_whiteView addSubview:_urgentL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = COLOR(86, 86, 86, 1);
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.numberOfLines = 0;
    [_whiteView addSubview:_contentL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_timeL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteView).offset(19 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.height.equalTo(@(14 *SIZE));
        make.right.equalTo(_whiteView).offset(-12 *SIZE);
    }];
    
//    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(_wayL.mas_bottom).offset(10 *SIZE);
//        make.left.equalTo(_whiteView).offset(12 *SIZE);
//        make.height.equalTo(@(13 *SIZE));
//        make.width.equalTo(@(120 *SIZE));
//    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_wayL.mas_bottom).offset(10 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.right.equalTo(_whiteView).offset(-26 *SIZE);
        make.bottom.equalTo(_timeL.mas_top).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentL.mas_bottom).offset(10 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.right.equalTo(_whiteView).offset(-12 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-20 *SIZE);
    }];
}
@end
