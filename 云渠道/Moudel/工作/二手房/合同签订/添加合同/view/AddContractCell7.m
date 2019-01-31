//
//  AddContractCell7.m
//  云渠道
//
//  Created by xiaoq on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell7.h"

@implementation AddContractCell7

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}






- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _numL.text =[NSString stringWithFormat:@"客源编号：%@",dataDic[@"take_code"]];
//    _addressL.text = [NSString stringWithFormat:@"房源信息：%@",dataDic[@"title"]];
    _nameL.text =[NSString stringWithFormat:@"带看经纪人：%@",dataDic[@"butter_name"]];
    _telL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"butter_tel"]];
}

- (void)initUI{
    //
    //     _colorView = [[UIView alloc] init];//WithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    //    _colorView.backgroundColor = YJBlueBtnColor;
    //    [self.contentView addSubview:_colorView];
    //
    //    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(28 *SIZE, 13 *SIZE, 300 *SIZE, 15 *SIZE)];
    //    _titleL.textColor = YJTitleLabColor;
    //    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    //    [self.contentView addSubview:_titleL];
    //    _titleL.text =@"卖方信息";
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJContentLabColor;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numL];
    
    
//    
//    _addressL = [[UILabel alloc] init];
//    _addressL.frame = CGRectMake(0, 0, 300*SIZE, 14*SIZE);
//    _addressL.textColor = YJContentLabColor;
//    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _addressL.numberOfLines =0;
//    [self.contentView addSubview:_addressL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    
    
    _telL = [[UILabel alloc] init];
    _telL.textColor = YJContentLabColor;
    _telL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_telL];
    
    _choosebtn = [[UIButton alloc]init];
    [_choosebtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.contentView addSubview:_choosebtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    //    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self.contentView).offset(10 *SIZE);
    //        make.top.equalTo(self.contentView).offset(13 *SIZE);
    //        make.width.mas_equalTo(7 *SIZE);
    //        make.height.mas_equalTo(13 *SIZE);
    //    }];
    //
    //    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self.contentView).offset(28 *SIZE);
    //        make.top.equalTo(self.contentView).offset(13 *SIZE);
    //        make.width.mas_equalTo(100 *SIZE);
    //    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(300*SIZE);
        make.height.mas_equalTo(14*SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_numL.mas_bottom).offset(14 *SIZE);
        make.width.height.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(14*SIZE);
    }];
    
    [_telL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(14 *SIZE);
        make.width.height.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(14*SIZE);
        //        make.bottom.equalTo(self.contentView).offset(10*SIZE);
        
        
    }];
    
    [_choosebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(318 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(32 *SIZE);
        make.height.mas_equalTo(32*SIZE);
        //        make.bottom.equalTo(self.contentView).offset(5*SIZE);
        
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_telL.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
}

@end
