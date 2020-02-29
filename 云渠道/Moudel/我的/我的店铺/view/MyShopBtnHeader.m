//
//  MyShopBtnHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopBtnHeader.h"

@implementation MyShopBtnHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
//        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.myShopBtnHeaderMoreBlock) {
        
        self.myShopBtnHeaderMoreBlock();
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.myShopBtnHeaderAddBlock) {
        
        self.myShopBtnHeaderAddBlock();
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
    [_moreBtn setTitle:@"推荐历史 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJ170Color forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
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
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-45 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(75 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
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
