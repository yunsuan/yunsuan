//
//  SecAllRoomTableCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecAllRoomProjectModel.h"
#import "SecAllRoomStoreModel.h"
#import "SecAllRoomOfficeModel.h"

@interface SecAllRoomTableCell3 : UITableViewCell

@property (nonatomic, strong) SecAllRoomStoreModel *storeModel;

@property (nonatomic, strong) SecAllRoomOfficeModel *officeModel;

@property (nonatomic, strong) SecAllRoomProjectModel *model;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UIImageView *roomImg;

@end
