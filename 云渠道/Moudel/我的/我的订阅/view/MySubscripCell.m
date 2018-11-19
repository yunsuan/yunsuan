//
//  MySubscripCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/6.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "MySubscripCell.h"

@implementation MySubscripCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(11.7*SIZE,16.3*SIZE, 100*SIZE, 88.3*SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(124 *SIZE, 16 *SIZE, 200 *SIZE, 14 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:13*SIZE];
    [self.contentView addSubview:_nameL];
    
    _addressL = [[UILabel alloc]initWithFrame:CGRectMake(124 *SIZE, 37 *SIZE, 200 *SIZE, 11 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font =[UIFont systemFontOfSize:11*SIZE];
    [self.contentView addSubview:_addressL];
    
    
//    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 56.3*SIZE, 200*SIZE, 16.7*SIZE) type:@"0"];
//    [self.contentView addSubview:_wuyeview];
//
//    _tagview = [[TagView alloc]initWithFrame:CGRectMake(124.7*SIZE, 79.7*SIZE, 200*SIZE, 16.7*SIZE) type:@"1"];
//    [self.contentView addSubview:_tagview];
    
    UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
    lane.backgroundColor = YJBackColor;
    [self.contentView addSubview:lane];
}


//-(void)settagviewWithdata:(NSArray *)data
//{
//    [_wuyeview setData:data[0]];
//    [_tagview setData:data[1]];
//}

@end
