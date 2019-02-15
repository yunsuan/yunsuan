//
//  BlueTitleMoreHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BlueTitleMoreHeader.h"

@implementation BlueTitleMoreHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
//        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.blueTitleMoreHeaderBlock) {
        
        self.blueTitleMoreHeaderBlock();
    }
}


- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.colorView = [[UIView alloc] init];//WithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    self.colorView.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:self.colorView];
    
    self.titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(28 *SIZE, 13 *SIZE, 230 *SIZE, 15 *SIZE)];
    self.titleL.textColor = YJTitleLabColor;
    self.titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:self.titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJ170Color forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    self.lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width , SIZE)];
    self.lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:self.lineView];
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(30 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(270 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(75 *SIZE);
        make.height.mas_equalTo(21 *SIZE);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(39 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}


@end
