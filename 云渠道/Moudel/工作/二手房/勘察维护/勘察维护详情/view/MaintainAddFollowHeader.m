//
//  MaintainAddFollowHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainAddFollowHeader.h"

@implementation MaintainAddFollowHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.maintainAddFollowHeaderBlock) {
        
        self.maintainAddFollowHeaderBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"添加跟进" forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"add_3-1"] forState:UIControlStateNormal];
    [_addBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

@end
