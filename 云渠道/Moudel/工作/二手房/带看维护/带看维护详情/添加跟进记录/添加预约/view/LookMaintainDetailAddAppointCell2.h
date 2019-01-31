//
//  LookMaintainDetailAddAppointCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/31.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LookMaintainDetailAddAppointRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainDetailAddAppointCell2 : UITableViewCell

@property (nonatomic, strong) LookMaintainDetailAddAppointRoomModel *model;

@property (nonatomic, strong) UIView *hideView;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *averageL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
