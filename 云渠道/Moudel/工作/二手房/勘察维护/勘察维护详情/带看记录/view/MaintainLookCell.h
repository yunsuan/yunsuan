//
//  MaintainLookCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MaintainLookCell;

typedef void(^MaintainLookBlock)(NSInteger index);

@interface MaintainLookCell : UITableViewCell

@property (nonatomic, copy) MaintainLookBlock maintainLookBlock;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *lineView;

@end
