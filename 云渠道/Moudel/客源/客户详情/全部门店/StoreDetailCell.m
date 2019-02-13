//
//  StoreDetailCell.m
//  云渠道
//
//  Created by xiaoq on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreDetailCell.h"

@implementation StoreDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _numlab = [[UILabel alloc]init];//WithFrame:CGRectMake(29*SIZE, 20*SIZE, 200*SIZE, 13*SIZE)];
        _numlab.textColor = YJContentLabColor;
        _numlab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_numlab];
        [_numlab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(29 *SIZE);
            make.top.equalTo(self.contentView).offset(20 *SIZE);
            make.width.mas_equalTo(200*SIZE);
        }];

        
//                _numlab.text = @"门店编号：110256151215";
        
        _namelab = [[UILabel alloc]init];//WithFrame:CGRectMake(29*SIZE, 43*SIZE, 200*SIZE, 13*SIZE)];
        _namelab.textColor = YJContentLabColor;
        _namelab.font = [UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_namelab];
        [_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(29 *SIZE);
            make.top.equalTo(_numlab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(200*SIZE);
        }];
//                _namelab.text  =@"门店名称：清江西路门店";
        
        _adresslab = [[UILabel alloc]init];//WithFrame:CGRectMake(93*SIZE, 61*SIZE, 180*SIZE, 13*SIZE)];
        _adresslab.textColor = YJContentLabColor;
        _adresslab.font =[UIFont systemFontOfSize:12*SIZE];
        //        _adresslab.textAlignment = 2;
        _adresslab.numberOfLines = 0;
        [self.contentView addSubview:_adresslab];
//        _adresslab.text  =@"门店地址：清江西路13号";
       
        _peoplelab = [[UILabel alloc]init];
        _peoplelab.textColor = YJContentLabColor;
        _peoplelab.font =[UIFont systemFontOfSize:12*SIZE];
        //        _adresslab.textAlignment = 2;
        [self.contentView addSubview:_peoplelab];
//        _peoplelab.text  =@"联系人：张三";
 
         _phonelab= [[UILabel alloc]init];
        _phonelab.textColor = YJContentLabColor;
        _phonelab.font =[UIFont systemFontOfSize:12*SIZE];
        //        _adresslab.textAlignment = 2;
        [self.contentView addSubview:_phonelab];
        _phonelab.text  =@"联系电话：";
        
        _mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mapbtn setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
        [self.contentView addSubview:_mapbtn];
        
        _phonebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@""];
        
        //设置下划线...
        /*
         NSUnderlineStyleNone                                    = 0x00, 无下划线
         NSUnderlineStyleSingle                                  = 0x01, 单行下划线
         NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
         NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
         */
        [tncString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:(NSRange){0,[tncString length]}];
        //此时如果设置字体颜色要这样
        [tncString addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0,[tncString length])];
        
        [tncString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*SIZE] range:NSMakeRange(0,[tncString length])];
        //设置下划线颜色...
        [tncString addAttribute:NSUnderlineColorAttributeName value:YJBlueBtnColor range:(NSRange){0,[tncString length]}];
        [_phonebtn setAttributedTitle:tncString forState:UIControlStateNormal];
        [self.contentView addSubview:_phonebtn];
        
        
        [_adresslab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(29 *SIZE);
            make.top.equalTo(_namelab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(180*SIZE);
            
        }];
        
        [_peoplelab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(29 *SIZE);
            make.top.equalTo(_adresslab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(260*SIZE);
        }];
        [_phonelab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(29 *SIZE);
            make.top.equalTo(_peoplelab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(70*SIZE);
            make.bottom.equalTo(self.contentView).offset(-10*SIZE);
            
        }];

        
        [_mapbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(300 *SIZE);
            make.top.equalTo(_namelab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(15*SIZE);
            make.height.mas_equalTo(15*SIZE);
        }];
        
        [_phonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_phonelab.mas_right).offset(-10 *SIZE);
            make.top.equalTo(_peoplelab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(85*SIZE);
            make.height.mas_equalTo(13*SIZE);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10 *SIZE);
        }];
        
    }
    return self;
}

-(void)setDataBydata:(NSDictionary *)data
{
    
    _numlab.text = [ NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]];
    _namelab.text  =[ NSString stringWithFormat:@"门店名称：%@",data[@"store_name"]];
    _adresslab.text  =[ NSString stringWithFormat:@"门店地址：%@",data[@"address"]];
    _peoplelab.text  =[ NSString stringWithFormat:@"联系人：%@",data[@"contact"]];
    
    
    if (data[@"contact_tel"]) {
        
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:data[@"contact_tel"]];

    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0,[tncString length])];
    
    [tncString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*SIZE] range:NSMakeRange(0,[tncString length])];
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:YJBlueBtnColor range:(NSRange){0,[tncString length]}];
    [_phonebtn setAttributedTitle:tncString forState:UIControlStateNormal];
    }
    
    
    
}


@end
