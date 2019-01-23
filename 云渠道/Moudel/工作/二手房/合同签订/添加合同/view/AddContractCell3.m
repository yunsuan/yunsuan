//
//  AddContractCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell3.h"

@implementation AddContractCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _choosebtn = [[UIButton alloc]initWithFrame:CGRectMake(120*SIZE, 5*SIZE, 120*SIZE, 35*SIZE)];
    [_choosebtn setTitle:@"选择房源" forState:UIControlStateNormal];
    [_choosebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _choosebtn.backgroundColor = YJBlueBtnColor;
    _choosebtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    _choosebtn.layer.masksToBounds = YES;
    _choosebtn.layer.cornerRadius = 5*SIZE;
    [self.contentView addSubview:_choosebtn];
    

}

@end
