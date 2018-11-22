//
//  SecAllRoomTableCell4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomTableCell4.h"

@implementation SecAllRoomTableCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    NSArray *titleArr = @[@"近7日看房",@"累计看房",@"关注房源的人"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
        line.backgroundColor = YJBackColor;
        if (i != 0) {
            
            [self.contentView addSubview:line];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 19 *SIZE, SCREEN_Width / 3, 13 *SIZE)];
        label.textColor = YJBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 41 *SIZE, SCREEN_Width / 3, 11 *SIZE)];
        label1.textColor = YJ86Color;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = titleArr[i];
        
        switch (i) {
            case 0:
            {
                _daysL = label;
                [self.contentView addSubview:_daysL];
                _daysLabel = label1;
                [self.contentView addSubview:_daysLabel];
                break;
            }
            case 1:
            {
                _allL = label;
                [self.contentView addSubview:_allL];
                _allLabel = label1;
                [self.contentView addSubview:_allLabel];
                break;
            }
            case 2:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                _intentLabel = label1;
                [self.contentView addSubview:_intentLabel];
                break;
            }
            default:
                break;
        }
        
        
        //        [self.contentView addSubview:label1];
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_intentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240 *SIZE);
        make.top.equalTo(self.contentView).offset(45 *SIZE);
        make.width.equalTo(@(120 *SIZE));
        make.height.equalTo(@(11 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
