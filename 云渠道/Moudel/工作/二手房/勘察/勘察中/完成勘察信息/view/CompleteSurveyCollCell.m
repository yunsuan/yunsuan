//
//  CompleteSurveyCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteSurveyCollCell.h"

@implementation CompleteSurveyCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

//- (void)setSelected:(BOOL)selected{
//
//    selected = !selected;
//    if (selected) {
//
//        _selectImg.image = [UIImage imageNamed:@"choose"];
//    }else{
//
//        _selectImg.image = [UIImage imageNamed:@"unselected"];
//    }
//}
- (void)setIsSelect:(NSInteger)isSelect{
    
    if (self.tag == 1) {
        
        if (isSelect == 0) {
            
            _selectImg.image = [UIImage imageNamed:@"default"];
        }else{
            
            _selectImg.image = [UIImage imageNamed:@"selected"];
        }
    }else{
        
        if (isSelect == 0) {
            
            _selectImg.image = [UIImage imageNamed:@"unselected"];
        }else{
            
            _selectImg.image = [UIImage imageNamed:@"choose"];
        }
    }
}

- (void)initUI{
    
    _selectImg = [[UIImageView alloc] init];
    _selectImg.image = [UIImage imageNamed:@"unselected"];
    [self.contentView addSubview:_selectImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(14 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-5 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
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
