//
//  ChooseHouseCell.m
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ChooseHouseCell.h"

@implementation ChooseHouseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headimg = [[UIImageView alloc]init];
        _headimg.frame = CGRectMake(10*SIZE, 17*SIZE, 67*SIZE, 67*SIZE);
        [self.contentView addSubview:_headimg];
//        _headimg.image = [UIImage imageNamed:@"Grabtheorder"];
        
        
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 16*SIZE, 200*SIZE, 16*SIZE)];
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont boldSystemFontOfSize:14*SIZE];
        [self.contentView addSubview:_titlelab];
        
//        _titlelab.text = @"翡翠滨江 3栋2单元1102";
        
        _numlab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 41*SIZE, 200*SIZE, 13*SIZE)];
        _numlab.textColor = YJContentLabColor;
        _numlab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_numlab];
        
//        _numlab.text = @"房源编号：110256151215";
        
        _namelab = [[UILabel alloc]initWithFrame:CGRectMake(93*SIZE, 61*SIZE, 200*SIZE, 13*SIZE)];
        _namelab.textColor = YJContentLabColor;
        _namelab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_namelab];
        
//        _namelab.text  =@"勘察人：李四";
        
        _phonelab = [[UILabel alloc]initWithFrame:CGRectMake(250*SIZE, 61*SIZE, 100*SIZE, 13*SIZE)];
        _phonelab.textColor = YJContentLabColor;
        _phonelab.textAlignment = NSTextAlignmentRight;
        _phonelab.font =[UIFont systemFontOfSize:12*SIZE];
        [self.contentView addSubview:_phonelab];
        
        
//        _phonelab.text =@"13564512232";
       
        
        UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 100*SIZE, 360*SIZE, 1*SIZE)];
        lane.backgroundColor = YJBackColor;
        [self.contentView addSubview:lane];
    }
    return self;
}

-(void)setdatabydata:(NSDictionary *)dic{
    
    [_headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            image = [UIImage imageNamed:@"default_2"];
        }
    }];

    _titlelab.text = dic[@"title"];
    
    _numlab.text = [NSString stringWithFormat:@"房源编号：%@",dic[@"house_code"]];

    _namelab.text  =[NSString stringWithFormat:@"勘察人：%@",dic[@"survey_agent_name"]];
    
    _phonelab.text =dic[@"survey_agent_tel"];
}


@end
