//
//  SecAllRoomStoreDetailCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecAllRoomStoreModel.h"
#import "SecAllRoomOfficeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecAllRoomStoreDetailCell : UITableViewCell

@property (nonatomic, strong) SecAllRoomStoreModel *model;

@property (nonatomic, strong) SecAllRoomOfficeModel *officeModel;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *highL;

@property (nonatomic, strong) UILabel *highTL;

@property (nonatomic, strong) UILabel *widthL;

@property (nonatomic, strong) UILabel *widthTL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *yearTL;

@end

NS_ASSUME_NONNULL_END
