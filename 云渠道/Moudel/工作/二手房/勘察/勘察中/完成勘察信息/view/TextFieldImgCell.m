//
//  TextFieldImgCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TextFieldImgCell.h"

@implementation TextFieldImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionNameBtn:(UIButton *)btn{
    
    if (self.textFieldImgCellBlock) {
        
        self.textFieldImgCellBlock(_nameL.text);
    }
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.text = @"输入图片名称";
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nameBtn.frame = _nameL.frame;
    [_nameBtn addTarget:self action:@selector(ActionNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_nameBtn];
    
    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 183 *SIZE)];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    [self.contentView addSubview:_bigImg];
    
}

@end
