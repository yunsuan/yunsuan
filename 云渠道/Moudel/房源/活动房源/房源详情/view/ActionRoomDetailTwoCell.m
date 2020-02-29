//
//  ActionRoomDetailTwoCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ActionRoomDetailTwoCell.h"

@implementation ActionRoomDetailTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0 ; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        if (i == 0) {
            
            _oneL = label;
        }else if (i == 1){
            
            _twoL = label;
            _twoL.textAlignment = NSTextAlignmentRight;
        }
    }
    
    [self.contentView addSubview:_oneL];
    [self.contentView addSubview:_twoL];
    
    [_oneL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_twoL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
}

@end
