//
//  SecAllRoomTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecAllRoomProjectModel.h"
#import "SecAllRoomOfficeModel.h"


@interface SecAllRoomTableCell : UITableViewCell

@property (nonatomic, strong) SecAllRoomProjectModel *model;

@property (nonatomic, strong) SecAllRoomOfficeModel *officeModel;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *proLimitL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;


@end
