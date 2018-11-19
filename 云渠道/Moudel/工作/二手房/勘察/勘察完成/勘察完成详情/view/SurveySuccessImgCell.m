//
//  SurveySuccessImgCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveySuccessImgCell.h"

@implementation SurveySuccessImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10 *SIZE, 12 *SIZE, 340 *SIZE, 167 *SIZE)];
    _scrollView.backgroundColor = YJRedColor;
    [self.contentView addSubview:_scrollView];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJContentLabColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numL];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(193 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-13 *SIZE);
    }];
}

@end
