//
//  CompanyCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(11.7*SIZE,16.3*SIZE, 100*SIZE, 88.3*SIZE)];
        _imageview.contentMode = UIViewContentModeScaleAspectFill;
        _imageview.clipsToBounds = YES;
        [self.contentView addSubview:_imageview];
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(123.3*SIZE, 16*SIZE, 200*SIZE, 14*SIZE)];
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
        [self.contentView addSubview:_titlelab];
        _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(124.3*SIZE, 37*SIZE, 200*SIZE, 11*SIZE)];
        _contentlab.textColor = YJContentLabColor;
        _contentlab.font =[UIFont systemFontOfSize:10.7*SIZE];
        [self.contentView addSubview:_contentlab];
        _statulab = [[UILabel alloc]initWithFrame:CGRectMake(327.7*SIZE, 15.7*SIZE, 30*SIZE, 13*SIZE)];
        _statulab.textColor = COLOR(27, 152, 255, 1);
        _statulab.font = [UIFont systemFontOfSize:12*SIZE];
//        [self.contentView addSubview:_statulab];
        
        _statusImg = [[UIImageView alloc] initWithFrame:CGRectMake(333 *SIZE, 11 *SIZE, 17 *SIZE, 17 *SIZE)];
        _statusImg.image = [UIImage imageNamed:@"tui"];
        [self.contentView addSubview:_statusImg];
        
        _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 56.3*SIZE, 200*SIZE, 16.7*SIZE) type:@"0"];
        [self.contentView addSubview:_wuyeview];
        
        _tagview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 79.7*SIZE, 200*SIZE, 16.7*SIZE) type:@"1"];
        [self.contentView addSubview:_tagview];
        
        UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
        lane.backgroundColor = YJBackColor;
        [self.contentView addSubview:lane];
    }
    return self;
}

-(void)SetTitle:(NSString *)title image:(NSString *)imagename contentlab:(NSString *)content statu:(NSString *)statu
{
    if (imagename.length>0) {
        [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,imagename]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
              _imageview.image= [UIImage imageNamed:@"default_1"];
            }
        }];
    }
    else{
        _imageview.image= [UIImage imageNamed:@"default_1"];
    }
   
    _titlelab.text = title;
    _statulab.text = statu;
    _contentlab.text = content;
}


-(void)settagviewWithdata:(NSArray *)data
{
    [_wuyeview setData:data[0]];
    [_tagview setData:data[1]];
}
@end
