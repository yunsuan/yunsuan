//
//  NameSexImgCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "NameSexImgCell.h"

@implementation NameSexImgCell

- (void)initUI{
    
    self.contentL = [[UILabel alloc]init];
    self.contentL.font = [UIFont systemFontOfSize:13.3*SIZE];
//    self.contentL.numberOfLines = 0;
    self.contentL.textColor = YJTitleLabColor;
    [self.contentView addSubview:self.contentL];
    
    _sexImg = [[UIImageView alloc] init];
    _sexImg.image = [UIImage imageNamed:@"man"];
    _sexImg.hidden = YES;
    [self.contentView addSubview:_sexImg];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = YJBackColor;
    [self.contentView addSubview:self.lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27*SIZE);
        make.top.equalTo(self.contentView).offset(9*SIZE);
//        make.right.equalTo(self.contentView).offset(-27*SIZE);
        make.width.mas_equalTo(self.contentL.mj_textWith + 10 *SIZE);
        //
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentL.mas_right).offset(0*SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.height.mas_equalTo(14 *SIZE);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
