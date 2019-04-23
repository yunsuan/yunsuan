//
//  AuthenBtnCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AuthenBtnCell.h"

@implementation AuthenBtnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.authenBtnCellCommitBtnBlock) {
        
        self.authenBtnCellCommitBtnBlock();
    }
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.authenBtnCellDimissionBtnBlock) {
        
        self.authenBtnCellDimissionBtnBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _commitBtn.frame = CGRectMake(21 *SIZE, 37 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 2 *SIZE;
    _commitBtn.backgroundColor = YJLoginBtnColor;
    [_commitBtn setTitle:@"重新认证" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(21 *SIZE);
        make.top.equalTo(self.contentView).offset(37 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    _dimissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _dimissionBtn.frame = CGRectMake(21 *SIZE, 87 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _dimissionBtn.layer.masksToBounds = YES;
    _dimissionBtn.layer.cornerRadius = 2 *SIZE;
    _dimissionBtn.backgroundColor = YJLoginBtnColor;
    [_dimissionBtn setTitle:@"离职" forState:UIControlStateNormal];
    [_dimissionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _dimissionBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_dimissionBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_dimissionBtn];

    [_dimissionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(21 *SIZE);
        make.top.equalTo(self->_commitBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-37 *SIZE);
    }];
}

@end
