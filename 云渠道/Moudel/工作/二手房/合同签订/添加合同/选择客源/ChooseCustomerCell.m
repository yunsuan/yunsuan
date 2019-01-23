//
//  ChooseCustomerCell.m
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ChooseCustomerCell.h"

@implementation ChooseCustomerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
//    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
//
//    _codeL.text = [NSString stringWithFormat:@"客户编号：%@",dataDic[@""]];
//    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@""]];
//
//    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self.contentView).offset(14 *SIZE);
//        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
//    }];
}

- (void)initUI{
    
    _titlelab = [[UILabel alloc] init];
    _titlelab.textColor = YJTitleLabColor;
    _titlelab.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titlelab];
    
    _titlelab.text = @"张三";
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    _genderImg.image = [UIImage imageNamed:@"man"];
    
    _numlab = [[UILabel alloc] init];
    _numlab.textColor = YJ86Color;
    _numlab.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numlab];
    
    _numlab.text = @"客源编号：25621153223";
    
    _namelab = [[UILabel alloc] init];
    _namelab.textColor = YJ86Color;
    _namelab.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_namelab];
    
    _namelab.text = @"带看经纪人：张三   18756231245";
    
    _phonelab = [[UILabel alloc] init];
    _phonelab.textColor = YJ86Color;
    _phonelab.textAlignment = NSTextAlignmentRight;
    _phonelab.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_phonelab];
    _phonelab.text = @"18756231245";    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(_titlelab.mj_textWith + 5 *SIZE);
        make.height.mas_equalTo(16*SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titlelab.mas_right).offset(6 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_titlelab.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(14*SIZE);
    }];
    
    [_phonelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        
    }];
    
    [_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_numlab.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(14*SIZE);
//         make.bottom.equalTo(self.contentView).offset(20 *SIZE);
    }];
    

}

@end
