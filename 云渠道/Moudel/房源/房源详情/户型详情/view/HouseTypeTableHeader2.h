//
//  HouseTypeTableHeader2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HouseTypeTableHeader2;

typedef void(^HouseTypeTableHeader2Block)(void);

@interface HouseTypeTableHeader2 : UITableViewHeaderFooterView

@property (nonatomic, strong) HouseTypeTableHeader2Block houseTypeTableHeader2Block;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *moreBtn;

@end
