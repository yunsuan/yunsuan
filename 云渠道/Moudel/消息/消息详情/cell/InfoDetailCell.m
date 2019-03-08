//
//  InfoDetailCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "InfoDetailCell.h"

@implementation InfoDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.infoDetailCellBlock) {
        
        self.infoDetailCellBlock();
    }
}

-(void)initUI
{
    _contentlab = [[UILabel alloc]init];
    _contentlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _contentlab.numberOfLines = 0;
    _contentlab.lineBreakMode = NSLineBreakByCharWrapping;
//    [_contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _contentlab.textColor = YJContentLabColor;
    [self.contentView addSubview:_contentlab];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看确认流程" forState:UIControlStateNormal];
    _moreBtn.backgroundColor = YJBlueBtnColor;
    _moreBtn.layer.cornerRadius = 2 *SIZE;
    _moreBtn.clipsToBounds = YES;
    [self.contentView addSubview:_moreBtn];

    [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(28.3*SIZE);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(300 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15*SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(260 *SIZE);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(90 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

-(void)SetCellContentbystring:(NSString *)str
{
    _contentlab.text = str;
    if ([str containsString:@"到访确认人"]) {
        
        _moreBtn.hidden = NO;
        [_contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(28.3*SIZE);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(250*SIZE);
            make.bottom.equalTo(self.contentView).offset(-15*SIZE);
        }];
    }else{
        
        _moreBtn.hidden = YES;
        [_contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(28.3*SIZE);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(300 *SIZE);
            make.bottom.equalTo(self.contentView).offset(-15*SIZE);
        }];
    }
}

-(CGFloat)calculateTextHeight
{
    return self.contentlab.frame.size.height +15*SIZE;
}

@end
