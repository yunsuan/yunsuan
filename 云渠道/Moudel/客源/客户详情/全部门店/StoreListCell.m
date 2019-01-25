//
//  StoreListCell.m
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreListCell.h"

@implementation StoreListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headimg = [[UIImageView alloc]init];
        _headimg.frame = CGRectMake(10*SIZE, 16*SIZE, 67*SIZE, 67*SIZE);
        [self.contentView addSubview:_headimg];
//        _headimg.image = [UIImage imageNamed:@"Grabtheorder"];
        
        
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 16*SIZE, 200*SIZE, 15*SIZE)];
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont boldSystemFontOfSize:14*SIZE];
        [self.contentView addSubview:_titlelab];
        
//        _titlelab.text = @"门店名称：清江西路门店";
        
        _numlab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 35*SIZE, 200*SIZE, 13*SIZE)];
        _numlab.textColor = YJContentLabColor;
        _numlab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_numlab];
        
//        _numlab.text = @"门店编号：110256151215";
        
        _namelab = [[UILabel alloc]initWithFrame:CGRectMake(250*SIZE, 35*SIZE, 100*SIZE, 13*SIZE)];
        _namelab.textColor = YJContentLabColor;
        _namelab.textAlignment = NSTextAlignmentRight;
        _namelab.font = [UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_namelab];
        
//        _namelab.text  =@"负责人：李四";
        
        _adresslab = [[UILabel alloc]init];//WithFrame:CGRectMake(93*SIZE, 61*SIZE, 180*SIZE, 13*SIZE)];
        _adresslab.textColor = YJContentLabColor;
        _adresslab.font =[UIFont systemFontOfSize:12*SIZE];
//        _adresslab.textAlignment = 2;
        _adresslab.numberOfLines = 2;
        [self.contentView addSubview:_adresslab];
        
//        _adresslab.text  =@"门店地址：清江西路13号";
        _housenumlab =  [[UILabel alloc]init];//WithFrame:CGRectMake(93*SIZE, 82*SIZE, 200*SIZE, 13*SIZE)];
        _housenumlab.textColor = YJContentLabColor;
        _housenumlab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_housenumlab];
        
//        _housenumlab.text  =@"可售房源：23套";
        
        
        _recomentBtn = [[UIButton alloc]initWithFrame:CGRectMake(283*SIZE, 65*SIZE, 67*SIZE, 30*SIZE)];
        [_recomentBtn setTitle:@"推荐" forState:UIControlStateNormal];
        [_recomentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _recomentBtn.backgroundColor = YJBlueBtnColor;
        _recomentBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
        _recomentBtn.layer.masksToBounds = YES;
        _recomentBtn.layer.cornerRadius = 2*SIZE;
        [self.contentView addSubview:_recomentBtn];
        
        
        UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 109*SIZE, 360*SIZE, 1*SIZE)];
        lane.backgroundColor = YJBackColor;
        [self.contentView addSubview:lane];
        
        [_adresslab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(93 *SIZE);
            make.top.equalTo(_numlab.mas_bottom).offset(5 *SIZE);
            make.width.mas_equalTo(180*SIZE);
            
        }];
        
        [_housenumlab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(93 *SIZE);
            make.top.equalTo(_adresslab.mas_bottom).offset(5 *SIZE);
            make.width.mas_equalTo(180*SIZE);
            make.height.mas_equalTo(13*SIZE);
        }];
    }
    return self;
}

-(void)setDataBydata:(NSDictionary *)data type:(NSString *)type
{
    _titlelab.text = data[@"store_name"];
    _numlab.text = [ NSString stringWithFormat:@"门店编号：%@",data[@"store_code"]];
    _namelab.text = [ NSString stringWithFormat:@"负责人：%@",data[@"contact"]];
    _adresslab.text =[ NSString stringWithFormat:@"门店地址：%@",data[@"address"]];
    if ([type isEqualToString:@"1"]) {
        _housenumlab.text =[NSString stringWithFormat:@"可售房源：%@套",data[@"on_sale"]];
    }else{
        _housenumlab.text= [NSString stringWithFormat:@"可租房源：%@套",data[@"on_rent"]];
    }
   
    [_headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,data[@"log"]]] placeholderImage: [UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            _headimg.image = [UIImage imageNamed:@"default_1"];
        }
    }];
    _recomentBtn.tag = [data[@"store_id"] integerValue] ;
    
//    [_adresslab mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(93 *SIZE);
//        make.top.equalTo(_numlab.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(180*SIZE);
//
//    }];
//
//    [_housenumlab mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(93 *SIZE);
//        make.top.equalTo(_adresslab.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(180*SIZE);
//        make.height.mas_equalTo(13*SIZE);
//    }];
    
}

@end
