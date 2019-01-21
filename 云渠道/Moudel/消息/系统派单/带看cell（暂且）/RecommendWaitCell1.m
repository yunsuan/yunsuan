//
//  RecommendWaitCell1.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendWaitCell1.h"

@implementation RecommendWaitCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@""]];
    _nameL.text = [NSString stringWithFormat:@"名称：%@",dataDic[@""]];
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    _levelL.text = [NSString stringWithFormat:@"客户等级：%@",dataDic[@""]];
    _demandL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    _progressL.text = [NSString stringWithFormat:@"带看进度：%@",dataDic[@""]];
    _numL.text = [NSString stringWithFormat:@"已看房数量：%@",dataDic[@""]];
    _matchL.text = [NSString stringWithFormat:@"匹配房源：%@",dataDic[@""]];
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
    
    _levelL = [[UILabel alloc] init];
    _levelL.textColor = YJ86Color;
    _levelL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_levelL];
    
    _demandL = [[UILabel alloc] init];
    _demandL.textColor = YJ86Color;
    _demandL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_demandL];
    
    _progressL = [[UILabel alloc] init];
    _progressL.textColor = YJ86Color;
    _progressL.textAlignment = NSTextAlignmentRight;
    _progressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_progressL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJ86Color;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numL];
    
    _matchL = [[UILabel alloc] init];
    _matchL.textColor = YJ86Color;
    _matchL.font = [UIFont systemFontOfSize:12 *SIZE];
    _matchL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_matchL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-9 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(201 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_demandL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_levelL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_progressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(201 *SIZE);
        make.top.equalTo(_levelL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(_demandL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(140 *SIZE);
    }];
    
    [_matchL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(201 *SIZE);
        make.top.equalTo(_demandL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_matchL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
