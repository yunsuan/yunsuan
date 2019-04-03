//
//  RecommendContentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendContentCell.h"

@implementation RecommendContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

//- (void)setModel:(RecommendInfoModel *)model{
//
//    if (model.img_url.length>0) {
//        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.img_url]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//            if (error) {
//
//                _headImg.image = [UIImage imageNamed:@"default_3"];
//            }
//        }];
//    }
//    else{
//        _headImg.image = [UIImage imageNamed:@"default_3"];
//    }
//
//    _titleL.text = model.title;
//    _contentL.text = model.desc;
//
//    _timeL.text = [NSString stringWithFormat:@"%@",model.update_time];
//    _sourceL.text = model.source;
//    if ([model.source isEqualToString:@"原创"]) {
//        _autherL.text = [NSString stringWithFormat:@"作者:%@",model.source_comment];
//    }
//    else{
//        _autherL.text = [NSString stringWithFormat:@"来源:%@",model.source_comment];
//    }
//
//    [_sourceL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(_headImg.mas_bottom).offset(8 *SIZE);
//        make.width.equalTo(@(_sourceL.mj_textWith + 5 *SIZE));
//    }];
//}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
//    if ([dataDic[@"img_url"] length] > 0) {
//        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//            if (error) {
//
//                _headImg.image = [UIImage imageNamed:@"default_3"];
//            }
//        }];
//    }
//    else{
//        _headImg.image = [UIImage imageNamed:@"default_3"];
//    }
    
    _titleL.text = dataDic[@"title"];
    _contentL.text = dataDic[@"desc"];
    
    _timeL.text = [NSString stringWithFormat:@"%@",dataDic[@"adopt_time"]];
    _sourceL.text = dataDic[@"label"];
    _autherL.text = [NSString stringWithFormat:@"作者:%@",dataDic[@"nick_name"]];
    
    [_sourceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(_sourceL.mj_textWith + 5 *SIZE));
    }];
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.numberOfLines = 2;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 3;
    [self.contentView addSubview:_contentL];
    
    _sourceL = [[UILabel alloc] init];
    _sourceL.textColor = [UIColor whiteColor];
    _sourceL.backgroundColor = YJBlueBtnColor;
    _sourceL.layer.cornerRadius = 2 *SIZE;
    _sourceL.clipsToBounds = YES;
    _sourceL.textAlignment = NSTextAlignmentCenter;
    _sourceL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_sourceL];
    
    
    _autherL = [[UILabel alloc] init];
    _autherL.textColor = YJContentLabColor;
    _autherL.font = [UIFont systemFontOfSize:11 *SIZE];
    _autherL.numberOfLines = 0;
    _autherL.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_autherL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.numberOfLines = 0;
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_sourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(_sourceL.mj_textWith + 5 *SIZE));
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(80 *SIZE));
    }];
    
    [_autherL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(200 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
