//
//  LookMaintainDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) BaseHeader *customHeader;

@property (nonatomic, strong) UIView *systemView;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *followTimeL;

@property (nonatomic, strong) UILabel *customLevelL;

@property (nonatomic, strong) UILabel *matchL;

@property (nonatomic, strong) UILabel *progressL;

@property (nonatomic, strong) UIView *needView;

@property (nonatomic, strong) BaseHeader *needHeader;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UIButton *roomBtn;

@property (nonatomic, strong) UIButton *contactBtn;

@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) NSMutableArray *dataDic;

@end

NS_ASSUME_NONNULL_END
