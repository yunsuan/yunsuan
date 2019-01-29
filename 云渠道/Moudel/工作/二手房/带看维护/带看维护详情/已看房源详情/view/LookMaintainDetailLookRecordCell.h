//
//  LookMaintainDetailLookRecordCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainDetailLookRecordCellBlock)(NSInteger index);

@interface LookMaintainDetailLookRecordCell : UITableViewCell

@property (nonatomic, copy) LookMaintainDetailLookRecordCellBlock lookMaintainDetailLookRecordCellBlock;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *isBuyL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
