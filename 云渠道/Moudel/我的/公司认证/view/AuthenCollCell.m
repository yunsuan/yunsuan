//
//  AuthenCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenCollCell.h"

@implementation AuthenCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.authenCollCellDeleteBlock) {
        
        self.authenCollCellDeleteBlock();
    }
}

- (void)initUI{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 100 *SIZE, 83 *SIZE)];
    _imageView.image =[UIImage imageNamed:@"add_3"];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_cancelBtn setBackgroundColor:YJGreenColor];
    _cancelBtn.frame = CGRectMake(95 *SIZE, 0, 20 *SIZE, 20 *SIZE);
    [_cancelBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    [self.contentView addSubview:_cancelBtn];
}

@end
