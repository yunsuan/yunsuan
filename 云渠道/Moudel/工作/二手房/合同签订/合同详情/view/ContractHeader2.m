//
//  ContractHeader2.m
//  云渠道
//
//  Created by xiaoq on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractHeader2.h"

@implementation ContractHeader2

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.contractHeaderBlock) {
        
        self.contractHeaderBlock(btn.tag);
    }
}

- (void)initUI{
    
    self.backgroundColor = YJBackColor;
    
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0+120*SIZE*i, 0, 119*SIZE, 47*SIZE);
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            _buyBtn = btn;
            [self addSubview:_buyBtn];
        }else if (i == 1){
            
            _sellBtn = btn;
            [self addSubview:_sellBtn];
        }else{
            
            _infoBtn = btn;
            [self addSubview:_infoBtn];
        }
    }
    
}


@end
