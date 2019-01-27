//
//  LookMaintainDetailFollowCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailFollowCell.h"

@implementation LookMaintainDetailFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _timeL.text = [NSString stringWithFormat:@"跟进时间：%@",dataDic[@"follow_time"]];
    _wayL.text = [NSString stringWithFormat:@"跟进方式：%@",dataDic[@"follow_type"]];
    _contentL.text = [NSString stringWithFormat:@"%@",dataDic[@"follow_comment"]];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"带看套数：%@",dataDic[@"take_num"]]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(5, attr.length - 5)];
    _numL.attributedText = attr;
    _nextTimeL.text = [NSString stringWithFormat:@"下次回访时间：%@",dataDic[@"next_follow_time"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 2 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:15 *SIZE];
//    _timeL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_timeL];
    
    _wayL = [[UILabel alloc] init];
    _wayL.textColor = YJ170Color;
    _wayL.textAlignment = NSTextAlignmentRight;
    _wayL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_whiteView addSubview:_wayL];
    
    _placeL = [[UILabel alloc] init];
    _placeL.textColor = YJContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"跟进内容：";
    [_whiteView addSubview:_placeL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJ86Color;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.numberOfLines = 0;
    [_whiteView addSubview:_contentL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJBlueBtnColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_whiteView addSubview:_numL];
    
    _nextTimeL = [[UILabel alloc] init];
    _nextTimeL.textColor = YJBlueBtnColor;
    _nextTimeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_whiteView addSubview:_nextTimeL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteView).offset(19 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
//        make.right.equalTo(_whiteView).offset(-12 *SIZE);
        make.width.mas_equalTo(195 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteView).offset(22 *SIZE);
        make.left.equalTo(_whiteView).offset(195 *SIZE);
        make.right.equalTo(_whiteView).offset(-14 *SIZE);
    }];
    
    [_placeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_timeL.mas_bottom).offset(12 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.right.equalTo(_whiteView).offset(-26 *SIZE);
    }];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_placeL.mas_bottom).offset(13 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.right.equalTo(_whiteView).offset(-13 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentL.mas_bottom).offset(12 *SIZE);
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-14 *SIZE);
    }];
    
    [_nextTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
        make.right.equalTo(_whiteView).offset(-13 *SIZE);
    }];
}

@end
