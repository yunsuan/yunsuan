//
//  CloudCodeCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/1.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CloudCodeCell.h"

@implementation CloudCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"logo"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            _headImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    _titleL.text = dataDic[@"nick_name"];
    _identifyL.text = [NSString stringWithFormat:@"认证：%@",dataDic[@"name"]];
    _briefL.text = [NSString stringWithFormat:@"简介：%@",dataDic[@"desc"]];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:14 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _identifyL = [[UILabel alloc] init];
    _identifyL.textColor = YJ86Color;
    _identifyL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_identifyL];
    
    _briefL = [[UILabel alloc] init];
    _briefL.textColor = YJ86Color;
    _briefL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_briefL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_identifyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_briefL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(_identifyL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_headImg.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(SIZE);
    }];
}

@end
