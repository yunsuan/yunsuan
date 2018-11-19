//
//  BaseCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseCollCell.h"

@implementation BaseCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _colorView = [[UIView alloc] init];
    [self.contentView addSubview:_colorView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
//    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-9 *SIZE);
    }];
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
