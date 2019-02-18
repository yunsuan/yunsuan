//
//  MainContractCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MainContractCell.h"

@implementation MainContractCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.mainContractCellBlock) {
        
        self.mainContractCellBlock(self.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _bigImg = [[UIImageView alloc] init];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    [self.contentView addSubview:_bigImg];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImage:[UIImage imageNamed:@"delete_3"] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
    
    [_bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(83 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
}

@end
