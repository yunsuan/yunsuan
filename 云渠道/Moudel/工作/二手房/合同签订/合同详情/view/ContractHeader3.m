//
//  ContractHeader3.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractHeader3.h"

@implementation ContractHeader3

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:(NSString *)reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.contractHeader3Block) {
        
        self.contractHeader3Block();
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.text = @"经办人信息";
    [self.contentView addSubview:_titleL];
    
    _AddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_AddBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_AddBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.contentView addSubview:_AddBtn];
    [_AddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-5 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-5 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(8 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-13 *SIZE);
    }];

}

@end
