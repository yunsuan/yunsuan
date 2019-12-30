//
//  AddContractCell4.m
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell4.h"

@implementation AddContractCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}






- (void)setData:(NSMutableDictionary *)dataDic{
//    _titelL.text =dataDic[@"report_type_name"];
    _nameL.text = dataDic[@"name"];
    _telL.text = dataDic[@"tel"];
    if ([dataDic[@"sex"] integerValue]==1) {
        _seximg.image =[UIImage imageNamed:@"man"];
    }
    if ([dataDic[@"sex"] integerValue]==2) {
        _seximg.image =[UIImage imageNamed:@"girl"];
    }
    _propertyL.text = [NSString stringWithFormat:@"权益比例：%@",dataDic[@"property"]];
}

-(void)action_stickie
{
    if (_stickieBlock!=nil) {
        self.stickieBlock(_indexpath);
    }
}


- (void)initUI{

    
    _titelL = [[UILabel alloc] init];
    _titelL.textColor = YJTitleLabColor;
    _titelL.font = [UIFont systemFontOfSize:14 *SIZE];
    [self.contentView addSubview:_titelL];
    
    _propertyL = [[UILabel alloc] init];
    _propertyL.textColor = YJContentLabColor;
//    _propertyL.textAlignment = NSTextAlignmentRight;
    _propertyL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_propertyL];
    
    
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    
    _seximg = [[UIImageView alloc]init];
    [self.contentView addSubview:_seximg];
    
    
    _telL = [[UILabel alloc] init];
    _telL.textColor = YJContentLabColor;
    _telL.textAlignment = NSTextAlignmentRight;
    _telL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_telL];
    
    
    _stickieBtn = [[UIButton alloc]initWithFrame:CGRectMake(300*SIZE, 10*SIZE, 50*SIZE, 16*SIZE)];
    [_stickieBtn setTitle:@"置顶" forState:UIControlStateNormal];
    [_stickieBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
    _stickieBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    [_stickieBtn addTarget:self action:@selector(action_stickie) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_stickieBtn];
 
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(200*SIZE);
        make.height.mas_equalTo(16*SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_titelL.mas_bottom).offset(17 *SIZE);
        make.height.mas_equalTo(14*SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_seximg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(8 *SIZE);
        make.top.equalTo(_titelL.mas_bottom).offset(17 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
        make.height.mas_equalTo(12*SIZE);
    }];
    
    [_telL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(_titelL.mas_bottom).offset(17 *SIZE);
        make.width.height.mas_equalTo(180 *SIZE);
        make.height.mas_equalTo(14*SIZE);
//        make.bottom.equalTo(self.contentView).offset(4*SIZE);
        
        
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(_seximg.mas_right).offset(8 *SIZE);
        make.top.equalTo(_titelL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
        make.height.mas_equalTo(14*SIZE);
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
