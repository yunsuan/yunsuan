//
//  ActionRoomDetailThreeCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ActionRoomDetailThreeCell.h"

@implementation ActionRoomDetailThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0 ; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        if (i == 0) {
            
            _oneL = label;
        }else if (i == 1){
            
            _twoL = label;
            _twoL.textAlignment = NSTextAlignmentCenter;
        }else{
            
            _threeL = label;
            _threeL.textAlignment = NSTextAlignmentRight;
        }
    }
    
    [self.contentView addSubview:_oneL];
    [self.contentView addSubview:_twoL];
    [self.contentView addSubview:_threeL];
    
    [_oneL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
    
    [_twoL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
    
    [_threeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
    }];
}

@end
