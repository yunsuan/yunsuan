//
//  roominfoCell.m
//  云渠道
//
//  Created by xiaoq on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "roominfoCell.h"

@implementation roominfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _addressL.text = [NSString stringWithFormat:@"%@ %@",dataDic[@"project_name"],dataDic[@"address"]];
    _houseCodeL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@"house_code"]];
    _houseNumL.text = [NSString stringWithFormat:@"房号：%@",dataDic[@"house_name"]];
//    _houseTypeL.text = [NSString stringWithFormat:@"户型：%@",dataDic[@""]];
    _areaL.text = [NSString stringWithFormat:@"面积：%@㎡",dataDic[@"build_area"]];
//    _certNumL.text = [NSString stringWithFormat:@"房屋所有权证号：%@",dataDic[@""]];
//    _homelandL.text = [NSString stringWithFormat:@"国土使用证号：%@",dataDic[@""]];
    _agentL.text = [NSString stringWithFormat:@"勘察经纪人：%@",dataDic[@"survey_agent_name"]];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"survey_agent_tel"]];
}

-(void)initUI
{
    
//    self.contentView.backgroundColor =
    
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _addressL = label;
                _addressL.textColor = YJTitleLabColor;
                _addressL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
                [self.contentView addSubview:_addressL];
                break;
            }
            case 1:
            {
                _houseCodeL = label;
                [self.contentView addSubview:_houseCodeL];
                break;
            }
            case 2:
            {
                _houseNumL = label;
                [self.contentView addSubview:_houseNumL];
                break;
            }
            case 3:
            {
//                _houseTypeL = label;
//                [self.contentView addSubview:_houseTypeL];
                break;
            }
            case 4:
            {
                _areaL = label;
                [self.contentView addSubview:_areaL];
                break;
            }
            case 5:
            {
//                _certNumL = label;
//                [self.contentView addSubview:_certNumL];
                break;
            }
            case 6:
            {
//                _homelandL = label;
//                [self.contentView addSubview:_homelandL];
                break;
            }
            case 7:
            {
                _agentL = label;
                [self.contentView addSubview:_agentL];
                break;
            }
            case 8:
            {
                _phoneL = label;
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
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_houseCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_houseNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_houseCodeL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
//    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(_houseNumL.mas_bottom).offset(18 *SIZE);
//        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_houseNumL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
//    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(_areaL.mas_bottom).offset(18 *SIZE);
//        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//    }];
//
//    [_homelandL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(_certNumL.mas_bottom).offset(18 *SIZE);
//        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//    }];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_agentL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-42 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
