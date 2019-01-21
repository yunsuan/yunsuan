//
//  RecommendComplaitCell1.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendComplaitCell1.h"

@implementation RecommendComplaitCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    //    _codeL.text = [NSString stringWithFormat:@"客户编号：%@",dataDic[@""]];
    //    _houseCodeL.text = [NSString stringWithFormat:@"房源编号：%@",dataDic[@""]];
    //    _nameL.text = [NSString stringWithFormat:@"名称：%@",dataDic[@""]];
    //    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    //    _numL.text = [NSString stringWithFormat:@"已看房数量：%@",dataDic[@""]];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = YJ86Color;
    _storeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_storeL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    //    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = YJ86Color;
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _recommendTimeL = [[UILabel alloc] init];
    _recommendTimeL.textColor = YJ86Color;
    _recommendTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_recommendTimeL];
    
    _complaintTimeL = [[UILabel alloc] init];
    _complaintTimeL.textColor = YJ86Color;
    _complaintTimeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_complaintTimeL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(201 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_recommendTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_complaintTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_recommendTimeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_complaintTimeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}
@end
