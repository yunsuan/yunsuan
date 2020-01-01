//
//  CompleteCustomCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/1/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "CompleteCustomCollCell.h"

@interface CompleteCustomCollCell ()<UITextFieldDelegate>

@end

@implementation CompleteCustomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

//- (void)textViewDidEndEditing:(UITextView *)textView{
//
//    if (self.completeSurveyCollCell2Block) {
//
//        self.completeSurveyCollCell2Block(textView.text);
//    }
//}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (![self isEmpty:_contentTF.textfield.text]) {
        
        if (self.completeCustomCollCellBlock) {
            
            self.completeCustomCollCellBlock(_contentTF.textfield.text);
        }
        _contentTF.textfield.text = @"";
    }
}

//判断字符串为空
- (BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _contentTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _contentTF.textfield.textColor = YJContentLabColor;
    _contentTF.textfield.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentTF.textfield.delegate = self;
    _contentTF.textfield.placeholder = @"自定义标签";
//    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_contentTF];
    
    _comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_comfirmBtn setBackgroundColor:YJBlueBtnColor];
    _comfirmBtn.layer.cornerRadius = 15 *SIZE;
    _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_comfirmBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [_comfirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_comfirmBtn];
    
    [_contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(3 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-SIZE);
    }];
    
    [_comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(210 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
//
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//
//    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
//    CGRect cellFrame = layoutAttributes.frame;
//    cellFrame.size.height = size.height;
//    layoutAttributes.frame = cellFrame;
//    return layoutAttributes;
//}

@end
