//
//  AreaCustomDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomDetailHeader.h"

@interface AreaCustomDetailHeader ()
{
    
    NSArray *_titleArr;
}

@end

@implementation AreaCustomDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleArr = @[@"新房 0",@"租房 0",@"二手房 0"];
        [self initUI];
    }
    return self;
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.areaCustomDetailHeaderTagBlock) {

        self.areaCustomDetailHeaderTagBlock(btn.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn setTitle:_titleArr[(NSUInteger) i] forState:UIControlStateNormal];
        [btn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:YJ86Color forState:UIControlStateNormal];
        if (i == 0) {
            
            _projectBtn = btn;
            [self.contentView addSubview:_projectBtn];
        }else if (i == 1){
            
            _rentBtn = btn;
            [self.contentView addSubview:_rentBtn];
        }else{
            
            _secondBtn = btn;
            [self.contentView addSubview:_secondBtn];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_projectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_rentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
