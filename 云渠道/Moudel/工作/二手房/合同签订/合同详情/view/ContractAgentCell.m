//
//  ContractAgentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractAgentCell.h"

@implementation ContractAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            _headerImg.image = [UIImage imageNamed:@"def_head_1"];
        }
    }];
    
    _nameL.text = dataDic[@"agent_name"];
    _phoneL.text = dataDic[@"agent_tel"];
    _timeL.text = dataDic[@"handle_time"];
    _typeL.text = dataDic[@"deal_type"];
    if ([dataDic[@"deal_type"] isEqualToString:@"签约人"]) {
        
        _typeL.backgroundColor = COLOR(213, 242, 255, 1);
        _typeL.textColor = COLOR(64, 169, 255, 1);
    }else if ([dataDic[@"deal_type"] isEqualToString:@"审核人"]){
        
        _typeL.backgroundColor = COLOR(234, 242, 237, 1);
        _typeL.textColor = COLOR(108, 187, 166, 1);
    }else if ([dataDic[@"deal_type"] isEqualToString:@"办贷人"]){
        
        _typeL.backgroundColor = COLOR(208, 243, 245, 1);
        _typeL.textColor = COLOR(36, 185, 195, 1);
    }else{
        
        _typeL.backgroundColor = COLOR(255, 237, 211, 1);
        _typeL.textColor = COLOR(255, 188, 87, 1);
    }
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(72 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _headerImg = [[UIImageView alloc] init];
    _headerImg.backgroundColor = YJBackColor;
    _headerImg.layer.cornerRadius = 25 *SIZE;
    _headerImg.clipsToBounds = YES;
    [self.contentView addSubview:_headerImg];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ170Color;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                _nameL.textColor = YJTitleLabColor;
                _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _typeL = label;
                _typeL.font = [UIFont systemFontOfSize:10 *SIZE];
                _typeL.textAlignment = NSTextAlignmentCenter;
                [self.contentView addSubview:_typeL];
                break;
            }
            case 2:
            {
                _timeL = label;
                _timeL.textColor = YJ170Color;
                _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
                [self.contentView addSubview:_timeL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                _phoneL.textColor = YJ86Color;
                _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
                _phoneL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_phoneL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.height.mas_equalTo(50 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(72 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(4 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(72 *SIZE);
        make.top.equalTo(self.contentView).offset(39 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_headerImg.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
