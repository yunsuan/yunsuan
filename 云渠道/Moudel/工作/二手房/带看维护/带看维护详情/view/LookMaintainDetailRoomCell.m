//
//  LookMaintainDetailRoomCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailRoomCell.h"

@implementation LookMaintainDetailRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            _roomImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    _contentL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@"house_code"]];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"满意度：%@%@",dataDic[@"intent"],@"%"]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(3, attr.length - 3)];
    _satisfyL.attributedText = attr;
    _codeL.text = [NSString stringWithFormat:@"%@",dataDic[@"describe"]];
    _firstTimeL.text = [NSString stringWithFormat:@"首次看房时间：%@",dataDic[@"first_take_time"]];
    _lastTimeL.text = [NSString stringWithFormat:@"最后看房时间：%@",dataDic[@"last_take_time"]];
    _compL.text = [NSString stringWithFormat:@"%@",dataDic[@"finish_state"]];
    _numL.text = [NSString stringWithFormat:@"带看次数：%@",dataDic[@"take_num"]];
    NSMutableAttributedString *attrPrice;
    if ([dataDic[@"price"] integerValue] == 0) {
        
        attrPrice = [[NSMutableAttributedString alloc] initWithString:@"最新出价：未出价"];
    }else{
        
        attrPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最新出价：%@万",dataDic[@"price"]]];
    }
    [attrPrice addAttribute:NSForegroundColorAttributeName value:COLOR(255, 70, 70, 1) range:NSMakeRange(5, attrPrice.length - 5)];

    _priceL.attributedText = attrPrice;
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFill;
    _roomImg.clipsToBounds = YES;
    [self.contentView addSubview:_roomImg];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                _codeL = label;
                _codeL.textColor = YJTitleLabColor;
                _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
                [self.contentView addSubview:label];
                break;
            }
            case 1:
            {
                _satisfyL = label;
                _satisfyL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_satisfyL];
                break;
            }
            case 2:
            {
                _contentL = label;
                [self.contentView addSubview:_contentL];
                break;
            }
            case 3:
            {
                _compL = label;
                _compL.textAlignment = NSTextAlignmentRight;
                _compL.textColor = COLOR(255, 70, 70, 1);
                [self.contentView addSubview:_compL];
                break;
            }
            case 4:
            {
                _firstTimeL = label;
                [self.contentView addSubview:_firstTimeL];
                break;
            }
            case 5:
            {
                _lastTimeL = label;
                [self.contentView addSubview:_lastTimeL];
                break;
            }
            case 6:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 7:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
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
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_satisfyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
    }];
    
    [_compL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_satisfyL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_firstTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_lastTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_firstTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_lastTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_lastTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_roomImg.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
