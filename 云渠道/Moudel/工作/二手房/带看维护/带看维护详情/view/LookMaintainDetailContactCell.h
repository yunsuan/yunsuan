//
//  LookMaintainDetailContactCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainDetailContactCellBlock)(NSInteger index,NSInteger btn);

@interface LookMaintainDetailContactCell : UITableViewCell

@property (nonatomic, copy) LookMaintainDetailContactCellBlock lookMaintainDetailContactCellBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UIButton *upBtn;

@property (nonatomic, strong) UIButton *downBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
