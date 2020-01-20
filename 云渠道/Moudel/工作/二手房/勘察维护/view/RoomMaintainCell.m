//
//  RoomMaintainCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomMaintainCell.h"

@implementation RoomMaintainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(RoomMaintainModel *)model{
    
    if (model.img_url.length > 0) {
        
        [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.img_url]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _roomImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }
    else{
        _roomImg.image = [UIImage imageNamed:@"default_3"];
    }
    
    _nameL.text = model.name;
    
    if ([model.is_from_home integerValue] == 1) {
        
        _sourceL.text = @"(置业家)";
    }else{
        
        _sourceL.text = @"";
    }
    
    if ([model.sex integerValue] == 1) {
        
        _sexImg.image = [UIImage imageNamed:@"man"];
    }else if ([model.sex integerValue] == 2){
        
        _sexImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _sexImg.image = [UIImage imageNamed:@""];
    }
    
    _roomL.text = [NSString stringWithFormat:@"%@-%@",model.project_name,model.house];
    _codeL.text = [NSString stringWithFormat:@"房源编号%@",model.house_code];
    _priceL.text = [NSString stringWithFormat:@"%@万/%@㎡%@",model.price,model.build_area,model.house_type_id];
    _typeL.text = [NSString stringWithFormat:@"类型：%@",model.property_type];
//    _areaL.text = [NSString stringWithFormat:@"面积：%@",model.build_area];
//    _houseTypeL.text = [NSString stringWithFormat:@"户型：%@",model.house_type_id];
    _statusL.text = [NSString stringWithFormat:@"当前状态：%@",model.state];
    _registerL.text = [NSString stringWithFormat:@"上架时间：%@",model.create_time];
    _numL.text = [NSString stringWithFormat:@"跟进次数：%@",model.follow_num];
    _timeL.text = [NSString stringWithFormat:@"上次跟进时间：%@",model.last_follow_time];
    
    if (model.tel.length) {
        
        NSArray *arr = [model.tel componentsSeparatedByString:@","];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:arr[0]];
        [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, 11)];
        [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 11)];
        _phoneL.attributedText = attr;
    }
    
//    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(9 *SIZE);
//        make.top.equalTo(self.contentView).offset(11 *SIZE);
//        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
//    }];
}


- (void)ActionPhoneTap{
    
    if (self.roomMaintainPhoneBlock) {
        
        self.roomMaintainPhoneBlock(self.tag);
    }
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFill;
    _roomImg.clipsToBounds = YES;
    [self.contentView addSubview:_roomImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _sexImg = [[UIImageView alloc] init];
    _sexImg.image = [UIImage imageNamed:@"man"];
    [self.contentView addSubview:_sexImg];
    
    _roomL = [[UILabel alloc] init];
    _roomL.textColor = YJ86Color;
    _roomL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_roomL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJ86Color;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = YJ86Color;
    _sourceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_sourceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJ170Color;
    _timeL.textAlignment = NSTextAlignmentRight;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJ86Color;
    _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJ86Color;
    _typeL.textAlignment = NSTextAlignmentRight;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
//    _areaL = [[UILabel alloc] init];
//    _areaL.textColor = YJ86Color;
//    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
//    [self.contentView addSubview:_areaL];
//
//    _houseTypeL = [[UILabel alloc] init];
//    _houseTypeL.textColor = YJ170Color;
//    _houseTypeL.textAlignment = NSTextAlignmentRight;
//    _houseTypeL.font = [UIFont systemFontOfSize:12 *SIZE];
//    [self.contentView addSubview:_houseTypeL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = YJ170Color;
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _registerL = [[UILabel alloc] init];
    _registerL.textColor = YJ170Color;
//    _registerL.textAlignment = NSTextAlignmentRight;
    _registerL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_registerL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJ170Color;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionPhoneTap)];
    [_phoneL addGestureRecognizer:tap];
    _phoneL.userInteractionEnabled = YES;
    [self.contentView addSubview:_phoneL];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
//        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sourceL.mas_right).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(14 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-65 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_registerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_registerL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_registerL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
