
//
//  MyTeamTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyTeamTableHeader.h"

@implementation MyTeamTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CH_COLOR_white;
    
    _recommendL = [[UILabel alloc] init];
    _recommendL.textColor = YJ86Color;
    _recommendL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendL];
    
    _allL = [[UILabel alloc] init];
    _allL.textColor = YJ86Color;
    _allL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_allL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_nameL];
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
    _levelL = [[UILabel alloc] init];
    _levelL.textColor = YJ86Color;
    _levelL.font = [UIFont systemFontOfSize:12 *SIZE];
    _levelL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_levelL];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 30 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_allL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(45 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(160 *SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.right.equalTo(self.contentView).offset(-97 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(4 *SIZE);
        make.top.equalTo(self.contentView).offset(22 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(210 *SIZE);
        make.top.equalTo(self.contentView).offset(44 *SIZE);
        make.right.equalTo(self.contentView).offset(-80 *SIZE);
    }];
    

    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(290 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.height.mas_equalTo(60 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-14 *SIZE);
    }];
}

@end
