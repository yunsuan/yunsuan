//
//  AddContractCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell2.h"

@implementation AddContractCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _addbtn = [[UIButton alloc]initWithFrame:CGRectMake(40*SIZE, 5*SIZE, 120*SIZE, 35*SIZE)];
    [_addbtn setTitle:@"添加权益人" forState:UIControlStateNormal];
    [_addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addbtn.backgroundColor = YJBlueBtnColor;
    _addbtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    _addbtn.layer.masksToBounds = YES;
    _addbtn.layer.cornerRadius = 5*SIZE;
    [self.contentView addSubview:_addbtn];
    
    _choosebtn = [[UIButton alloc]initWithFrame:CGRectMake(200*SIZE, 5*SIZE, 120*SIZE, 35*SIZE)];
    [_choosebtn setTitle:@"选择权益人" forState:UIControlStateNormal];
    [_choosebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _choosebtn.backgroundColor = YJBlueBtnColor;
    _choosebtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    _choosebtn.layer.masksToBounds = YES;
    _choosebtn.layer.cornerRadius = 5*SIZE;
    [self.contentView addSubview:_choosebtn];
    
  
}

@end
