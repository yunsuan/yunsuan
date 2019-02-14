//
//  ContractSignListCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractSignListCell.h"

@implementation ContractSignListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            image =[UIImage imageNamed:@"default_1"];
        }
    }];
   
    _codeL.text = [NSString stringWithFormat:@"合同编号%@",dataDic[@"deal_code"]];
    _priceL.text =[NSString stringWithFormat:@"%@",dataDic[@"deal_money"]];
    _areaL.text = dataDic[@"address"];
    _customL.text = [NSString stringWithFormat:@"客户：%@",dataDic[@"client_name"]];
    _ownerL.text = [NSString stringWithFormat:@"业主：%@",dataDic[@"owner_name"]];
    _signerL.text = [NSString stringWithFormat:@"签约人：%@",dataDic[@"agent_name"]];
    _timeL.text = dataDic[@"create_time"];
 
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    

    
    _statusL = [[UILabel alloc] init];
//    _statusL.textColor = YJ86Color;
    _statusL.font = [UIFont systemFontOfSize:10 *SIZE];
    _statusL.textAlignment = NSTextAlignmentCenter;
    _statusL.backgroundColor = COLOR(0, 0, 0, 0.3);
    [self.contentView addSubview:_statusL];
//    _statusL.text = @"已签约";
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:14 *SIZE];
    [self.contentView addSubview:_codeL];
//    _codeL.text = @"交易编号：1354632321360";
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = [UIColor redColor];
    _priceL.textAlignment = NSTextAlignmentRight;
    _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_priceL];
//    _priceL.text =@"120万";
    
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJContentLabColor;
    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_areaL];
//    _areaL.text = @"成都市-高新区-链家门店";
    
    _customL = [[UILabel alloc] init];
    _customL.textColor = YJContentLabColor;
    _customL.font = [UIFont systemFontOfSize:12 *SIZE];
    _customL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_customL];
//    _customL.text = @"客户：张三";
    
    _ownerL = [[UILabel alloc] init];
    _ownerL.textColor = YJContentLabColor;
    _ownerL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_ownerL];
//    _ownerL.text = @"业主：张三";
    
    
    _signerL = [[UILabel alloc] init];
    _signerL.textColor = YJContentLabColor;
    _signerL.font = [UIFont systemFontOfSize:12 *SIZE];
    _signerL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_signerL];
//        _signerL.text = @"签约人：李四";
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
//    _timeL.text = @"2018/12/20";
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.height.with.mas_equalTo(67 *SIZE);
        make.width.with.mas_equalTo(67 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_headImg.mas_top).offset(50 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(93 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(93 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(40 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_ownerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(92 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_signerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(61 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(92 *SIZE);
        make.top.equalTo(_ownerL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(0.5*SIZE);
    }];
}

@end
