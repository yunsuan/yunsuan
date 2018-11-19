//
//  AttentionTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AttentionTableCell.h"

@implementation AttentionTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(10 *SIZE, 16*SIZE, 100 *SIZE, 88 *SIZE)];
//    _headImg.backgroundColor = YJGreenColor;
    _headImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(121 *SIZE, 16 *SIZE, 230*SIZE, 14*SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:13*SIZE];
    [self.contentView addSubview:_nameL];
    
    _areaL = [[UILabel alloc]initWithFrame:CGRectMake(122 *SIZE, 34 *SIZE, 150 *SIZE, 11*SIZE)];
    _areaL.textColor = YJContentLabColor;
    _areaL.font =[UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _priceL = [[UILabel alloc]initWithFrame:CGRectMake(280 *SIZE, 35 *SIZE, 70 *SIZE, 12 *SIZE)];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font =[UIFont systemFontOfSize:13 *SIZE];
    _priceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceL];
    
    _addressL = [[UILabel alloc]initWithFrame:CGRectMake(122 *SIZE, 51 *SIZE, 200 *SIZE, 13*SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_addressL];
    
    _typeL = [[UILabel alloc]initWithFrame:CGRectMake(122 *SIZE, 71 *SIZE, 100*SIZE, 13*SIZE)];
    _typeL.textColor = YJContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _attributeL = [[UILabel alloc]initWithFrame:CGRectMake(9 *SIZE, 117 *SIZE, 150 *SIZE, 10 *SIZE)];
    _attributeL.textColor = YJContentLabColor;
    _attributeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_attributeL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(200 *SIZE, 119 *SIZE, 150 *SIZE, 10 *SIZE)];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
//    _tagView =
    _tagView = [[TagView alloc]initWithFrame:CGRectMake(123 *SIZE, 87 *SIZE, 200*SIZE, 16.7*SIZE)  type:@"1"];
    [self.contentView addSubview:_tagView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 140 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

-(void)settagviewWithdata:(NSArray *)data
{
    [_tagView setData:data[0]];

}

@end
