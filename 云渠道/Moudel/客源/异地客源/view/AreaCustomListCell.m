//
//  AreaCustomListCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/2.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomListCell.h"

@interface AreaCustomListCell ()

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIView *line;

@end

@implementation AreaCustomListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"名称：%@",dataDic[@"name"]];
    _regionL.text = [NSString stringWithFormat:@"推荐区域：%@",dataDic[@"city_name"]];
    if ([dataDic[@"price_max"] length] && [dataDic[@"price_min"] length]) {
        
        _totalL.text = [NSString stringWithFormat:@"总价：%@-%@万",dataDic[@"price_min"],dataDic[@"price_max"]];
    }else if ([dataDic[@"price_min"] length]){

        _totalL.text = [NSString stringWithFormat:@"总价：%@万",dataDic[@"price_min"]];
    }else if ([dataDic[@"price_max"] length]){
        
        _totalL.text = [NSString stringWithFormat:@"总价：%@万",dataDic[@"price_max"]];
    }else{
        
        _totalL.text = [NSString stringWithFormat:@"总价：0元"];
    }
    _timeL.text = [NSString stringWithFormat:@"登记时间：%@",dataDic[@"create_time"]];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"tel"]];
    _intentL.text = [NSString stringWithFormat:@"意向：%@",dataDic[@"type_name"]];
    
    if ([dataDic[@"area_max"] length] && [dataDic[@"area_min"] length]) {
        
        _areaL.text = [NSString stringWithFormat:@"面积：%@-%@㎡",dataDic[@"area_min"],dataDic[@"area_max"]];
    }else if ([dataDic[@"area_min"] length]){

        _areaL.text = [NSString stringWithFormat:@"面积：%@㎡",dataDic[@"area_min"]];
    }else if ([dataDic[@"area_max"] length]){
        
        _areaL.text = [NSString stringWithFormat:@"面积：%@㎡",dataDic[@"area_max"]];
    }else{
        
        _areaL.text = [NSString stringWithFormat:@"面积：0㎡"];
    }
    
    _statusL.text = dataDic[@"current_state_name"];
}

- (void)initUI{
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _phoneL = label;
                _phoneL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_phoneL];
                break;
            }
            case 2:
            {
                _regionL = label;
                [self.contentView addSubview:_regionL];
                break;
            }
            case 3:
            {
                _intentL = label;
                _intentL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 4:
            {
                _totalL = label;
                [self.contentView addSubview:_totalL];
                break;
            }
            case 5:
            {
                _areaL = label;
                _areaL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_areaL];
                break;
            }
            case 6:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 7:
            {
                _statusL = label;
                _statusL.textAlignment = NSTextAlignmentRight;
                _statusL.textColor = YJBlueBtnColor;
                [self.contentView addSubview:_statusL];
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
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(160 *SIZE);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_totalL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_totalL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];

    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
}

@end
