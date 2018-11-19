//
//  YJChooseViewCell.m
//  云渠道
//
//  Created by xiaoq on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "YJChooseViewCell.h"

@implementation YJChooseViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.displayLabel];
        [self.contentView addSubview:self.img];
        
        
    }
    return self;
}
// Configure the view for the selected state
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        _img.image = [UIImage imageNamed:@"selected"];
    }
    else{
        //非选中
        _img.image = [UIImage imageNamed:@"default"];
        
    }
    
    
    
}

- (UILabel *)displayLabel{
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(21*SIZE, 0, 260*SIZE/3-21*SIZE, 14*SIZE)];
        _displayLabel.textAlignment = NSTextAlignmentLeft;
        _displayLabel.font = [UIFont systemFontOfSize:14*SIZE];
        _displayLabel.textColor = COLOR(115, 115, 115, 1);
    }
    return _displayLabel;
}

-(UIImageView *)img
{
    if (!_img) {
        _img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default"]];
        _img.frame = CGRectMake(0, 0, 14*SIZE, 14*SIZE);
    }
    return _img;
}

@end
