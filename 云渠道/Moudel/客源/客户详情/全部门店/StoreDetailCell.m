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
        _numlab = [[UILabel alloc]initWithFrame:CGRectMake(29*SIZE, 20*SIZE, 200*SIZE, 13*SIZE)];
        _numlab.textColor = YJContentLabColor;
        _numlab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_numlab];
        
                _numlab.text = @"门店编号：110256151215";
        
        _namelab = [[UILabel alloc]initWithFrame:CGRectMake(29*SIZE, 43*SIZE, 200*SIZE, 13*SIZE)];
        _namelab.textColor = YJContentLabColor;
        _namelab.font = [UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_namelab];
        
                _namelab.text  =@"门店名称：清江西路门店";
        
        _adresslab = [[UILabel alloc]init];//WithFrame:CGRectMake(93*SIZE, 61*SIZE, 180*SIZE, 13*SIZE)];
        _adresslab.textColor = YJContentLabColor;
        _adresslab.font =[UIFont systemFontOfSize:12*SIZE];
        //        _adresslab.textAlignment = 2;
        _adresslab.numberOfLines = 0;
        [self.contentView addSubview:_adresslab];
        _adresslab.text  =@"门店地址：清江西路13号";
       
        _peoplelab = [[UILabel alloc]init];
        _peoplelab.textColor = YJContentLabColor;
        _peoplelab.font =[UIFont systemFontOfSize:12*SIZE];
        //        _adresslab.textAlignment = 2;
        [self.contentView addSubview:_peoplelab];
        _peoplelab.text  =@"联系人：张三";
 
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
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"13438339177"];
        
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
            make.width.mas_equalTo(12*SIZE);
            make.height.mas_equalTo(15*SIZE);
        }];
        
        [_phonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_phonelab.mas_right).offset(-10 *SIZE);
            make.top.equalTo(_peoplelab.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(80*SIZE);
            make.height.mas_equalTo(13*SIZE);
           
        }];
        
    }
    return self;
}

-(void)setDataBydata:(NSDictionary *)data type:(NSString *)type
{
//    _titlelab.text = data[@"store_name"];
//    _numlab.text = [ NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]];
//    _namelab.text = [ NSString stringWithFormat:@"负责人：%@",data[@"contact"]];
//    _adresslab.text =[ NSString stringWithFormat:@"门店地址：%@",data[@"address"]];
//    if ([type isEqualToString:@"1"]) {
//        _housenumlab.text =[NSString stringWithFormat:@"可售房源：%@套",data[@"on_sale"]];
//    }else{
//        _housenumlab.text= [NSString stringWithFormat:@"可租房源：%@套",data[@"on_rent"]];
//    }
//
//    [_headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,data[@"log"]]] placeholderImage: [UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error) {
//            _headimg.image = [UIImage imageNamed:@"default_1"];
//        }
//    }];
//    _recomentBtn.tag = [data[@"store_id"] integerValue] ;
    
}


@end
