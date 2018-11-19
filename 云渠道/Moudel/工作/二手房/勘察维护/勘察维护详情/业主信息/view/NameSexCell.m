//
//  NameSexCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/3.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NameSexCell.h"

@implementation NameSexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _contentL.numberOfLines = 0;
    _contentL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_contentL];
    
    _genderImg = [[UIImageView alloc] init];
    _genderImg.image = [UIImage imageNamed:@"man"];
    [self.contentView addSubview:_genderImg];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27*SIZE);
        make.top.equalTo(self.contentView).offset(9*SIZE);
        make.right.equalTo(self.contentView).offset(-27*SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentL.mas_right).offset(0*SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_contentL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
