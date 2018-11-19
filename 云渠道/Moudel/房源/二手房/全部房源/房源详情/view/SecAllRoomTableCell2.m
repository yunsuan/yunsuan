//
//  SecAllRoomTableCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomTableCell2.h"

@implementation SecAllRoomTableCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTap{
    
    if (self.lookRecordBlock) {
        
        self.lookRecordBlock();
    }
}

- (void)initUI{
    
    NSArray *titleArr = @[@"近7日看房",@"累计看房",@"关注房源的人"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(screenWidth / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
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
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 75 *SIZE, 60 *SIZE, 11 *SIZE)];
    label2.textColor = YJ86Color;
    label2.font = [UIFont systemFontOfSize:12 *SIZE];
    label2.text = @"看房记录";
    [self.contentView addSubview:label2];
    
    _recentL = [[UILabel alloc] init];
    _recentL.textColor = YJ170Color;
    _recentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _recentL.textAlignment = NSTextAlignmentRight;
    _recentL.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [_recentL addGestureRecognizer:tap];
    [self.contentView addSubview:_recentL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_recentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self.contentView).offset(77 *SIZE);
        make.width.equalTo(@(250 *SIZE));
        make.height.equalTo(@(10 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
}

@end
