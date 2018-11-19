//
//  PersonalTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PersonalSwitchBlock)(void);

@interface PersonalTableCell : UITableViewCell

@property (nonatomic, copy) PersonalSwitchBlock personalSwitchBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIImageView *rightView;

@property (nonatomic, strong) UISwitch *OnOff;

@end
