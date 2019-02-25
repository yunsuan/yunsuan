//
//  singleviewCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "singleviewCell.h"

@implementation singleviewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.displayLabel];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 1.7*SIZE;

    }
    return self;
}

- (UILabel *)displayLabel{
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.contentView.frame.size.height-11*SIZE)/2, self.contentView.frame.size.width, 11*SIZE)];
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        _displayLabel.font = [UIFont systemFontOfSize:10.7*SIZE];
        _displayLabel.textColor = COLOR(115, 115, 115, 1);
    }
    return _displayLabel;
}

-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str{
    
    _displayLabel.text = str;
    _displayLabel.frame = CGRectMake(0, (self.contentView.frame.size.height-11*SIZE)/2, 12*SIZE * str.length + 4.7*SIZE *2, 11*SIZE);
    if ([type isEqualToString:@"1"]) {
        self.layer.borderWidth = 0.5*SIZE;
        self.layer.borderColor = COLOR(181, 181, 181, 1).CGColor;
    }
    else
    {
        if ([str isEqualToString:@"住宅"]) {
            self.backgroundColor = COLOR(213, 243, 255, 1);
            _displayLabel.textColor = COLOR(67, 171, 255, 1);
        }
        else if([str isEqualToString:@"写字楼"])
        {
            self.backgroundColor = COLOR(235, 243, 237, 1);
            _displayLabel.textColor = COLOR(137, 199, 182, 1);
        }
        else if([str isEqualToString:@"商铺"])
        {
            self.backgroundColor = COLOR(209, 243, 245, 1);
            _displayLabel.textColor = COLOR(43, 187, 197, 1);
        }
        else if([str isEqualToString:@"别墅"])
        {
            self.backgroundColor = COLOR(255, 237, 211, 1);
            _displayLabel.textColor = COLOR(255, 190, 90, 1);
        }
        else
        {
            self.backgroundColor = COLOR(229, 241, 255, 1);
            _displayLabel.textColor = COLOR(139, 188, 255, 1);
        }
    }
    
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = size.height;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}

@end
