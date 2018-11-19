//
//  LicenceCell.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "LicenceCell.h"

@implementation LicenceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titlelab = [[UILabel alloc]init];
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont systemFontOfSize:13.3*SIZE];
        [self.contentView addSubview:_titlelab];
        [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10*SIZE);
            make.top.equalTo(self.contentView).offset(13.7*SIZE);
            make.width.mas_equalTo(200*SIZE);
            make.bottom.equalTo(self.contentView).offset(-9*SIZE);
        }];
        _contentlab = [[UILabel alloc]init];
        _contentlab.textAlignment = NSTextAlignmentRight;
        _contentlab.font = [UIFont systemFontOfSize:13.3*SIZE];
        _contentlab.numberOfLines = 0;
        _contentlab.lineBreakMode = NSLineBreakByCharWrapping;
        //    [_contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _contentlab.textColor = YJTitleLabColor;
        [self.contentView addSubview:_contentlab];
//            __weak typeof(self)weakSelf=self;
        [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlelab).offset(240*SIZE);
            make.top.equalTo(self.titlelab);
            make.width.mas_equalTo(100*SIZE);
            make.height.mas_equalTo(13.3*SIZE);
        }];
        
    }
    
    return self;
}

-(void)settitle:(NSString *)title content:(NSString *)content
{
    _titlelab.text = title;
    _contentlab.text = content;
}


@end
