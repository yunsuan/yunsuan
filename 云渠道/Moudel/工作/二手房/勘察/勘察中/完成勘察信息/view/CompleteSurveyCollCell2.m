//
//  CompleteSurveyCollCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteSurveyCollCell2.h"

@interface CompleteSurveyCollCell2()<UITextViewDelegate>


@end

@implementation CompleteSurveyCollCell2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (self.completeSurveyCollCell2Block) {
        
        self.completeSurveyCollCell2Block(textView.text);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _contentTV = [[UITextView alloc] init];
    _contentTV.textColor = YJContentLabColor;
    _contentTV.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentTV.delegate = self;
//    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_contentTV];
    
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(3 *SIZE);
        make.right.equalTo(self.contentView).offset(-28 *SIZE);
        make.height.mas_equalTo(60 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-SIZE);
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
