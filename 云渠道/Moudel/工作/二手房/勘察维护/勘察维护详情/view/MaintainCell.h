//
//  MaintainCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MaintainCell;

typedef void(^MaintainCellBlock)(NSInteger index,NSInteger btn);


@interface MaintainCell : UITableViewCell

@property (nonatomic, copy) MaintainCellBlock maintainCellBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *upBtn;

@property (nonatomic, strong) UIButton *downBtn;

@end
