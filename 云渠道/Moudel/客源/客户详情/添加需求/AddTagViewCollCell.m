//
//  AddTagViewCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddTagViewCollCell.h"

@interface AddTagViewCollCell ()

@end

@implementation AddTagViewCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.colorView];
        [self.contentView addSubview:self.displayLabel];
        [self.contentView addSubview:self.cancelBtn];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 1.7*SIZE;
        
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.deleteBtnBlock) {
        
        self.deleteBtnBlock((NSUInteger) self.tag);
    }
}

- (UILabel *)displayLabel{
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0*SIZE, 17 *SIZE, self.contentView.frame.size.width - 4 *SIZE, 12*SIZE)];
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        _displayLabel.font = [UIFont systemFontOfSize:13*SIZE];
        _displayLabel.textColor = COLOR(115, 115, 115, 1);
        _displayLabel.numberOfLines = 0;
    }
    return _displayLabel;
}

- (UIView *)colorView{
    
    if (!_colorView) {
        
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 7 *SIZE, self.bounds.size.width - 4 *SIZE, 30 *SIZE)];
        _colorView.backgroundColor = COLOR(213, 242, 255, 1);
    }
    return _colorView;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(self.bounds.size.width - 18 *SIZE, 0, 18 *SIZE, 18 *SIZE);
        [_cancelBtn setImage:[UIImage imageNamed:@"delete_3"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str{
    _displayLabel.text = str;
    if ([type isEqualToString:@"1"]) {
//        self.layer.borderWidth = 0.5*SIZE;
//        self.layer.borderColor = COLOR(181, 181, 181, 1).CGColor;
    }
    else
    {
        if ([str isEqualToString:@"住宅"]) {
            _colorView.backgroundColor = COLOR(213, 243, 255, 1);
            _displayLabel.textColor = COLOR(67, 171, 255, 1);
        }
        else if([str isEqualToString:@"写字楼"])
        {
            _colorView.backgroundColor = COLOR(235, 243, 237, 1);
            _displayLabel.textColor = COLOR(137, 199, 182, 1);
        }
        else if([str isEqualToString:@"商铺"])
        {
            _colorView.backgroundColor = COLOR(209, 243, 245, 1);
            _displayLabel.textColor = COLOR(43, 187, 197, 1);
        }
        else if([str isEqualToString:@"别墅"])
        {
            _colorView.backgroundColor = COLOR(255, 237, 211, 1);
            _displayLabel.textColor = COLOR(255, 190, 90, 1);
        }
        else
        {
            _colorView.backgroundColor = COLOR(229, 241, 255, 1);
            _displayLabel.textColor = COLOR(139, 188, 255, 1);
        }
    }
    
}

@end
