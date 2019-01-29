//
//  SecondaryMatchCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondaryMatchCell2.h"

@implementation SecondaryMatchCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDicData:(NSMutableDictionary *)dicData{
    
    [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dicData[@"log"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            _roomImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    _storeNameL.text = [NSString stringWithFormat:@"门店名称：%@",dicData[@"store_name"]];
    _codeL.text = [NSString stringWithFormat:@"门店编号：%@",dicData[@"store_code"]];
    _addressL.text = [NSString stringWithFormat:@"门店地址：%@",dicData[@"address"]];
    _contactL.text = [NSString stringWithFormat:@"负责人：%@",dicData[@"contact"]];
    _matchNumL.text = [NSString stringWithFormat:@"匹配房源：%@套",dicData[@"count"]];
}

- (void)ActionRecomendBtn:(UIButton *)btn{
    
    if (self.secondaryMatchCell2Block) {
        
        self.secondaryMatchCell2Block(self.tag);
    }
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_roomImg];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                _storeNameL = label;
                _storeNameL.textColor = YJTitleLabColor;
                _storeNameL.font = [UIFont systemFontOfSize:13 *SIZE];
                [self.contentView addSubview:_storeNameL];
                break;
            }
            case 1:
            {
                _codeL = label;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 2:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 3:
            {
                _contactL = label;
                [self.contentView addSubview:_contactL];
                break;
            }
            case 4:
            {
                _matchNumL = label;
                [self.contentView addSubview:_matchNumL];
                break;
            }
            default:
                break;
        }
    }
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_recommendBtn addTarget:self action:@selector(ActionRecomendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    _recommendBtn.layer.cornerRadius = 2 *SIZE;
    _recommendBtn.clipsToBounds = YES;
    [self.contentView addSubview:_recommendBtn];
    
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
    
    [_storeNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(230 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_storeNameL.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(230 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(230 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_matchNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(281 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_roomImg.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
