//
//  ContractMainConCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractMainConCell.h"

@implementation ContractMainConCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.contentView.backgroundColor = COLOR(249, 249, 249, 1);
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.text = @"主体合同";
    [self.contentView addSubview:_titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"已上传 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJBlueBtnColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-6 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(66 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-18 *SIZE);
    }];
}

@end
