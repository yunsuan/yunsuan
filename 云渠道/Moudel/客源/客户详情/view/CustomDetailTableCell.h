//
//  CustomDetailTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomRequireModel.h"

@class CustomDetailTableCell;

typedef void(^editBlock)(NSInteger index);

@interface CustomDetailTableCell : UITableViewCell

@property (nonatomic, copy) void (^editBlock)(NSUInteger);

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *proType;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *standardL;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *intentionL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) CustomRequireModel *model;

@end
