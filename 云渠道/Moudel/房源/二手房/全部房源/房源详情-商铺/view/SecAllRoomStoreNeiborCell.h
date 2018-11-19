//
//  SecAllRoomStoreNeiborCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecAllRoomStoreModel.h"
#import "SecAllRoomOfficeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecAllRoomStoreNeiborCell : UITableViewCell

@property (nonatomic, strong) SecAllRoomStoreModel *model;

@property (nonatomic, strong) SecAllRoomOfficeModel *officeModel;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *leftL;

@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UILabel *rightL;

@property (nonatomic, strong) UIImageView *centerImg;

@property (nonatomic, strong) UILabel *centerL;

@property (nonatomic, strong) UIImageView *rightImg;

@end

NS_ASSUME_NONNULL_END
