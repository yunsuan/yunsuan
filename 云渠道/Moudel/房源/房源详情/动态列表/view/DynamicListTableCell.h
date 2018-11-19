//
//  DynamicListTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DynamicListTableCell;

typedef void(^cellBtnBlock)(NSInteger index);

@interface DynamicListTableCell : UITableViewCell

@property (nonatomic, copy) cellBtnBlock cellBtnBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contentL;

@end
