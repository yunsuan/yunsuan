//
//  MyShopCustomCommentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/29.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopCustomCommentCell.h"

@implementation MyShopCustomCommentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.font = [UIFont systemFontOfSize:11 *SIZE];
    _titleL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.textColor = YJTitleLabColor;
    _contentL.numberOfLines = 0;
    _contentL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_contentL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(160 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-5 *SIZE);
    }];
}

@end
