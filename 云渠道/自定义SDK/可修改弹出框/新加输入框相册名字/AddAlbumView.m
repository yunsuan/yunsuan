//
//  AddAlbumView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddAlbumView.h"

@implementation AddAlbumView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.addAlbumViewAddBlock) {
        
        if (_nameTF.textfield.text) {
            
            self.addAlbumViewAddBlock();
            [self removeFromSuperview];
        }else{
            
            
        }
    }
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.frame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 219 *SIZE, 250 *SIZE, 202 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 230 *SIZE, 16 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:17 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_titleL];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 62 *SIZE, 150 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_whiteView addSubview:_nameL];
    
    _nameTF = [[BorderTF alloc] initWithFrame:CGRectMake(28 *SIZE, 93 *SIZE, 200 *SIZE, 33 *SIZE)];
    [_whiteView addSubview:_nameTF];
    
    _cancenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancenBtn.frame = CGRectMake(0, 162 *SIZE, 125 *SIZE, 40 *SIZE);
    _cancenBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancenBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancenBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancenBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [_cancenBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
    [_whiteView addSubview:_cancenBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(125 *SIZE, 162 *SIZE, 125 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_whiteView addSubview:_confirmBtn];
}

@end
