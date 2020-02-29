//
//  MyShopAddressL.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopAddressL.h"

@interface MyShopAddressL ()<UITextFieldDelegate>

@end

@implementation MyShopAddressL

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionEditBtn:(UIButton *)btn{

    if (self.myShopAddressLBlock) {
        
        self.myShopAddressLBlock(self.tag);
    }
}



- (void)initUI{
    
    _addressTF = [[UILabel alloc] init];
    _addressTF.font = [UIFont systemFontOfSize:11 *SIZE];
    _addressTF.textColor = YJContentLabColor;
    _addressTF.numberOfLines = 0;
    [self.contentView addSubview:_addressTF];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(250 *SIZE, 0, 20 *SIZE, 20 *SIZE);
    [_editBtn setImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_editBtn];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(240 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
