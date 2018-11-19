//
//  RoomDetailTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableCell.h"

@implementation RoomDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 8 *SIZE, 100 *SIZE, 15 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"楼盘信息";
    [self.contentView addSubview:label];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 7 *SIZE, 65 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *sIZE];
//    [_moreBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    NSArray *titleArr = @[@"开发商：",@"最新开盘：",@"交房时间：",@"产权："];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 42 *SIZE + i * 31 *SIZE, 63 *SIZE, 11 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.text = titleArr[i];
        if (i != 3) {
            
            [self.contentView addSubview:label];
        }
        
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.textColor = YJTitleLabColor;
        label2.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _developL = label2;
                [self.contentView addSubview:_developL];
                break;
            }
            case 1:
            {
                _openL = label2;
                [self.contentView addSubview:_openL];
                break;
            }
            case 2:
            {
                _payL = label2;
                [self.contentView addSubview:_payL];
                break;
            }
            case 3:
            {
                _timeL = label2;
                [self.contentView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonyUI];
}

- (void)MasonyUI{

    [_developL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(76 *SIZE);
        make.top.equalTo(self.contentView).offset(42 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(_openL.mas_top).offset(-16 *SIZE);
    }];
    
    [_openL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(76 *SIZE);
        make.top.equalTo(_developL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(_payL.mas_top).offset(-16 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(76 *SIZE);
        make.top.equalTo(_openL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(_timeL.mas_top).offset(-16 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(76 *SIZE);
        make.top.equalTo(_payL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
}

@end
