//
//  RentingMaintainDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashesLineView.h"

@class RentingMaintainDetailHeader;

typedef void(^RentingMaintainTagHeaderBlock)(NSInteger index);

typedef void(^RentingMaintainDetailHeaderBlock)(void);

@interface RentingMaintainDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) RentingMaintainTagHeaderBlock rentingMaintainTagHeaderBlock;

@property (nonatomic, copy) RentingMaintainDetailHeaderBlock rentingMaintainDetailHeaderBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UIView *codeView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UILabel *minRent;

@property (nonatomic, strong) UILabel *maxRent;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) DashesLineView *dashesLine;

@property (nonatomic, strong) UILabel *RePriceL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *periodL;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *advantageBtn;

@property (nonatomic, strong) UIButton *followBtn;

@end
