//
//  SingleContentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SingleContentCell.h"

@implementation SingleContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:13.3*SIZE];
    _contentL.numberOfLines = 0;
    _contentL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_contentL];
    
    _textContent = [[UITextView alloc] init];
    _textContent.font = [UIFont systemFontOfSize:13.3*SIZE];
    _textContent.editable = NO;
    _textContent.scrollEnabled = NO;
    _textContent.textContainer.lineFragmentPadding = 0;
    _textContent.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_textContent];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27*SIZE);
        make.top.equalTo(self.contentView).offset(9*SIZE);
        make.right.equalTo(self.contentView).offset(-27*SIZE);
    }];
    
    [_textContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27*SIZE);
        make.top.equalTo(self.contentView).offset(9*SIZE);
        make.right.equalTo(self.contentView).offset(-27*SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_contentL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}
@end
