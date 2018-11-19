//
//  SelectStoreCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectStoreCell.h"

@implementation SelectStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    NSString *imgname = dataDic[@"log"];
    if (imgname.length>0) {
        [_storeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"log"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _storeImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }
    else{
        _storeImg.image = [UIImage imageNamed:@"default_3"];

    }
   
    
    _nameL.text = dataDic[@"store_name"];
    _codeL.text = [NSString stringWithFormat:@"营业执照：%@",dataDic[@"business_license"]];
    _addressL.text = dataDic[@"address"];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"contact_tel"]];
    _contactL.text = [NSString stringWithFormat:@"负责人：%@",dataDic[@"contact"]];
}

- (void)initUI{
    
    _selectImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_selectImg];
    
    _storeImg = [[UIImageView alloc] init];
    _storeImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_storeImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = YJTitleLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = YJ86Color;
    _contactL.textAlignment = NSTextAlignmentRight;
    _contactL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_contactL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(43 *SIZE);
        make.width.mas_equalTo(15 *SIZE);
        make.height.mas_equalTo(15 *SIZE);
    }];
    
    [_storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(33 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(67 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(118 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(118 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(118 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(118 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(260 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
