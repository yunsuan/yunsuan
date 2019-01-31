//
//  LookMaintainDetailAddAppointRoomCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LookMaintainDetailAddAppointRoomModel.h"

#import "TagView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainDetailAddAppointRoomCell : UITableViewCell

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

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
